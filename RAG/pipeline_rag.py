"""Retrieval layer over the valuation corpus.

Lives in RAG/ beside the corpus markdown it reads. Imported by both the development
notebook in this folder and the question pipeline one level up, so there is one definition
of chunking, embedding and search rather than two copies that drift.

Usage, from the notebook in this folder:
    import rag

Usage, from the pipeline one level up:
    import sys; sys.path.insert(0, "RAG")
    import rag

Then:
    for score, chunk in rag.search("why is the automobile add-back 25 percent?"):
        print(score, chunk["id"], chunk["heading"])

Importing is cheap: chunks are built at import, but the embedding model loads on first
search. Set the RAG_DIR environment variable if the corpus lives elsewhere.
"""

import re
import json
import hashlib
import os
from pathlib import Path

# --- configuration ----------------------------------------------------------------

# Corpus lives beside this module. Anchored to the file's own location rather than the
# working directory, so it resolves identically whether imported from the notebook in this
# folder or from the pipeline one level up. Override with the RAG_DIR environment variable.
_HERE   = Path(__file__).resolve().parent
RAG_DIR = Path(os.environ.get("RAG_DIR", _HERE))

SOURCES = {
    "method":  RAG_DIR / "Method_Standards.md",
    "roselle": RAG_DIR / "Roselle_Engagement.md",
}

CLIENT      = "roselle"     # this deployment serves one client; the gate is enforced anyway
EMBED_MODEL = "sentence-transformers/all-MiniLM-L6-v2"

# Chunk sizing is set by the embedding model's 512-token ceiling: anything longer is
# truncated, so the vector stops representing the tail of the chunk.
MAX_SEGMENT, OVERSIZED = 1400, 2000

# Client identifiers that must never appear in a shared-corpus chunk.
FINGERPRINT = re.compile(
    r'Seybold|Chang|Hassenplug|Roselle|9,114|200,115|199,992|195,700|20,881|133,851')


# --- chunking ---------------------------------------------------------------------

def _pack(paragraphs, limit):
    """Group whole paragraphs into segments under `limit` chars. Never splits a paragraph."""
    segs, cur = [], []
    for p in paragraphs:
        cand = cur + [p]
        if cur and sum(len(x) for x in cand) + 2 * len(cur) > limit:
            segs.append(cur)
            cur = [p]
        else:
            cur = cand
    if cur:
        segs.append(cur)
    return segs


def build_chunks():
    """Parse both corpora into chunks.

    Corpus membership comes from the file a chunk came from, never from its heading.
    That is what keeps client content out of the shared set: a heading can be edited,
    a source path cannot be edited by accident.
    """
    out = []
    for corpus, path in SOURCES.items():
        # encoding="utf-8" is not optional. The platform default (cp1252 on Windows)
        # turns every em dash into "a€"", which then gets embedded and quietly
        # degrades the vectors.
        text = Path(path).read_text(encoding="utf-8")
        h2 = None

        # Split BEFORE each level-2/3 heading. \n(?=...) is a lookahead: it consumes the
        # newline but leaves the "##" attached to its section.
        for part in re.split(r'\n(?=#{2,3} )', text):
            part = part.strip()
            if not part.startswith('#'):
                continue

            line    = part.split('\n', 1)[0]
            level   = len(line) - len(line.lstrip('#'))
            heading = line.lstrip('# ').strip()
            if level == 2:
                h2, crumb = heading, heading
            else:
                crumb = f"{h2} > {heading}" if h2 else heading

            body = part.split('\n', 1)[1].strip() if '\n' in part else ''
            if not body:
                continue                       # bare heading survives in children's crumbs

            pieces = [{"heading": crumb, "text": f"{crumb}\n\n{body}"}]
            if len(pieces[0]["text"]) > OVERSIZED:
                pieces = []
                for i, seg in enumerate(_pack(body.split("\n\n"), MAX_SEGMENT)):
                    lab = crumb if i == 0 else f"{crumb} (cont. {i + 1})"
                    pieces.append({"heading": lab, "text": f"{lab}\n\n" + "\n\n".join(seg)})

            for p in pieces:
                p["client"] = None if corpus == "method" else corpus
                p["source"] = str(path)
                out.append(p)

    # ids encode the corpus, so a citation shows at a glance which document it came from
    counters = {}
    for c in out:
        pre = "method" if c["client"] is None else c["client"]
        counters[pre] = counters.get(pre, -1) + 1
        c["id"] = f"{pre}-{counters[pre]:02d}"
    return out


def corpus_hash():
    """Fingerprint the markdown on disk.

    Chunks and vectors are derived from these files. If the files change and the
    derivatives do not, search returns a chunk whose text no longer matches the vector
    that matched it -- silent, and plausible enough to miss.
    """
    blob = "".join(Path(p).read_text(encoding="utf-8") for p in sorted(map(str, SOURCES.values())))
    return hashlib.sha256(blob.encode("utf-8")).hexdigest()[:12]


def check_invariants(chunk_list):
    """Halt rather than proceed on a corpus that violates its guarantees."""
    leaked = [c["id"] for c in chunk_list
              if c["client"] is None and FINGERPRINT.search(c["text"])]
    assert not leaked, f"client data in shared corpus: {leaked}"
    assert all(len(c["text"]) <= OVERSIZED for c in chunk_list), "a chunk is oversized"
    assert len({c["id"] for c in chunk_list}) == len(chunk_list), "duplicate chunk ids"
    assert all(c["heading"] in c["text"] for c in chunk_list), "breadcrumb missing from text"


def save(path=None):
    """Persist chunks with the hash of the corpus they came from.

    Defaults beside the corpus, so the file lands in the same place regardless of which
    notebook called it.
    """
    path = Path(path) if path else RAG_DIR / "chunks.json"
    path.write_text(
        json.dumps({"corpus_hash": CORPUS_HASH, "chunks": chunks},
                   indent=2, ensure_ascii=False),
        encoding="utf-8")
    return str(path)


chunks      = build_chunks()
CORPUS_HASH = corpus_hash()
check_invariants(chunks)
by_id       = {c["id"]: c for c in chunks}


# --- embedding (loaded on first use) ----------------------------------------------

_model = _tokenizer = _device = None
_embeddings = _head_vecs = None


def _ensure_ready():
    """Load the model and embed the corpus. Deferred so `import rag` stays instant."""
    global _model, _tokenizer, _device, _embeddings, _head_vecs
    if _embeddings is not None:
        return

    import torch
    from transformers import AutoTokenizer, AutoModel

    # A tokenizer and its model are a matched pair -- each model was trained against one
    # vocabulary, and pairing a mismatched one produces plausible garbage, not an error.
    _tokenizer = AutoTokenizer.from_pretrained(EMBED_MODEL)
    _model     = AutoModel.from_pretrained(EMBED_MODEL)

    # eval() disables dropout. Without it the same text embeds slightly differently on
    # each call -- nothing fails, results are just quietly non-reproducible.
    _model.eval()
    _device = "cuda" if torch.cuda.is_available() else "cpu"
    _model.to(_device)

    _embeddings = embed([c["text"] for c in chunks])
    _head_vecs  = embed([c["heading"] for c in chunks])


def embed(texts):
    """Tokenize -> forward pass -> masked mean pool -> L2 normalize."""
    import torch
    if _model is None:
        _ensure_ready()

    enc = _tokenizer(texts, padding=True, truncation=True,
                     max_length=512, return_tensors="pt")
    enc = {k: v.to(_device) for k, v in enc.items()}
    with torch.no_grad():
        out = _model(**enc)

    mask   = enc["attention_mask"].unsqueeze(-1).expand(out.last_hidden_state.size()).float()
    pooled = (out.last_hidden_state * mask).sum(1) / mask.sum(1).clamp(min=1e-9)
    return torch.nn.functional.normalize(pooled, p=2, dim=1)


# --- search -----------------------------------------------------------------------

def search(question, k=4, client=CLIENT, floor=(2, 2)):
    """Return [(score, chunk)] for the top k chunks reachable by `client`.

    floor = (min method chunks, min client chunks). Set floor=None for pure top-k.
    """
    import torch
    assert floor is None or sum(floor) <= k, \
        f"floor {floor} needs k >= {sum(floor)}, got k={k}"
    assert corpus_hash() == CORPUS_HASH, \
        "corpus files changed since import -- restart the kernel to rebuild"

    _ensure_ready()

    q    = embed([question])
    body = (q @ _embeddings.T)[0]        # full text: catches specifics
    head = (q @ _head_vecs.T)[0]         # heading only: catches topics
    best = torch.maximum(body, head)     # judge each chunk on its better evidence

    # Other clients' chunks become unreachable at any ranking.
    allowed = [i for i, c in enumerate(chunks) if c["client"] in (None, client)]
    gate = torch.full_like(best, float("-inf"))
    gate[allowed] = 0.0
    best = best + gate

    # Drop gated chunks BEFORE slot filling: -inf still sorts, so a floor asking for
    # "the top n client chunks" would otherwise reach around the gate and pull blocked ones.
    order = [i for i in best.argsort(descending=True).tolist() if best[i] > float("-inf")]

    if floor is None:
        top = order[:k]
    else:
        n_m, n_c = floor
        m = [i for i in order if chunks[i]["client"] is None][:n_m]
        c = [i for i in order if chunks[i]["client"] is not None][:n_c]
        top = sorted(set(m + c), key=order.index)

        # Reserved slots are a minimum per corpus, not a quota. When one corpus is
        # unavailable (client=None) or thin, backfill best-first from what is left.
        for i in order:
            if len(top) >= k:
                break
            if i not in top:
                top.append(i)
        top = sorted(set(top), key=order.index)[:k]

    # Isolation is an invariant, not a hope. An unchecked guarantee is a comment.
    allowed_set = set(allowed)
    assert all(i in allowed_set for i in top), \
        f"isolation breach: {[chunks[i]['id'] for i in top if i not in allowed_set]}"

    return [(float(best[i]), chunks[i]) for i in top]


def summary():
    shared = sum(1 for c in chunks if c["client"] is None)
    return (f"corpus {CORPUS_HASH} | {len(chunks)} chunks "
            f"({shared} shared, {len(chunks) - shared} client) | model {EMBED_MODEL}")


if __name__ == "__main__":
    print(summary())
    for s, c in search("Why is the automobile add-back only 25 percent?"):
        print(f"  {s:.3f}  {c['id']:<12} {c['heading'][:55]}")
