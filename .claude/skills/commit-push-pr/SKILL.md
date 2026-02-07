---
name: commit-push-pr
description: Commit changes, push to remote, and create a pull request with pre-commit checks for LaTeX, R, Quarto, and Python.
disable-model-invocation: true
argument-hint: "[optional commit message]"
---

# Commit, Push, and Create PR

Automate the git workflow for completing a feature or fix. Runs language-appropriate pre-commit checks before committing.

## Steps

1. **Gather Context**
   - Current branch: `git branch --show-current`
   - Git status: `git status --short`
   - Recent commits: `git log --oneline -5`
   - Diff summary: `git diff --stat`

2. **Review Changes**
   - Check `git status` for all modified/added files
   - Review the diff to understand what's being committed
   - Ensure no sensitive files are staged (`.env`, credentials, API keys)
   - Ensure no LaTeX artifacts are staged (`.aux`, `.log`, `.bbl`, `.blg`, `.fls`, `.fdb_latexmk`, `.synctex.gz`, `.out`, `.nav`, `.snm`, `.toc`, `.vrb`)

3. **Run Pre-commit Checks (by file type)**

   For each changed file type, run the appropriate check:

   | File Type | Check Command | What It Catches |
   |-----------|--------------|-----------------|
   | `.tex` | `TEXINPUTS=../Preambles:$TEXINPUTS xelatex -interaction=nonstopmode -halt-on-error <file>` | LaTeX compilation errors |
   | `.R` | `Rscript -e "source('<file>')"` | R syntax errors (skip if script requires data) |
   | `.qmd` | `quarto render <file>` | Quarto rendering errors |
   | `.py` | `python -m py_compile <file>` | Python syntax errors |

   If a pre-commit check fails, **stop and report the error**. Do not commit broken code.

4. **Stage and Commit**
   - Stage relevant files: `git add <specific files>` (never `git add .` or `git add -A`)
   - Use Conventional Commits format with academic project conventions:
     - `feat:` — new lecture, skill, or major content
     - `fix:` — bug fixes, compilation fixes, citation corrections
     - `docs:` — CLAUDE.md, README, session logs
     - `content:` — slide content additions/modifications
     - `refactor:` — reorganizing without changing behavior
     - `style:` — formatting, CSS, theme changes
     - `chore:` — dependency updates, config changes
   - Write a clear, concise commit message focusing on "why"
   - Example: `feat: add Lecture 5 DiD slides with event study figures`
   - Example: `fix: correct Callaway-Sant'Anna citation year (2021 not 2020)`

5. **Push to Remote**
   - Push the branch: `git push -u origin HEAD`
   - If branch doesn't exist on remote, create it

6. **Create Pull Request** (if on a feature branch, not main)
   - Use GitHub CLI: `gh pr create`
   - Include clear title and description
   - Reference any related issues
   - Run `/proofread` on any modified `.tex` or `.qmd` files before creating the PR

## Arguments

Pass a commit message or leave empty for auto-generated message based on changes.

Usage: `/commit-push-pr [optional commit message]`

Example: `/commit-push-pr feat: add Lecture 5 DiD slides`

## Output

Return the commit hash and PR URL (if created) when complete.
