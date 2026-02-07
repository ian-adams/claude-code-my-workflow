---
name: python-econometrics
description: Run IV, DiD, RDD, and panel analyses in Python for cross-language verification. R is primary; Python validates.
disable-model-invocation: true
argument-hint: "[method: did | iv | rdd | panel]"
---

# Python Econometrics

Generate Python code for causal inference and panel data analysis. Covers IV, DiD, RDD, event studies, and panel regressions.

**R is the primary analysis language in this project.** Python econometrics serves two purposes:
1. **Cross-language verification** — replicate R results to catch bugs (see `/replication-protocol`)
2. **Python-native workflows** — when collaborators or data pipelines are Python-based

## Steps

1. **Understand the Research Design**
   - Same questions as `/r-econometrics`: identification strategy, unit, FE, clustering
   - Is this a primary analysis or cross-language verification of existing R code?

2. **Generate Analysis Code**

   All Python scripts must include:
   - Type hints on all functions
   - Docstrings (Google style)
   - Virtual environment note at top: `# Requires: pip install pyfixest linearmodels rdrobust statsmodels pandas`

3. **Select the Right Package**

   ### Panel Data / Fixed Effects

   ```python
   import pyfixest as pf

   # Two-way fixed effects (pyfixest mirrors R's fixest syntax)
   model = pf.feols("outcome ~ treat_post | unit + time", data=df, vcov={"CRV1": "unit"})
   model.summary()
   ```

   **Alternative:** `linearmodels.PanelOLS` for traditional panel models:
   ```python
   from linearmodels.panel import PanelOLS
   df = df.set_index(["unit_id", "time"])
   model = PanelOLS.from_formula(
       "outcome ~ 1 + treat_post + EntityEffects + TimeEffects", data=df
   )
   results = model.fit(cov_type="clustered", cluster_entity=True)
   ```

   ### Instrumental Variables

   ```python
   from linearmodels.iv import IV2SLS

   model = IV2SLS.from_formula(
       "outcome ~ 1 + controls + [endogenous ~ instrument]", data=df
   )
   results = model.fit(cov_type="clustered", clusters=df["cluster_var"])
   print(f"First-stage F: {results.first_stage.diagnostics['f.stat']:.1f}")
   ```

   ### Difference-in-Differences

   ```python
   import pyfixest as pf

   # Standard DiD
   did_model = pf.feols("outcome ~ treat_post | unit + time", data=df, vcov={"CRV1": "state"})

   # Event study
   es_model = pf.feols("outcome ~ i(rel_time, treated, ref=-1) | unit + time",
                        data=df, vcov={"CRV1": "unit"})
   pf.iplot(es_model)
   ```

   ### Regression Discontinuity

   ```python
   from rdrobust import rdrobust, rdplot

   result = rdrobust(y=df["outcome"], x=df["running_var"], c=cutoff)
   print(result)
   rdplot(y=df["outcome"], x=df["running_var"], c=cutoff)
   ```

4. **Cross-Language Verification Protocol**

   When replicating R results:

   ```python
   import pandas as pd
   import numpy as np

   # Load the same data
   df = pd.read_csv("data/clean/analysis_data.csv")

   # Run the same specification
   # ... (estimation code) ...

   # Compare results
   r_estimate = -1.632  # From R output
   py_estimate = results.params["treat_post"]
   diff = abs(r_estimate - py_estimate)
   print(f"R estimate:      {r_estimate:.6f}")
   print(f"Python estimate: {py_estimate:.6f}")
   print(f"Difference:      {diff:.6f}")
   print(f"Match (6 dp):    {'PASS' if diff < 1e-6 else 'FAIL'}")
   ```

   Save replication scripts to `scripts/replication/referee2_replicate_*.py`.

5. **Data Interchange**

   For passing data between R and Python:
   - **CSV:** Universal, use for small/medium datasets
   - **Parquet:** Faster for large datasets, preserves types
     ```python
     df.to_parquet("data/clean/analysis_data.parquet")
     ```
     ```r
     library(arrow)
     df <- read_parquet("data/clean/analysis_data.parquet")
     ```

## Python Environment Note

```bash
# Create virtual environment (recommended)
python -m venv .venv
source .venv/bin/activate  # Linux/Mac
.venv\Scripts\activate     # Windows

# Install core packages
pip install pyfixest linearmodels rdrobust statsmodels pandas numpy
```

## Required Packages

| Package | Purpose | Install |
|---------|---------|---------|
| `pyfixest` | Fixed effects (mirrors R `fixest`) | `pip install pyfixest` |
| `linearmodels` | Panel data, IV, system estimation | `pip install linearmodels` |
| `rdrobust` | RDD estimation and plots | `pip install rdrobust` |
| `statsmodels` | OLS, GLS, time series | `pip install statsmodels` |
| `pandas` | Data manipulation | `pip install pandas` |

## Best Practices

1. Use `pyfixest` for fixed effects (closest syntax to R's `fixest`)
2. Always match R specifications exactly when doing cross-language verification
3. Document any known differences in default behavior (DoF adjustments, SE formulas)
4. Save verification comparison tables to `quality_reports/`
5. Type hints and docstrings on all functions
