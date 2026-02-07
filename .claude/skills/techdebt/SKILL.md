---
name: techdebt
description: Find technical debt across LaTeX, R, Quarto, Python, and project config. Reports to quality_reports/ without making direct edits.
disable-model-invocation: true
argument-hint: "[optional directory or file to scan]"
---

# Technical Debt Finder

Identify technical debt across all project file types. Produces a report — never edits files directly.

## Steps

1. **Determine Scope**
   - If argument provided, scan that directory/file only
   - Otherwise, scan the full project

2. **Scan by Category**

   For each file type present, check for the issues listed below.

   ### LaTeX (`.tex`)
   - Unused `\newcommand` definitions (defined but never referenced)
   - Orphan `\label{}` tags (labels that no `\ref{}` points to)
   - Commented-out `\begin{frame}` blocks (dead slides)
   - Inconsistent `\cite` vs `\citet` vs `\citep` usage
   - Overfull/underfull hbox warnings (compile and check log)
   - Hardcoded numbers that should be macro-generated

   ### R (`.R`)
   - Unused `library()` calls (loaded but no functions used)
   - Duplicated code blocks across scripts
   - Hardcoded file paths (should be relative to project root)
   - Missing or outdated comments
   - Functions over 50 lines
   - Non-standard variable names (should follow `r-code-conventions.md`)

   ### Quarto (`.qmd`)
   - Duplicate CSS class definitions
   - Slides with no content (empty frames)
   - Broken cross-references (`{{< ref >}}` to missing targets)
   - Inconsistent heading levels
   - Missing `---` slide separators

   ### Python (`.py`)
   - Unused imports
   - Missing type hints on public functions
   - Missing docstrings on public functions
   - Hardcoded API keys or secrets
   - Functions over 50 lines

   ### Project Config
   - Stale entries in `settings.json` (permissions for tools not used)
   - Orphan skills (directories in `.claude/skills/` not referenced in CLAUDE.md)
   - Orphan rules (files in `.claude/rules/` that don't match any paths)
   - Unused bibliography entries (in `.bib` but never `\cite`d)
   - Empty or placeholder files in `quality_reports/`

3. **Classify Findings**

   | Severity | Definition | Examples |
   |----------|-----------|---------|
   | High | Affects correctness or compilation | Broken references, unused labels causing warnings |
   | Medium | Affects maintainability | Duplicated code, unused imports |
   | Low | Cosmetic or minor | Style inconsistencies, minor naming issues |

4. **Generate Report**

   Save to `quality_reports/techdebt_report_YYYY-MM-DD.md`:

   ```markdown
   # Technical Debt Report
   **Date:** YYYY-MM-DD
   **Scope:** [directory/file or "full project"]

   ## Summary
   - High: N issues
   - Medium: N issues
   - Low: N issues

   ## Findings by Category

   ### LaTeX
   | # | Severity | File | Line | Issue |
   |---|----------|------|------|-------|
   | 1 | High | Slides/Lecture01.tex | 42 | Orphan \label{fig:old} — no \ref points to it |

   ### R
   ...

   ### Recommended Fixes (prioritized)
   1. [High-severity fix 1]
   2. [High-severity fix 2]
   3. ...
   ```

5. **Present Summary**
   - Show the user the summary counts and top 5 highest-severity issues
   - Ask if they want to proceed with fixes or review the full report first

## Important

**This skill NEVER makes direct edits.** It produces a report to `quality_reports/` and waits for user approval before any changes are made.

## Arguments

- `/techdebt` — Scan entire project
- `/techdebt Slides/` — Scan specific directory
- `/techdebt Quarto/Lecture3.qmd` — Scan specific file
