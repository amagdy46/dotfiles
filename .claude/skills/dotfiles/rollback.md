# Dotfiles Rollback Skill

## Purpose
Safely rollback dotfile changes by undoing recent commits.

## How It Works

This skill helps you undo commits when:
- You committed a mistake
- Changes broke something
- You want to revert to a previous state
- You committed the wrong files

The skill:
1. Shows recent commit history
2. Asks how many commits to rollback
3. Confirms the action
4. Executes the rollback
5. Verifies success

## When to Use

Use this skill when you need to:
- **Undo a recent commit** that caused issues
- **Revert configuration changes** that broke something
- **Roll back multiple commits** to a known good state
- **Fix a commit mistake** before anyone else pulls

## Usage

### Interactive (Recommended)
```
/dotfiles-rollback
```
Claude will show recent commits and ask how many to undo.

### With Number of Commits
```
/dotfiles-rollback 1    # Undo last commit
/dotfiles-rollback 3    # Undo last 3 commits
```

## What Claude Does

### 1. Show Recent Commits

```bash
config log --oneline -10
```

Displays the last 10 commits so you can see what will be removed:
```
8a73f21 (HEAD -> main) Add broken keybinding
7b62e10 Update Waybar styling
6c51d09 Configure Alacritty font
5d40c08 Add Neovim plugin
4d64d2f Initial dotfiles commit
```

### 2. Ask for Confirmation

"How many commits would you like to rollback? (default: 1)"

Shows which commits will be removed based on your answer.

### 3. Confirm the Action

"⚠️ This will PERMANENTLY remove the last N commit(s) from history:
- Commit 1: Add broken keybinding
- Commit 2: Update Waybar styling

Your files will be reverted to their state before these commits.
Continue? (yes/no)"

### 4. Execute Rollback

```bash
config reset --hard HEAD~N
```

Where `N` is the number of commits to undo.

This command:
- Moves the branch pointer back N commits
- Resets the working directory to match
- Discards all changes in those commits

### 5. Verify Success

```bash
config log --oneline -5
config status
```

Shows you're now at the earlier commit, with a clean working directory.

### 6. Handle Remote Sync

If commits were already pushed to GitHub:

"⚠️ Warning: These commits were already pushed to GitHub.
Your local branch is now behind origin/main.

To sync GitHub with your rollback, you need to force push:
  config push origin main --force

⚠️ CAUTION: Force push rewrites history on GitHub. Only do this if:
1. You're the only one using this repository, OR
2. You've coordinated with others who may have pulled these commits

Alternatively, you can pull to restore the commits:
  config pull origin main

What would you like to do?"

## Example Scenarios

### Example 1: Simple Rollback (Not Pushed)

**You:**
```
/dotfiles-rollback
```

**Claude:**
```bash
config log --oneline -10
# Shows:
# 8a73f21 (HEAD -> main) Add VSCode keybinding
# 7b62e10 (origin/main) Update Waybar styling
# ...
```

"Recent commits:
1. 8a73f21 - Add VSCode keybinding (not pushed yet)
2. 7b62e10 - Update Waybar styling (pushed to GitHub)

How many commits to rollback? (default: 1)"

**You:** "1"

**Claude:**
"⚠️ This will remove: Add VSCode keybinding
Continue? (yes/no)"

**You:** "yes"

**Claude:**
```bash
config reset --hard HEAD~1
# HEAD is now at 7b62e10 Update Waybar styling

config status
# On branch main, nothing to commit, working tree clean
```

"✓ Rolled back 1 commit. You're now at: Update Waybar styling"

### Example 2: Rollback Multiple Commits

**You:**
```
/dotfiles-rollback 3
```

**Claude:**
```bash
config log --oneline -10
```

"This will remove the last 3 commits:
1. Add broken keybinding
2. Update Waybar styling
3. Configure Alacritty font

You'll be back to: Add Neovim plugin

⚠️ All changes in these commits will be lost.
Continue? (yes/no)"

**You:** "yes"

**Claude:**
```bash
config reset --hard HEAD~3
```

"✓ Rolled back 3 commits."

### Example 3: Rollback After Push (Force Push Needed)

**You:**
```
/dotfiles-rollback
```

**Claude:**
"Recent commits:
1. 8a73f21 - Add broken config (PUSHED to GitHub)

Rollback 1 commit? (yes/no)"

**You:** "yes"

**Claude:**
```bash
config reset --hard HEAD~1
config status
# Your branch is behind 'origin/main' by 1 commit
```

"Rolled back locally. The commit still exists on GitHub.

⚠️ To remove it from GitHub, force push:
  config push origin main --force

Or to restore it locally:
  config pull origin main

What would you like to do?"

## Safety Features

✅ **Shows what will be removed** - You see commits before deletion

✅ **Asks for confirmation** - Prevents accidental rollbacks

✅ **Warns about force push** - Alerts you if commits were pushed

✅ **Verifies success** - Shows new state after rollback

## Rollback vs. Revert

**Rollback (this skill):**
- Removes commits from history (rewrites history)
- Use when commits haven't been pushed, or you're okay with force push
- `git reset --hard HEAD~N`

**Revert (manual):**
- Creates new commit that undoes changes (preserves history)
- Use when commits are pushed and others may have pulled them
- `git revert <commit-hash>`

## Recovery Options

If you rolled back by mistake:

### If You Just Rolled Back

```bash
# Find the lost commit
config reflog
# Shows: 8a73f21 HEAD@{1}: reset: moving to HEAD~1

# Restore it
config reset --hard 8a73f21
```

### If You Pushed After Rollback

Contact anyone who may have pulled your commits before force pushing.

## Manual Rollback Methods

### Rollback N Commits
```bash
config reset --hard HEAD~N
# Or use the helper:
config-rollback N
```

### Rollback to Specific Commit
```bash
# Get commit hash
config log --oneline

# Reset to that commit
config reset --hard <commit-hash>
```

### Rollback Single File
```bash
# Revert one file to previous commit
config checkout HEAD~1 -- ~/.config/hypr/bindings.conf

# Commit the reversion
config-commit "Revert bindings.conf to previous version"
```

## Tips

💡 **Use reflog for safety** - `config reflog` shows all recent pointer movements

💡 **Test before rolling back** - Try `config diff HEAD~1` to see what you'll lose

💡 **Commit first** - If you have uncommitted changes, commit or stash them before rollback

💡 **Coordinate on shared repos** - If others use your dotfiles, communicate before force pushing

## Common Use Cases

**Broke Hyprland config:**
```
/dotfiles-rollback 1
# Restores working Hyprland config
hyprctl reload
```

**Committed sensitive data:**
```
/dotfiles-rollback 1
# Remove commit with secrets
# Add file to .gitignore
# Verify file is excluded
/dotfiles-commit
```

**Experimental changes didn't work:**
```
/dotfiles-rollback 5
# Back to stable state
```

## Related Skills

- `/dotfiles-status` - See commits before deciding to rollback
- `/dotfiles-commit` - Create new commit after fixing issues
- `/dotfiles-track` - Re-add files if needed after rollback

## Technical Details

**Uses:**
- `config reset --hard HEAD~N` - Resets to N commits ago
- `config-rollback N` helper function (defined in `.zshrc`)
- `config log` - Shows commit history
- `config reflog` - Shows all ref changes for recovery

**Effect:**
- Moves HEAD pointer back N commits
- Resets index (staging area) to match
- Resets working directory to match
- Changes are PERMANENT (unless recovered via reflog)

**Git reminders:**
- `HEAD~1` = 1 commit before HEAD
- `HEAD~3` = 3 commits before HEAD
- `--hard` = reset working directory too (vs. `--soft` which keeps changes)

---

This skill provides a safe way to undo commits with proper warnings and confirmations. Use it when you need to revert changes quickly and cleanly.
