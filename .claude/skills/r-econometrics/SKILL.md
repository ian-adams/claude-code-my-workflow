---
name: r-econometrics
description: Run IV, DiD, RDD, and event study analyses in R with modern estimators, proper diagnostics, and publication-ready output.
disable-model-invocation: true
argument-hint: "[method: did | iv | rdd | event-study | panel]"
---

# R Econometrics

Generate rigorous econometric analysis code in R. Covers IV, DiD (including modern heterogeneity-robust estimators), RDD, and event studies with proper diagnostics and publication-ready output.

**All generated R code must comply with `r-code-conventions.md`.**

## Steps

1. **Understand the Research Design**
   - Identification strategy: IV, DiD, RDD, event study, or panel regression?
   - Unit of observation: individual, firm, county-year, etc.?
   - Fixed effects needed: entity, time, two-way?
   - Clustering level for standard errors?
   - Staggered treatment timing? (Critical for DiD method choice)

2. **Generate Analysis Code**

   Structure every script as:
   ```r
   # 1. Setup and packages
   # 2. Data loading and preparation
   # 3. Descriptive statistics
   # 4. Main specification
   # 5. Robustness checks
   # 6. Visualization
   # 7. Export results (dual format: PDF for Beamer, SVG for Quarto)
   ```

3. **Select the Right Estimator**

   ### Difference-in-Differences

   | Scenario | Estimator | R Package | Function |
   |----------|-----------|-----------|----------|
   | Classic 2x2 DiD | TWFE | `fixest` | `feols(y ~ treat_post \| unit + time)` |
   | Staggered timing | Callaway & Sant'Anna (2021) | `did` | `att_gt()` |
   | Staggered timing | Sun & Abraham (2021) | `fixest` | `feols(y ~ sunab(cohort, time))` |
   | Staggered timing | de Chaisemartin & D'Haultfoeuille (2020) | `DIDmultiplegt` | `did_multiplegt()` |
   | Staggered timing | Imputation (Borusyak et al. 2024) | `didimputation` | `did_imputation()` |

   **Default recommendation:** For staggered timing, use Callaway & Sant'Anna as primary, Sun & Abraham as robustness. Report TWFE alongside for comparison.

   ### Instrumental Variables

   ```r
   library(fixest)
   # 2SLS with fixest
   iv_model <- feols(y ~ controls | fixed_effects | endogenous ~ instrument,
                     data = df, cluster = ~cluster_var)
   # Report first-stage F-statistic (must be > 10)
   fitstat(iv_model, "ivf")
   ```

   ### Regression Discontinuity

   ```r
   library(rdrobust)
   # Sharp RDD with optimal bandwidth
   rd_result <- rdrobust(y = df$outcome, x = df$running_var, c = cutoff)
   summary(rd_result)
   rdplot(y = df$outcome, x = df$running_var, c = cutoff)
   ```

   ### Event Studies

   ```r
   library(fixest)
   # Event study with fixest
   es_model <- feols(
     outcome ~ i(rel_time, treated, ref = -1) | unit + time,
     data = df, cluster = ~unit
   )
   iplot(es_model, main = "Event Study", xlab = "Periods Relative to Treatment")
   ```

4. **Export Results**

   Always provide dual output format:

   ```r
   # Tables via modelsummary
   library(modelsummary)
   modelsummary(models, output = "tables/results.tex")  # For Beamer

   # Figures: dual format
   ggsave("Figures/event_study.pdf", width = 8, height = 5)   # For Beamer
   ggsave("Figures/event_study.svg", width = 8, height = 5)   # For Quarto
   ```

   For table formatting, see `/latex-tables`.

5. **Diagnostics Checklist**

   | Method | Required Diagnostics |
   |--------|---------------------|
   | DiD | Pre-trends test, event study plot, parallel trends visualization |
   | IV | First-stage F > 10, exclusion restriction argument, overid test if applicable |
   | RDD | McCrary density test, bandwidth sensitivity, placebo cutoffs |
   | All | Robustness to alternative clustering, controls, sample restrictions |

## Best Practices

1. Always cluster SEs at the level of treatment assignment
2. For staggered DiD, **never use plain TWFE** — use heterogeneity-robust estimators
3. Report first-stage F for IV (> 10 rule of thumb, > 104.7 for Lee et al. threshold)
4. Document all specification choices in code comments
5. Use `fixest` over `lm` for panel data (faster, more features)
6. Set seeds for any stochastic procedures

## Common Pitfalls

- Using TWFE with staggered treatment timing (biased with heterogeneous effects)
- Not clustering SEs at the right level
- Ignoring weak instruments in IV
- Not showing pre-trends for DiD
- Forgetting to set `ref = -1` in event studies
