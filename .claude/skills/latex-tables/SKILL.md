---
name: latex-tables
description: Generate publication-ready regression and summary statistics tables in LaTeX from R or Python output.
disable-model-invocation: true
argument-hint: "[table type: regression | summary | balance]"
---

# LaTeX Tables

Generate clean, publication-ready tables in LaTeX for regression results, summary statistics, and balance tables.

## Steps

1. **Understand the Context**
   - What type of table? (regression, summary stats, balance, custom)
   - What software produced the results? (R with `fixest`/`lm`, Python with `statsmodels`/`linearmodels`)
   - Which formatting style? (AEA, journal-specific, or default `booktabs`)
   - How many models/columns?

2. **Generate the Table**

   Based on context, produce LaTeX code following these conventions:

   - Use `booktabs` for clean horizontal rules (`\toprule`, `\midrule`, `\bottomrule`)
   - Use `threeparttable` for structured notes below the table
   - Use `siunitx` `S` columns for decimal-aligned numbers
   - Include `\label{}` and `\caption{}` for cross-referencing
   - Standard errors in parentheses, significance stars in the coefficient cell

3. **Provide Code-Generated Alternative**

   Always show how to generate the table programmatically:

   **R (preferred):**
   ```r
   # Using modelsummary (most flexible)
   library(modelsummary)
   modelsummary(
     list("(1)" = model1, "(2)" = model2, "(3)" = model3),
     stars = c('*' = 0.1, '**' = 0.05, '***' = 0.01),
     output = "tables/main_results.tex"
   )

   # Using fixest::etable (fast, integrated with feols)
   library(fixest)
   etable(model1, model2, model3,
          tex = TRUE,
          file = "tables/main_results.tex")
   ```

   **Python (secondary):**
   ```python
   from stargazer.stargazer import Stargazer
   # or use statsmodels summary.as_latex()
   ```

4. **Integration with Beamer**

   When the table is for slides, wrap in appropriate custom environment:

   ```latex
   \begin{methodbox}
   \begin{table}
   \centering\footnotesize
   % table content (use \footnotesize for slides)
   \end{table}
   \end{methodbox}
   ```

5. **Verify and Explain**
   - Confirm the table compiles cleanly
   - Note any `siunitx` or package requirements
   - Suggest refinements for the target journal

## Table Patterns

### Regression Table
```latex
\begin{table}[htbp]
\centering
\begin{threeparttable}
\caption{Effect of Treatment on Outcome}
\label{tab:main_results}
\begin{tabular}{l*{3}{S[table-format=-1.3]}}
\toprule
 & {(1)} & {(2)} & {(3)} \\
\midrule
Treatment & 0.125{***} & 0.118{***} & 0.102{**} \\
 & {(0.041)} & {(0.039)} & {(0.046)} \\[0.5em]
Controls & {No} & {Yes} & {Yes} \\
Fixed Effects & {No} & {No} & {Yes} \\
\midrule
Observations & {2,145} & {2,145} & {2,145} \\
R-squared & 0.18 & 0.24 & 0.31 \\
\bottomrule
\end{tabular}
\begin{tablenotes}
\small
\item \textit{Notes:} Standard errors in parentheses.
{*} $p<0.10$, {**} $p<0.05$, {***} $p<0.01$.
\end{tablenotes}
\end{threeparttable}
\end{table}
```

### Summary Statistics Table
```latex
\begin{table}[htbp]
\centering
\begin{threeparttable}
\caption{Summary Statistics}
\label{tab:summary}
\begin{tabular}{l*{5}{S[table-format=4.2]}}
\toprule
 & {Mean} & {SD} & {Min} & {Max} & {N} \\
\midrule
Income (\$1000s) & 45.23 & 12.81 & 8.50 & 150.00 & {2,145} \\
Education (years) & 13.40 & 2.51 & 8.00 & 20.00 & {2,145} \\
\bottomrule
\end{tabular}
\end{threeparttable}
\end{table}
```

## Required LaTeX Packages

```latex
\usepackage{booktabs}       % Clean table rules
\usepackage{threeparttable}  % Structured table notes
\usepackage{siunitx}         % Decimal alignment (optional)
```

## Best Practices

1. **Keep tables compact** — one page maximum
2. **Consistent notation** for SEs and significance across all tables in the paper
3. **Code-generate tables** whenever possible (see `/r-econometrics` for estimation, then pipe to `modelsummary`)
4. **Number columns** (1), (2), (3) for easy reference in text
5. **Descriptive captions** — a reader should understand the table without reading the text
