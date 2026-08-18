# SDE Methodology — Decision Record
**Roselle Dental Center, P.C. · FY2022–2025**

Purpose: a single authoritative statement of how Seller's Discretionary Earnings was
calculated, why each choice was made, and where the method has known weaknesses.
Reconstructed from source files and ledger detail. Supersedes the rules previously
embedded in code.

---

## 1. Engagement purpose

This analysis was prepared **for the owners**, not for a transaction. The question was
whether the practice was profitable after the owner's labor is fairly compensated.

This governs the choice of measure and should be stated before any figure is quoted.
Normalizing owner compensation to a market rate — rather than adding it back in full —
is the correct treatment for that question: it isolates whether the *business* earns a
return once the *dentist* is paid. Full add-back, the convention in a broker's SDE, would
answer a different question (total cash available to the owner) and would have been
uninformative to an owner who already knows his own draw.

**Labeling caveat.** What is computed here is normalized owner earnings, closer to
adjusted EBITDA than to Seller's Discretionary Earnings as the term is used in practice
sales. The files call it SDE. If these figures are ever presented to a buyer, broker, or
lender, the measure must be relabeled or recomputed — under a full-add-back convention
FY2022 would read approximately $216,000 and FY2023 approximately $165,000 rather than
$31,229 and −$13,947. Same ledger, different question.

---

## 2. Source documents and their roles

| Source | Authoritative for | Not used for |
|---|---|---|
| **P&L Detail** (QuickBooks, accrual) | Net income; all discretionary expense add-backs; owner wages | Depreciation, Section 179 |
| **Tax return** | Depreciation, Section 179 | Discretionary expenses |
| **Productivity export** | Provider roles, production, visit counts | Any dollar figure entering SDE |

Rationale: depreciation and the §179 election appear on the return, not the P&L, so the
P&L alone structurally understates non-cash add-backs. The tax return in turn lacks the
expense-level granularity needed to identify discretionary spending. Neither document is
sufficient alone; each is authoritative only where it is competent.

---

## 3. The formula

```
SDE = Net Income
    + discretionary add-backs        (P&L)
    + owner excess compensation      (P&L)
    + depreciation + Section 179     (tax return)
```

Where `Net Income = Credit − Debit`. Note the sign convention differs by account type:
expense accounts carry debit balances (`net = debit − credit`), income carries a credit
balance (`net = credit − debit`). Both are computed so a positive result means what the
label implies.

### Verification — reconciles to the cent, all four years

| Year | Net Income | Add-backs | Total Discretionary Earnings |
|---|---|---|---|
| 2022 | −6,877.36 | 24,012.46 | **17,135.10** |
| 2023 | −62,982.50 | 30,447.99 | **−32,534.51** |
| 2024 | −112,623.23 | 13,919.73 | **−98,703.50** |
| 2025 | −29,284.43 | 2,118.38 | **−27,166.04** |

Tax-side add-backs (depreciation + §179) are applied on top: 14,094.00 (2022),
18,588.00 (2023), 7,685.00 (2024). No 2025 return available.

---

## 4. Add-back categories

| Category | Source | Treatment | Basis | Status |
|---|---|---|---|---|
| Contributions | P&L | Full net, if positive | Read from ledger | Accepted |
| Legal Fees | P&L | Full net, if positive | Read from ledger | Accepted |
| Miscellaneous | P&L | Full net, if positive | Read from ledger | Accepted |
| Travel & Entertainment | P&L | Full net, if positive | Read from ledger | Accepted |
| Automobile | P&L | Full net as recorded | Personal-use portion, estimated | Accepted — see §5.1 |
| Owner excess compensation | P&L | Loaded comp less market rate | Computed — see §7 | Accepted — see §5.2 |
| Depreciation | Tax return | Full amount | Read from return | Accepted |
| Section 179 | Tax return | Full amount | Read from return | Accepted |
| Health insurance | P&L acct 6390 | — | Flat $500/yr estimate used | **Rejected — but see §5.5** |
| Repairs (questionable) | — | — | Analyst judgment | **Rejected** — no documented basis |
| Other | — | — | Unlabeled bucket | **Rejected** — not itemizable |

Rejected items were proposed during analysis and excluded from the agreed calculation.
The consistent principle: **estimated or unsubstantiated amounts do not enter SDE.**
This is worth stating explicitly because it is the strongest defense of the final figure —
every accepted add-back traces to a ledger line.

---

## 5. Known methodology issues

### 5.1 Automobile — 25% personal use is an unsourced assumption
The personal-use fraction is a flat 25% with no cited authority. It is defensible as a
convention but should be labeled as one, not presented as a derived figure. Immaterial in
magnitude (≤ $3,750/yr) but it is the kind of number a buyer's analyst challenges first.

### 5.2 Owner compensation — mismatched basis (RESOLVED)
The numerator was **loaded** cost (wages + employer Social Security). The benchmark,
$195,700, is a **gross salary** figure. Comparing cost against salary overstates excess by
the employer tax — which is not excess at all, since employing *any* dentist at $195,700
would incur the same capped Social Security tax. It is identical on both sides and cancels.

**Resolution: measure both sides as salary.** Employer payroll tax is excluded from the
numerator; the published market-salary benchmark is used unchanged. Chosen over grossing
up the benchmark because it introduces no assumptions about taxes on a hypothetical
employee, and because every other add-back in this method is an amount read from the
ledger. The two approaches agree within $87 in FY2022.

| Year | Owner wages | Benchmark | Excess (corrected) | As delivered |
|---|---|---|---|---|
| 2022 | 201,683.61 | 195,700 | **5,983.61** | 15,097.61 |
| 2023 | 206,648.60 | 195,700 | **10,948.60** | 20,881.00 |
| 2024 | below benchmark | 195,700 | 0 | 0 |
| 2025 | below benchmark | 79,909.74 (prorated) | 0 | 0 |

**Corrected normalized earnings**

| Year | As delivered | Corrected |
|---|---|---|
| 2022 | 31,229.10 | **22,115.10** |
| 2023 | −13,946.51 | **−23,878.91** |
| 2024 | −91,018.50 | −91,018.50 |
| 2025 | −27,166.04 | −27,166.04 |

The correction removes exactly the capped employer Social Security in each year
($9,114.00 in FY2022, $9,932.40 in FY2023). FY2024 and FY2025 are unaffected because owner
salary had already fallen below the benchmark.

**Conclusion unchanged.** After the owner is paid a market wage, the practice cleared
roughly $22,000 in FY2022 and lost money in every subsequent year. The delivered figures
overstated FY2022 by about $9,100 — a bias in the optimistic direction, which for an
owner-diagnostic engagement is the wrong way to be wrong.

**Caveat on FY2023.** Owner wages of $206,648.60 include approximately $3,216.87 of
Chang's compensation derived by difference rather than observed in a ledger account. It is
the only figure in the corrected set not directly sourced. Immaterial to the conclusion.

Related: only employer Social Security was included in the original; employer Medicare on
the same wages ($2,901.67 in FY2022) was omitted. Moot under the correction, since neither
appears — but the original omission indicates the figure was assembled by hand rather than
from a stated rule.

### 5.3 Multi-owner benchmark
Two owners' wages are summed and compared against a single-clinician market rate. This is
methodologically loose. It is **immaterial here** because the second owner drew $1,568.38
against the primary owner's $200,115.23. It would not be immaterial in a practice with two
substantive owners, and the rule as written gives no guidance for that case.

### 5.4 Partial year
2025 is a partial year (~149 days). The market rate was prorated to $79,909.74, or 40.8%
of full. Production and expense figures are correspondingly partial and are not
annualized. Any multiple applied to 2025 figures must account for this.

## 6. Corrected figures

Delivered figures are unchanged in the source files. These are what the same method
produces once §5.2 is applied — comparing gross wages against a gross benchmark.

| Year | Excess comp as delivered | Corrected | Final as delivered | Final corrected |
|---|---|---|---|---|
| 2022 | 15,097.61 | 5,983.61 | 31,229.10 | **22,115.10** |
| 2023 | 20,881.00 | 10,948.60 | −13,946.51 | **−23,878.91** |
| 2024 | 0 | 0 | −91,018.50 | −91,018.50 |
| 2025 | 0 | 0 | −27,166.04 | −27,166.04 |

The correction was validated two ways. Dropping employer tax from the numerator and
grossing up the benchmark to loaded cost are independent fixes; they agree within $87
(FY2022) and $159 (FY2023). That convergence is the evidence the adjustment is sound.

Note the direction: both years move **down**. Relative to the question in §1, the
delivered figures were mildly optimistic. FY2022 still clears break-even and FY2023 is
still a loss, so the conclusion holds — but "roughly break-even in 2022" is $22K, not $31K.

If §5.5 resolves as owner-personal, FY2023 improves by $3,277.18 to approximately
−$20,601.73.

---

## 7. Owner compensation — full reconciliation

### FY2022

Four different figures existed for FY2022. Reconciled:

| Figure | Amount | Note |
|---|---|---|
| Ledger, acct 6575, Seybold | 200,115.23 | 44 paychecks, summed |
| Tax return, officer comp | 200,115 | Ties to ledger within rounding |
| Chang (second owner) | 1,568.38 | 6 paychecks |
| Employer Social Security | 9,114.00 | $147,000 base × 6.2%, at cap |

```
200,115.23 + 1,568.38 + 9,114.00 − 195,700 = 15,097.61   ✓ matches P&L
```

### FY2023 — formula confirmed

| Figure | Amount | Note |
|---|---|---|
| Ledger, acct 6575, Seybold | 199,992.15 | 41 paychecks, summed |
| Tax return, officer comp | 199,992 | Ties to ledger within rounding |
| Chang, acct 6575 | 3,439.58 | 7 paychecks |
| Chang, other account(s) | ~3,216.87 | **Unlocated — see below** |
| Employer Social Security | 9,932.40 | $160,200 base × 6.2%, at cap |

```
199,992.15 + 3,439.58 + 3,216.87 + 9,932.40 − 195,700 = 20,881.00   ✓ matches P&L
```

The same formula reproduces both years. The ledger ties to the tax return within 15 cents
in FY2022 and FY2023 alike.

**Open:** roughly $3,216.87 of Chang's FY2023 compensation is not in account 6575. He
appears in 6561 (`*Payroll Expenses`) for only $23.05 in fringe amounts, so a third
payroll account carries the balance — likely a bonus or separate owner-wage line. The
amount is derived by difference and has not been observed directly.

Note: Chang did not appear on the FY2023 tax return's officer compensation line. This is
consistent with an owner drawing four figures and is not evidence of an error.

---

## 8. Open items

- **Chang's third payroll account** — ~$3,216.87 of FY2023 owner compensation is derived
  by difference rather than observed. Immaterial to the result; worth closing if the
  account surfaces.
- **Associate compensation — the main unexamined driver.** Hassenplug produced 44.5%
  (FY2022) and 48.6% (FY2023) of practice output but does not appear in payroll account
  6575, so her compensation runs through a separate arrangement. Given the engagement
  purpose in §1, this is the most consequential gap in the analysis: if the owners are
  asking why the practice does not clear a profit after paying the owner market wages,
  the cost of the clinician generating roughly half of production is central to the
  answer. It does not appear to have been quantified anywhere.
- **Unidentified provider records** — "IC" records $133,851 across 100 visits (a $1,338
  average fee, an order of magnitude above every named dentist) and "Hyg Hyg" lacks the
  first/last name format used by every other record. What these represent is **not
  established** — "IC" may be an independent-contractor bucket, but this is unconfirmed.
  What is clear is that neither behaves like an individual provider, so neither belongs in
  a per-provider average or headcount without first being identified.

---

## 9. What this document is for

Every rule above was previously implicit — encoded in regex patterns, hardcoded constants,
and one-sentence justification strings living alongside the code that applied them. Nothing
in that arrangement could state *why* an add-back qualified, cite a source, or be checked
for internal consistency.

Written down, these rules become retrievable. A generated justification can then be
checked against the rule it claims to rest on, which is what makes a faithfulness
evaluation possible at all.
