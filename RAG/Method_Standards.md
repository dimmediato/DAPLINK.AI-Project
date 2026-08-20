# Valuation Method Standards
**Firm methodology for dental practice normalized-earnings analysis**

Reusable across engagements. Contains no client figures. Every rule here applies
identically to any practice; client-specific amounts, reconciliations and findings belong
in that engagement's own record.

**Provenance marks.** Every rule below carries a mark showing where it came from. The
shared corpus is the half where a wrong claim compounds across clients, so a rule that was
reasoned must not wear the same formatting as a rule that was read.

| Mark | Meaning |
|---|---|
| `[doc]` | Stated in the SDE Methodology Decision Record, at the cited section. The Record is itself reconstructed from ledger detail, P&L, and returns; it is the nearest primary source available here. |
| `[instr]` | Determined by the engagement analyst from knowledge of the practice, not derivable from the supplied files. |
| `[ext]` | General external fact — tax law, published rates — not specific to any engagement. |
| `[infer]` | Reasoned from evidence but not stated in any source. Defensible, unverified. Review these first. |

Section 8 lists every `[instr]` and `[infer]` rule in one place for review.

---

## 1. Choosing the measure before computing anything

The measure must be selected from the question being asked, and stated before any figure is
quoted. `[doc · DR §1]`

| Question | Measure | Owner compensation treatment |
|---|---|---|
| Is the business profitable once the owner's labor is fairly paid? | normalized owner earnings (adjusted EBITDA) | normalize to market rate; add back only the excess |
| What total return is available to a single owner-operator? | Seller's Discretionary Earnings (SDE) | add back the working owner's entire compensation |

These produce materially different results from identical source documents. Full add-back
answers a broker's question and is uninformative to an owner who already knows their own
draw. Market normalization isolates whether the *business* earns a return once the
*clinician* is paid, and is the correct choice for an owner-diagnostic engagement.
`[doc · DR §1]`

**Labeling rule.** If the excess-over-market treatment is used, the output is not SDE as
the term is understood in practice sales. Label it normalized owner earnings. Any figure
prepared under one convention must be relabeled or recomputed before being presented to a
buyer, broker, or lender. `[doc · DR §1]`

**State the magnitude of the difference, not just the caveat.** Where owner compensation is
large relative to earnings, the two conventions can differ by more than the entire reported
result. A labeling caveat that does not quantify the gap leaves the reader unable to judge
whether it matters, so the engagement record should carry both figures. `[infer]` — the
Decision Record quantifies the gap for its own engagement but does not state this as a
standing requirement.

---

## 2. Source documents and their competence

No single document supports the whole calculation. Each is authoritative only where it is
competent. `[doc · DR §2]`

| Source | Authoritative for | Not used for |
|---|---|---|
| P&L Detail (accrual) | net income; discretionary expense add-backs; owner wages | depreciation, Section 179 |
| Tax return | depreciation, Section 179 | discretionary expense detail |
| Productivity export | provider roles, production, visit counts | any dollar figure entering the calculation |

Depreciation and the Section 179 election appear on the return, not the P&L, so a P&L-only
analysis structurally understates non-cash add-backs. The return in turn lacks the
expense-level granularity needed to identify discretionary spending. `[doc · DR §2]`

**Reconcile owner wages across both.** Summed owner paychecks in the payroll ledger should
tie to the officer-compensation line on the return within rounding. A material gap means
either an incomplete ledger extract or compensation booked to an account not yet examined,
and must be resolved before the figure is used. `[infer]` — the Decision Record performs
this reconciliation (§7) but does not state it as a general requirement.

**Derived files inherit this separation.** Where the analysis is exported to per-source
working files, each file carries only the figures its source document is competent for. A
P&L export holds net income and P&L add-backs; tax-return add-backs stay in the tax export.
Folding a tax figure into a P&L total produces a column that double-counts as soon as any
downstream step sums the two files. `[infer]` — generalized from a defect observed in a
rebuilt working file, not from the Decision Record.

---

## 3. The formula and its sign conventions

```
Normalized earnings = Net Income
                    + discretionary add-backs        (P&L)
                    + owner excess compensation      (P&L)
                    + depreciation + Section 179     (tax return)
```
`[doc · DR §3]`

Sign handling differs by account type and is not arbitrary:

- **Expense accounts** carry debit balances: `net = debit − credit`
- **Income accounts** carry credit balances: `net = credit − debit`

Both are computed so that a positive result means what the account label implies. Applying
one convention to both account types inverts the sign on one of them. `[doc · DR §3]`

---

## 4. Add-back categories

| Category | Source | Treatment |
|---|---|---|
| Contributions | P&L | full net, if positive |
| Legal fees | P&L | full net, if positive |
| Miscellaneous | P&L | full net, if positive |
| Travel & entertainment | P&L | full net, if positive |
| Automobile | P&L | personal-use portion only |
| Owner excess compensation | P&L | wages less market rate, floored at zero |
| Depreciation | tax return | full amount |
| Section 179 | tax return | full amount |

`[doc · DR §4]`

**The governing principle: estimated or unsubstantiated amounts do not enter the
calculation.** Every accepted add-back must trace to a ledger line. This is the strongest
defense of a final figure — it means each component can be pointed at in a source document.
`[doc · DR §4]`

**Categories rejected under this principle.** The rejections are part of the method and are
recorded, not silently omitted, because the reason a category was excluded is as much a
finding as the amounts that were included. `[doc · DR §4]`

| Rejected category | Reason |
|---|---|
| Repairs characterized as questionable | analyst judgment with no documented basis |
| Unlabeled "other" buckets | not itemizable to ledger lines |
| Flat-rate expense estimates | an assumed annual amount is not a ledger figure |

**Exclusion is the wrong endpoint for an unsupportable estimate.** The correct response is
to locate the real figure in the ledger, not to drop the category. Dropping it understates
the result; substantiating it does not. A rejected estimate should leave an open item naming
the account to examine, not a closed decision. `[infer]` — the Decision Record rejects such
estimates and separately keeps one open as a conditional improvement, but never states the
rule; a section it cites for this (§5.5) is absent from the document.

---

## 5. Known failure modes

### 5.1 Convention rates presented as derived figures
Personal-use fractions — the share of an automobile expense treated as personal, most
commonly — along with allocation percentages and similar rates, are frequently applied as
flat conventions with no cited authority. A convention is defensible; a convention
*presented as a derivation* is not. Label it as a convention, or cite the source.
`[doc · DR §5.1]`

### 5.2 Mismatched basis in the compensation comparison
Owner compensation is often assembled as loaded employment cost — wages plus employer
payroll taxes — while the market benchmark is a gross salary figure. Comparing cost against
salary overstates excess by the tax amount. `[doc · DR §5.2]`

The tax is not excess. Employing *any* clinician at the benchmark salary incurs the same
employer payroll tax, so it is identical on both sides and cancels. `[doc · DR §5.2]`

**Resolution: measure both sides as salary.** Exclude employer payroll tax from the
numerator and use the published market-salary benchmark unchanged. This is preferred over
grossing up the benchmark because it introduces no assumptions about taxes on a
hypothetical employee, and because every other add-back is an amount read from the ledger.
`[doc · DR §5.2]`

**Validate the correction two ways.** Dropping the tax from the numerator and grossing the
benchmark up to loaded cost are independent fixes for the same defect. Computed separately
they should converge to within a trivial amount; that convergence is the evidence the
adjustment is sound, and a material divergence means one of the two was done wrong.
`[doc · DR §6]` — the Record performs and reports both; stating it as a standing
requirement is `[infer]`.

A related tell: if employer Social Security is included but employer Medicare is not, the
figure was assembled by hand rather than from a stated rule. `[doc · DR §5.2]` Medicare is
uncapped; Social Security is capped at the annual wage base. `[ext]`

### 5.3 Multi-owner benchmark
Summing multiple owners' wages and comparing against a single-clinician market rate is
methodologically loose. It is immaterial where a second owner's compensation is trivial
relative to the primary owner's, and material where two substantive owners exist.
`[doc · DR §5.3]` Before summing, establish each owner's clinical role and FTE — relative
production share is the standard proxy. `[infer]`

**Ownership is established from the payroll ledger's class field, not from production
share.** A high-producing clinician may be an employee or contractor; a low-producing one
may be an owner. `[instr]` — asserted in the engagement record from ledger class values;
the Decision Record does not mention a class field, so this rule rests on the analyst's
determination rather than on a cited document.

### 5.4 Partial years
A partial year requires the market-rate benchmark to be prorated by the fraction of the
year covered. Production and expense figures remain partial and are not annualized. Any
multiple applied to partial-year figures must account for this. `[doc · DR §5.4]`

A related trap in multi-year averaging: where one source document is available for fewer
years than another — a missing return, say — the two components must not be averaged over
different denominators. Divide every component by the same year count, or state the average
as covering only the years all sources span. `[infer]` — generalized from a defect observed
in downstream code, not from the Decision Record.

### 5.5 Provider record types
Productivity exports routinely contain non-individual rows alongside named providers:
practice-entity rows carrying no production, independent-contractor lines aggregating
outside clinical work, and non-attributed production lines. These are legitimate record
types, not corrupt data. `[instr]` — the classification was determined by the engagement
analyst; the Decision Record (§8) records these same rows as *unidentified*, so the export
alone does not support it.

**Which is which must be established from the practice, not inferred from the export.** An
unusually high average visit fee, or a name that breaks the export's format convention, is
a signal to ask, not a basis to conclude. `[infer]`

Classify by record type before computing anything per-provider. Averages, headcounts, and
per-provider comparisons that treat entity rows or aggregate lines as individuals will be
wrong, and the error scales with how many such rows the export contains. `[doc · DR §8]`

Collection and production may be attributed on different bases within one export —
hygienist rows can show zero collection, and a dentist row can show collection exceeding
its own production. The cause is not established by the export. Treat per-provider
collection rate as not computable from these files and use the aggregate. `[infer]` — the
first sentence is an observation from the data; the operational rule is reasoned. No source
explains the attribution, and any stated cause would be invented.

### 5.6 Non-owner clinician concentration
Where a non-owner clinician generates a large share of production, the cost of that
clinician is central to any question about practice profitability, and their departure is a
value consideration in its own right. Quantify it explicitly; it is frequently omitted
because it sits outside the add-back framework. `[doc · DR §8]`

---

## 6. Parameters are configuration, not method

Market-rate benchmarks, personal-use fractions and payroll tax wage bases vary by year,
region and specialty. They are looked up exactly, never retrieved approximately, and are
held outside this document. `[infer]` — an architectural choice made when this document was
split from the Decision Record, not a rule stated in it.

This document records *that* compensation is normalized to a market rate and why. The
applicable rate for a given year and market is configuration.

---

## 7. Why the rules are written down

Every rule above was previously implicit — encoded in regex patterns, hardcoded constants,
and one-sentence justification strings living alongside the code that applied them. Nothing
in that arrangement could state *why* an add-back qualified, cite a source, or be checked
for internal consistency. `[doc · DR §9]`

Written down, these rules become retrievable. A generated justification can then be checked
against the rule it claims to rest on, which is what makes a faithfulness evaluation
possible at all. `[doc · DR §9]`

---

## 8. Register of unverified rules

Every rule not marked `[doc]` or `[ext]`, collected for review. A rule leaving this list
should gain a `[doc]` citation or be struck.

| § | Rule | Mark |
|---|---|---|
| 1 | State the magnitude of the labeling difference, not just the caveat | `[infer]` |
| 2 | Reconcile owner wages across ledger and return | `[infer]` |
| 2 | Derived files inherit source separation | `[infer]` |
| 4 | Substantiate an unsupportable estimate rather than dropping it | `[infer]` |
| 5.2 | Validate the compensation correction two independent ways | `[infer]` |
| 5.3 | Establish role and FTE before summing owners; production share as proxy | `[infer]` |
| 5.3 | Ownership from the payroll class field, not production share | `[instr]` |
| 5.4 | One denominator for all components in a multi-year average | `[infer]` |
| 5.5 | Non-individual rows are legitimate record types | `[instr]` |
| 5.5 | Establish record type from the practice, not from the export | `[infer]` |
| 5.5 | Per-provider collection rate is not computable; use aggregate | `[infer]` |
| 6 | Parameters held outside this document as configuration | `[infer]` |
