# Dotfiles Status Skill

## Purpose
Get a quick, comprehensive overview of your dotfiles repository state without making any changes.

## How It Works

This skill shows you:
- Current branch and sync status with GitHub
- Modified tracked files
- Staged changes ready to commit
- Recent commit history
- Whether you're ahead/behind the remote

## When to Use

Use this skill whenever you want to:
- Check if you have uncommitted changes
- See what's been modified before committing
- View recent commit history
- Check sync status with GitHub
- Get a quick snapshot of repository state

## Usage

Simply invoke the skill:
```
/dotfiles-status
```

Claude will provide a comprehensive status report.

## What Claude Shows

### 1. Current Repository State

```bash
config status
```

Shows:
- **Current branch** (usually `main`)
- **Sync status**: ahead, behind, or up-to-date with origin/main
- **Modified files**: Tracked files that have changes
- **Staged changes**: Files ready to be committed
- **Untracked files**: New files not yet in the repository (if any)

### 2. Recent Commit History

```bash
config log --oneline --decorate --graph --all -5
```

Displays the last 5 commits in a beautiful graph format with:
- Commit hashes (short form)
- Commit messages
- Branch pointers
- Graph showing commit relationships

### 3. Summary Analysis

Claude interprets the output and provides human-readable summary:
- "You have 2 modified files: .zshrc and hypr/bindings.conf"
- "Your local branch is 1 commit ahead of origin/main - ready to push"
- "Everything is clean and synced with GitHub"
- "You have uncommitted changes in 3 files"

## Example Output Scenarios

### Scenario 1: Clean State

```
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean

Recent commits:
* 4d64d2f (HEAD -> main, origin/main) Initial dotfiles commit
```

**Claude's summary:**
"Your dotfiles are clean and fully synced with GitHub. No pending changes."

### Scenario 2: Uncommitted Changes

```
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  modified:   .zshrc
  modified:   .config/hypr/bindings.conf

no changes added to commit

Recent commits:
* 4d64d2f (HEAD -> main, origin/main) Add VSCode keybinding
* 3c52a1e Update terminal fonts
```

**Claude's summary:**
"You have uncommitted changes in 2 files:
- .zshrc
- .config/hypr/bindings.conf

Use /dotfiles-commit to commit these changes or config diff to see what changed."

### Scenario 3: Ahead of Remote

```
On branch main
Your branch is ahead of 'origin/main' by 2 commits.

nothing to commit, working tree clean

Recent commits:
* 8a73f21 (HEAD -> main) Add Obsidian keybinding
* 7b62e10 Update Waybar styling
* 4d64d2f (origin/main) Initial dotfiles commit
```

**Claude's summary:**
"Your local repository has 2 commits that haven't been pushed to GitHub yet:
1. Add Obsidian keybinding
2. Update Waybar styling

Run config push origin main to sync with GitHub."

### Scenario 4: Behind Remote

```
On branch main
Your branch is behind 'origin/main' by 1 commit.

nothing to commit, working tree clean

Recent commits:
* 9d84g32 (origin/main) Update Neovim plugins
* 4d64d2f (HEAD -> main) Initial dotfiles commit
```

**Claude's summary:**
"GitHub has 1 new commit that you don't have locally yet.
Run config pull origin main to sync."

## Benefits

✅ **Non-destructive** - Only reads, never modifies anything

✅ **Comprehensive** - Shows all relevant information at once

✅ **Quick** - Instant snapshot of repository state

✅ **Visual** - Graph view of commit history

✅ **Interpreted** - Claude explains what the status means

## Use Cases

**Before committing:**
```
/dotfiles-status
# Check what's changed before running /dotfiles-commit
```

**After editing configs:**
```
# Edit ~/.zshrc
/dotfiles-status
# Verify the change is detected
```

**Regular check-in:**
```
/dotfiles-status
# Daily check to see if you have uncommitted work
```

**Before pulling:**
```
/dotfiles-status
# Check if you have local changes before pulling from GitHub
```

## What You Learn

From `/dotfiles-status`, you'll know:
- ✓ Do I have uncommitted changes?
- ✓ Which files have been modified?
- ✓ Am I in sync with GitHub?
- ✓ What were my recent commits?
- ✓ Do I need to push or pull?

## Comparison with Other Commands

**`config status`** (raw):
- Shows current state only
- No commit history
- Git output format

**`/dotfiles-status`** (this skill):
- Shows current state
- Shows recent commit history
- Human-readable summary from Claude
- Actionable recommendations

## Tips

- Run this before `/dotfiles-commit` to review what will be committed
- Run this after editing configs to verify changes are detected
- Use this as a "where am I?" command when you're unsure of repository state
- Run this before logging off to check for uncommitted work

## Related Skills

- `/dotfiles-commit` - Commit the changes shown in status
- `/dotfiles-track` - Add new files that appear as untracked
- `/dotfiles-rollback` - Undo recent commits shown in history

## Manual Equivalent

If you want to run these commands yourself:

```bash
# Current status
config status

# Recent commits with graph
config log --oneline --decorate --graph --all -5

# Or use the alias:
config-log
```

## Technical Details

**Uses:**
- `config` alias pointing to `~/.dotfiles/` bare repository
- `config status` - Shows working tree status
- `config log` - Shows commit history
- `config-log` alias for beautiful graph view

**Read-only operations:**
- No files modified
- No commits created
- No data sent to remote
- Safe to run anytime

---

This skill is your "dotfiles dashboard"—a quick way to understand the current state of your configuration management system.
