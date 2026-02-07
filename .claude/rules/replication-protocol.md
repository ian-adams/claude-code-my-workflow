---
paths:
  - "scripts/**/*.R"
  - "Figures/**/*.R"
---

# Replication-First Protocol

**Core principle:** Replicate original results to the dot BEFORE extending.

This protocol applies whenever working with papers that have replication packages (Stata, R, or other code). The goal is exact numerical reproducibility before any course-specific modifications.

---

## Why This Matters

- Incorrect replication = teaching students wrong numbers
- Translation errors (Stata to R) can silently change results
- Extensions built on a broken baseline propagate errors
- Students will attempt to replicate -- they must get the same numbers

---

## Phase 1: Inventory & Baseline

Before writing any R code:

1. **Read the paper's replication README** (or equivalent documentation)
2. **Inventory the replication package:**
   - What language? (Stata, R, Python, Matlab)
   - What data files? (sizes, formats, public vs restricted)
   - What scripts? (order of execution, dependencies)
   - What outputs? (tables, figures, estimates)

3. **Record gold standard numbers** -- the exact results from the paper:
   ```markdown
   ## Replication Targets: [Paper Author (Year)]

   | Target | Table/Figure | Value | SE/CI | Notes |
   |--------|-------------|-------|-------|-------|
   | Main ATT | Table 2, Col 3 | -1.632 | (0.584) | Primary specification |
   | Placebo | Table 3, Col 1 | 0.012 | (0.891) | Should be ~0 |
   | ...     | ...           | ...   | ...   | ... |
   ```

4. **Store gold standard** in one of:
   - `quality_reports/LectureNN_replication_targets.md` (for reference)
   - An RDS file with named list of target values (for programmatic comparison)

---

## Phase 2: Translate & Execute

When translating code (typically Stata to R):

1. **Follow `r-code-conventions.md`** for all R coding standards
2. **Translate line-by-line initially** -- don't "improve" or "modernize" during replication
3. **Match the original specification exactly:**
   - Same covariates, same sample restrictions, same clustering
   - Same estimation method (even if a "better" one exists)
   - Same standard error computation
4. **Save all intermediate results as RDS:**
   - Raw data after cleaning: `LectureNN_data_clean.rds`
   - Estimation results: `LectureNN_estimates.rds`
   - Summary tables: `LectureNN_summary.rds`
5. **Execute and capture outputs**

### Common Stata to R Translation Pitfalls

<!-- Customize: Add pitfalls specific to your field's common packages -->

| Stata | R | Trap |
|-------|---|------|
| `reg y x, cluster(id)` | `feols(y ~ x, cluster = ~id)` | Stata clusters df-adjust differently from some R packages |
| `areg y x, absorb(id)` | `feols(y ~ x \| id)` | Check demeaning method matches |
| `probit` for PS | `glm(family=binomial(link="probit"))` | R default logit != Stata default in some commands |
| `bootstrap, reps(999)` | Depends on method | Match seed, reps, and bootstrap type exactly |

---

## Phase 3: Verify Match

Compare every target number:

```r
# Programmatic comparison
targets <- list(
  main_att = -1.632,
  main_se = 0.584,
  placebo = 0.012
)

results <- list(
  main_att = coef(model)[["treatment"]],
  main_se = sqrt(vcov(model)[["treatment", "treatment"]]),
  placebo = coef(placebo_model)[["treatment"]]
)

# Check each target
for (name in names(targets)) {
  diff <- abs(results[[name]] - targets[[name]])
  status <- if (diff < 0.01) "PASS" else "FAIL"
  message(sprintf("[%s] %s: paper=%.4f, ours=%.4f, diff=%.4f",
                  status, name, targets[[name]], results[[name]], diff))
}
```

### Tolerance Thresholds

| Type | Tolerance | Rationale |
|------|-----------|-----------|
| Integers (N, counts) | Exact match | No reason for any difference |
| Point estimates | < 0.01 | Rounding in paper display |
| Standard errors | < 0.05 | Bootstrap/clustering variation |
| P-values | Same significance level | Exact p may differ slightly |
| Percentages | < 0.1pp | Display rounding |

### If Mismatch

**Do NOT proceed to extensions.** Instead:

1. **Isolate the discrepancy:** Which step introduces the difference?
2. **Check common causes:**
   - Sample size mismatch (different data cleaning)
   - Different SE computation (robust vs cluster vs analytical)
   - Different default options (e.g., R vs Stata logit convergence criteria)
   - Missing covariates or different variable definitions
3. **Document the investigation** even if unresolved
4. **Consult the instructor** if the difference persists and matters

### Generate Replication Report

Save to `quality_reports/LectureNN_replication_report.md`:

```markdown
# Replication Report: [Paper Author (Year)]
**Date:** [YYYY-MM-DD]
**Lecture:** [LectureNN]
**Original language:** [Stata/R/etc.]
**R translation:** [script path]

## Summary
- **Targets checked:** N
- **Passed:** M
- **Failed:** K
- **Overall:** [REPLICATED / PARTIAL / FAILED]

## Results Comparison

| Target | Paper | Ours | Diff | Status |
|--------|-------|------|------|--------|
| Main ATT | -1.632 | -1.631 | 0.001 | PASS |
| Main SE | 0.584 | 0.586 | 0.002 | PASS |
| ...     | ...   | ...  | ...  | ... |

## Discrepancies (if any)
### [Target name]
- **Paper value:** X
- **Our value:** Y
- **Investigation:** [what we checked]
- **Root cause:** [if found]
- **Resolution:** [how resolved, or "pending"]

## Environment
- R version: [version]
- Key packages: [with versions]
- Data source: [path or URL]
```

---

## Phase 4: Only Then Extend

After replication is verified (all targets PASS):

1. **Commit the replication script** with a clear message: "Replicate [Paper] Table X -- all targets match"
2. **Now extend** with course-specific modifications:
   - Apply different estimators
   - Add new specifications
   - Create course-themed figures
   - Generate interactive plotly versions
3. **Each extension builds on the verified baseline** -- if an extension produces unexpected results, compare against the replicated baseline

---

## Phase 2.5: Cross-Language Verification

**Purpose:** Exploit orthogonality of errors across languages to catch bugs through independent replication.

When analysis exists in one language, create a parallel implementation in the other:

1. **If primary is R** → create Python replication script
2. **If primary is Python** → create R replication script

### Protocol

1. **Create replication scripts:**
   ```
   scripts/replication/
   ├── referee2_replicate_main_results.R
   ├── referee2_replicate_main_results.py
   ├── referee2_replicate_event_study.R
   └── referee2_replicate_event_study.py
   ```

2. **Run both implementations** and compare:
   - Point estimates must match to 6+ decimal places
   - Standard errors must match (accounting for DoF conventions)
   - Sample sizes must be identical
   - Constructed variables (residuals, fitted values) must match

3. **Diagnose discrepancies:**
   - **Different point estimates:** Likely a coding error in one implementation
   - **Different standard errors:** Check clustering, robust SE specs, or DoF adjustments
   - **Different sample sizes:** Check missing value handling, merge behavior, or filter conditions
   - **Different significance levels:** Usually a standard error issue

### Cross-Language Pitfalls

| Issue | R Behavior | Python Behavior |
|-------|-----------|-----------------|
| Missing values in regression | `na.action = na.omit` by default | `linearmodels` drops silently; `pyfixest` warns |
| Clustered SE DoF | `fixest` uses small-sample correction | `linearmodels` may differ; check `cov_type` |
| Factor ordering | Alphabetical by default | Depends on encoding |
| Floating point | IEEE 754 | IEEE 754 (same, but library implementations vary) |

---

## Phase 5: Five Audits

When performing a comprehensive replication audit (see `/referee2` skill), conduct these five audits:

### Audit 1: Code Audit
- [ ] Missing value handling: documented and justified?
- [ ] Merge diagnostics: row counts, unmatched obs, duplicates checked?
- [ ] Variable construction: dummies, logs, interactions match definitions?
- [ ] Filter conditions: correctly implement stated sample restrictions?
- [ ] Package/function behavior: functions used correctly?

### Audit 2: Cross-Language Replication
Follow Phase 2.5 above. File scripts to `scripts/replication/`.

### Audit 3: Directory & Replication Package
- [ ] Clear separation: `data/raw/`, `data/clean/`, `scripts/`, `Figures/`
- [ ] All paths relative to project root (no absolute paths)
- [ ] Informative variable and dataset names
- [ ] Master script or clear execution order
- [ ] Dependencies documented with versions
- [ ] Random seeds set for stochastic procedures

### Audit 4: Output Automation
- [ ] Tables generated by code (`modelsummary`, `etable`), not manually typed
- [ ] Figures saved programmatically (`ggsave()`, `plt.savefig()`)
- [ ] In-text statistics pulled from code, not hardcoded
- [ ] Re-running code produces identical outputs

### Audit 5: Econometrics
- [ ] Identification strategy clearly stated and plausible
- [ ] Code implements what the documentation claims
- [ ] SEs clustered at appropriate level (>50 clusters rule of thumb)
- [ ] Correct fixed effects included (not collinear with treatment)
- [ ] No "bad controls" (post-treatment variables)
- [ ] Parallel trends evidence shown (if DiD)
- [ ] First stage shown with F-stat (if IV)
- [ ] Effect size magnitude is plausible

---

## Referee Report Template

Save audit reports to `quality_reports/replication/YYYY-MM-DD_[project]_referee_report.md`:

```markdown
# Referee Report: [Project Name] — Round [N]
**Date:** YYYY-MM-DD

## Summary
[2-3 sentences: What was audited? Overall assessment?]

## Audit Results

### Code Audit
[Findings]

### Cross-Language Replication
| Specification | R | Python | Match? |
|--------------|---|--------|--------|
| Main estimate | X.XXXXXX | X.XXXXXX | Yes/No |

### Directory & Replication Package
**Score:** X/10

### Output Automation
Tables: [Automated/Manual/Mixed]
Figures: [Automated/Manual/Mixed]

### Econometrics
[Specification concerns]

## Verdict
[ ] Accept  [ ] Minor Revisions  [ ] Major Revisions  [ ] Reject
```

---

## R&R Workflow

### Round 1: Initial Audit
1. Perform all five audits
2. Create replication scripts in `scripts/replication/`
3. File report to `quality_reports/replication/`

### Author Response
Author addresses concerns and files response at `quality_reports/replication/YYYY-MM-DD_round1_response.md`

### Round 2+: Re-Audit
1. Read original report and author response
2. Re-run all five audits
3. Assess: Fixed / Justified / Ignored / New issues introduced
4. File updated report

### Critical Rule: Never Modify Author Code

The audit must be independent. Replication scripts in `scripts/replication/` are YOUR verification — separate from the author's analysis code. Only the author modifies the author's code. You only REPORT issues.

---

## Integration

- **`/create-lecture` Phase 4:** When replication packages are provided, follow this protocol before creating figures
- **`/review-r`:** The r-reviewer agent checks for replication-related issues (DGP match, correct estimand)
- **`/substance-review`:** The domain reviewer checks code-theory alignment
- **`/r-econometrics`:** Generated R code feeds into Phase 2 translation
- **`/python-econometrics`:** Generated Python code feeds into Phase 2.5 cross-language verification
- **`/transparent-methods-reporter`:** Audit mode checks methods reporting quality
