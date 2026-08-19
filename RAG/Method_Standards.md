# Valuation Method Standards
**Firm methodology for dental practice normalized-earnings analysis**

Reusable across engagements. Contains no client figures. Every rule here applies
identically to any practice; client-specific amounts, reconciliations and findings belong
in that engagement's own record.

---

## 1. Choosing the measure before computing anything

The measure must be selected from the question being asked, and stated before any figure is
quoted.

| Question | Measure | Owner compensation treatment |
|---|---|---|
| Is the business profitable once the owner's labor is fairly paid? | normalized owner earnings (adjusted EBITDA) | normalize to market rate; add back only the excess |
| What total return is available to a single owner-operator? | Seller's Discretionary Earnings (SDE) | add back the working owner's entire compensation |

These produce materially different results from identical source documents. Full add-back
answers a broker's question and is uninformative to an owner who already knows their own
draw. Market normalization isolates whether the *business* earns a return once the
*clinician* is paid, and is the correct choice for an owner-diagnostic engagement.

**Labeling rule.** If the excess-over-market treatment is used, the output is not SDE as
the term is understood in practice sales. Label it normalized owner earnings. Any figure
prepared under one convention must be relabeled or recomputed before being presented to a
buyer, broker, or lender.

---

## 2. Source documents and their competence

No single document supports the whole calculation. Each is authoritative only where it is
competent.

| Source | Authoritative for | Not used for |
|---|---|---|
| P&L Detail (accrual) | net income; discretionary expense add-backs; owner wages | depreciation, Section 179 |
| Tax return | depreciation, Section 179 | discretionary expense detail |
| Productivity export | provider roles, production, visit counts | any dollar figure entering the calculation |

Depreciation and the Section 179 election appear on the return, not the P&L, so a P&L-only
analysis structurally understates non-cash add-backs. The return in turn lacks the
expense-level granularity needed to identify discretionary spending.

**Reconcile owner wages across both.** Summed owner paychecks in the payroll ledger should
tie to the officer-compensation line on the return within rounding. A material gap means
either an incomplete ledger extract or compensation booked to an account not yet examined,
and must be resolved before the figure is used.

---

## 3. The formula and its sign conventions

```
Normalized earnings = Net Income
                    + discretionary add-backs        (P&L)
                    + owner excess compensation      (P&L)
                    + depreciation + Section 179     (tax return)
```

Sign handling differs by account type and is not arbitrary:

- **Expense accounts** carry debit balances: `net = debit − credit`
- **Income accounts** carry credit balances: `net = credit − debit`

Both are computed so that a positive result means what the account label implies. Applying
one convention to both account types inverts the sign on one of them.

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

**The governing principle: estimated or unsubstantiated amounts do not enter the
calculation.** Every accepted add-back must trace to a ledger line. This is the strongest
defense of a final figure — it means each component can be pointed at in a source document.

**But exclusion is the wrong endpoint for an unsupportable estimate.** The correct response
is to locate the real figure in the ledger, not to drop the category. Dropping it
understates the result; substantiating it does not.

---

## 5. Known failure modes

### 5.1 Convention rates presented as derived figures
Personal-use fractions, allocation percentages and similar rates are frequently applied as
flat conventions with no cited authority. A convention is defensible; a convention
*presented as a derivation* is not. Label it as a convention, or cite the source.

### 5.2 Mismatched basis in the compensation comparison
Owner compensation is often assembled as loaded employment cost — wages plus employer
payroll taxes — while the market benchmark is a gross salary figure. Comparing cost against
salary overstates excess by the tax amount.

The tax is not excess. Employing *any* clinician at the benchmark salary incurs the same
employer payroll tax, so it is identical on both sides and cancels.

**Resolution: measure both sides as salary.** Exclude employer payroll tax from the
numerator and use the published market-salary benchmark unchanged. This is preferred over
grossing up the benchmark because it introduces no assumptions about taxes on a
hypothetical employee, and because every other add-back is an amount read from the ledger.

A related tell: if employer Social Security is included but employer Medicare is not, the
figure was assembled by hand rather than from a stated rule. Medicare is uncapped; Social
Security is capped at the annual wage base.

### 5.3 Multi-owner benchmark
Summing multiple owners' wages and comparing against a single-clinician market rate is
methodologically loose. It is immaterial where a second owner's compensation is trivial
relative to the primary owner's, and material where two substantive owners exist. Before
summing, establish each owner's clinical role and FTE — relative production share is the
standard proxy.

**Ownership is established from the payroll ledger's class field, not from production
share.** A high-producing clinician may be an employee or contractor; a low-producing one
may be an owner.

### 5.4 Partial years
A partial year requires the market-rate benchmark to be prorated by the fraction of the
year covered. Production and expense figures remain partial and are not annualized. Any
multiple applied to partial-year figures must account for this.

### 5.5 Provider record types
Productivity exports routinely contain non-individual rows alongside named providers:
practice-entity rows carrying no production, contractor lines aggregating outside clinical
work, and non-attributed production lines. These are legitimate record types, not corrupt
data.

Classify by record type before computing anything per-provider. Averages, headcounts, and
per-provider comparisons that treat entity rows or aggregate lines as individuals will be
wrong. Note also that hygiene production commonly posts with zero collection, because
collection is credited to the practice rather than the hygienist — this is normal and not
a data defect.

### 5.6 Non-owner clinician concentration
Where a non-owner clinician generates a large share of production, the cost of that
clinician is central to any question about practice profitability, and their departure is a
value consideration in its own right. Quantify it explicitly; it is frequently omitted
because it sits outside the add-back framework.

---

## 6. Parameters are configuration, not method

Market-rate benchmarks, personal-use fractions and payroll tax wage bases vary by year,
region and specialty. They are looked up exactly, never retrieved approximately, and are
held outside this document.

This document records *that* compensation is normalized to a market rate and why. The
applicable rate for a given year and market is configuration.
