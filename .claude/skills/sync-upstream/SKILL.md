---
name: sync-upstream
description: Check for and merge changes from the upstream template repository. Default is check-only; use --apply to merge.
disable-model-invocation: true
argument-hint: "[--check (default) | --apply]"
---

# Sync Upstream Template Changes

Check for new commits in the upstream template repo and optionally merge them into the current project.

## Modes

- **Check mode** (default, or `--check`): Report what's new upstream without changing anything
- **Apply mode** (`--apply`): Create a branch, merge upstream changes, and open a PR

## Steps

### Phase 1: Preflight

1. **Verify `upstream` remote exists:**
   ```bash
   git remote get-url upstream
   ```
   If this fails, stop and tell the user:
   > "No `upstream` remote configured. Add one with:
   > ```
   > git remote add upstream https://github.com/OWNER/REPO.git
   > ```
   > For projects forked from the template, use:
   > ```
   > git remote add upstream https://github.com/ian-adams/claude-code-my-workflow.git
   > ```"

2. **Fetch upstream:**
   ```bash
   git fetch upstream
   ```

3. **Check for new commits:**
   ```bash
   git log main..upstream/main --oneline
   ```
   If no new commits, report "Already up to date with upstream" and stop.

### Phase 2: Analyze Changes

4. **List changed files with stats:**
   ```bash
   git diff --stat main..upstream/main
   ```

5. **Show commit details:**
   ```bash
   git log main..upstream/main --format="%h %s (%an, %ar)"
   ```

6. **Categorize changes** into two buckets:

   **Infrastructure (safe to merge):**
   - `.claude/skills/` — new or updated skills
   - `.claude/agents/` — new or updated agents
   - `.claude/rules/` — new or updated rules
   - `.claude/settings.json` — permission updates
   - `scripts/` — utility scripts
   - `guide/` — documentation updates
   - `examples/` — example outputs

   **Project content (likely to conflict in customized projects):**
   - `CLAUDE.md` — project-specific customizations
   - `Slides/` — lecture content
   - `Quarto/` — slide content
   - `Figures/` — project figures
   - `data/` — project data
   - `Bibliography_base.bib` — project bibliography
   - `Preambles/` — LaTeX preamble customizations

7. **Report findings:**
   - Number of new commits
   - List of infrastructure changes (safe)
   - List of project content changes (may conflict)
   - Suggest: "Run `/sync-upstream --apply` to merge these changes"

   **If mode is `--check`, stop here.**

### Phase 3: Apply (only with `--apply`)

8. **Ensure clean working tree:**
   ```bash
   git status --porcelain
   ```
   If there are uncommitted changes, stop and tell the user to commit or stash first.

9. **Create sync branch:**
   ```bash
   git checkout -b sync-upstream-YYYY-MM-DD
   ```
   Use today's date.

10. **Merge upstream (no-commit):**
    ```bash
    git merge upstream/main --no-commit --no-ff
    ```

11. **Check for conflicts:**
    ```bash
    git diff --name-only --diff-filter=U
    ```

    **If conflicts exist:**
    - List all conflicting files
    - Categorize them (infrastructure vs project content)
    - For infrastructure conflicts: suggest accepting upstream version (`git checkout --theirs <file>`)
    - For project content conflicts: advise manual resolution
    - Stop and wait for the user to resolve conflicts before continuing

    **If clean merge:**
    - Show summary of merged changes
    - Commit the merge:
      ```bash
      git commit -m "Sync upstream template changes (YYYY-MM-DD)"
      ```

12. **Determine the correct repo for PR:**
    ```bash
    git remote get-url origin
    ```
    Extract `OWNER/REPO` from the origin URL.

13. **Push and create PR:**
    ```bash
    git push -u origin sync-upstream-YYYY-MM-DD
    ```
    Then create PR with `--repo` flag (critical — without this, `gh` may target upstream):
    ```bash
    gh pr create --repo OWNER/REPO --title "Sync upstream template changes (YYYY-MM-DD)" --body "## Summary
    - Merged N new commits from upstream template
    - Infrastructure changes: [list]
    - Project content changes: [list]

    ## Review Notes
    [Any conflicts resolved or notable changes]"
    ```

14. **Report results:**
    - PR URL
    - What was merged
    - Any manual steps remaining

## Important Notes

- **Always use `--repo` flag** on `gh pr create` when both `origin` and `upstream` remotes exist. Without it, `gh` may default to creating the PR against the upstream repo.
- **Merge, not rebase.** Merge preserves local commit history and makes conflict resolution clearer.
- **`--no-commit` on merge** gives Claude a chance to review the merge result before committing.
- **Never force-push** the sync branch.
- The categorization (infrastructure vs project content) is a guide, not a rule. Some infrastructure changes may need project-specific adaptation.

## Common Pitfalls

- Forgetting `--repo` on `gh pr create` → PR goes to upstream instead of your fork
- Trying to merge with uncommitted local changes → git refuses
- Upstream renames a file that you've also modified → conflict even though content is compatible
- `.claude/settings.json` conflicts if both upstream and project added new permissions → merge both permission lists
