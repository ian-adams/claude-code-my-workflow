# Upstream Sync Reminder

At session startup (when reading CLAUDE.md and checking git log), also check for upstream template updates:

1. Run `git fetch upstream 2>/dev/null` and `git log main..upstream/main --oneline 2>/dev/null`
2. If there are new upstream commits, mention it briefly in the startup summary:
   > "There are N new commits upstream. Run `/sync-upstream` to review them."
3. If `git fetch upstream` fails (no upstream remote configured), skip silently — do not nag or suggest adding one
4. Only check once per session at startup — do not repeat this check later in the conversation
