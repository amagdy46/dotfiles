# Dotfiles Management Guide

## Overview

Your dotfiles are managed using a **bare git repository** approach. This elegant solution tracks configuration files in their original locations without requiring symlinks or special directory structures.

## Repository Information

- **Location**: `~/.dotfiles` (bare git repository)
- **Remote**: git@github.com:amagdy46/dotfiles.git
- **Branch**: main
- **Owner**: Abdulrahman Magdy (abdulrahman.magdy406@gmail.com)
- **Tracking Method**: Files in place (no symlinks)

## Philosophy

Unlike traditional dotfiles setups that use symlinks (~/dotfiles/ → ~/.config/), this approach:
- Tracks files directly in their normal locations
- No symlink management required
- System works naturally—applications find configs where they expect
- Clean separation: repository metadata in `~/.dotfiles/`, configs everywhere else

## Core Commands

All dotfiles operations use the `config` alias, which is defined in `.zshrc`:

```bash
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

This alias makes `config` work exactly like `git`, but for your dotfiles repository.

### Status & Viewing

**Check what's changed:**
```bash
config status
```
Shows modified tracked files, staged changes, and current branch status.

**View changes:**
```bash
config diff
```
Shows line-by-line differences for all changed files.

**View commit history:**
```bash
config-log
# Alias for: config log --oneline --decorate --graph --all
```
Beautiful graph of commit history with branches.

**View recent commits:**
```bash
config log --oneline -5
```
Last 5 commits in compact format.

### Making Changes

The recommended workflow for editing configs:

**1. Edit configs normally in their locations**
```bash
# For example:
nvim ~/.config/hypr/bindings.conf
nvim ~/.zshrc
nvim ~/.config/alacritty/alacritty.toml
```

**2. View your changes**
```bash
config diff
```
Review what changed before committing.

**3. Commit changes (recommended method)**
```bash
config-commit "description of changes"
```

This helper function (defined in `.zshrc`):
- Stages all tracked files that changed (`config add -u`)
- Commits with your message
- Pushes to GitHub
- Shows confirmation

**Manual commit method:**
```bash
# Stage all tracked changes
config add -u

# Or stage specific file
config add ~/.config/hypr/bindings.conf

# Commit
config commit -m "Add keybinding for Obsidian"

# Push
config push origin main
```

### Adding New Files

When you create a new config file that should be tracked:

```bash
# Add the file
config add ~/.config/newapp/config.yml

# Commit
config commit -m "Add newapp configuration"

# Push
config push origin main
```

**Using the skill:**
```bash
/dotfiles-track
```
Claude will help you add files interactively.

### Rollback & Recovery

**Undo last commit:**
```bash
config-rollback
# Alias for: config reset --hard HEAD~1
```

**Undo multiple commits:**
```bash
config-rollback 3
# Rolls back last 3 commits
```

**Revert a single file:**
```bash
config checkout HEAD -- <file>
# Example: config checkout HEAD -- ~/.zshrc
```

**Nuclear option (match GitHub exactly):**
```bash
config reset --hard origin/main
```
⚠️ Warning: Loses all local uncommitted changes!

**View what will be lost before resetting:**
```bash
config diff HEAD origin/main
```

### Viewing History

**See what changed in a commit:**
```bash
config show <commit-hash>
```

**See when a file was last changed:**
```bash
config log -- ~/.config/hypr/bindings.conf
```

**Search commits by message:**
```bash
config log --grep="keybinding"
```

## Best Practices

### DO:

✅ **Commit related changes together**
```bash
# Good: Related changes in one commit
config-commit "Update Hyprland keybindings and add new workspace layout"
```

✅ **Write descriptive commit messages**
```bash
# Good messages:
config-commit "Add Obsidian keybinding (Super+Shift+O)"
config-commit "Update Alacritty font to JetBrainsMono Nerd Font"
config-commit "Configure mise to use Node 20 LTS"

# Bad messages:
config-commit "update stuff"
config-commit "changes"
config-commit "fix"
```

✅ **Review with `config diff` before committing**
Always see what you're committing to avoid surprises.

✅ **Use `config-commit` for convenience**
It stages, commits, and pushes in one command.

✅ **Backup before major changes**
```bash
# Create a safety commit before risky changes
config-commit "Backup before major Hyprland configuration changes"
```

### DON'T:

❌ **Don't commit sensitive data**
Never commit:
- `.env` files
- API keys or tokens
- Passwords or credentials
- SSH keys (`~/.ssh/`)
- GPG keys (`~/.gnupg/`)
- AWS credentials (`~/.aws/credentials`)

These are already excluded in `.gitignore`.

❌ **Don't commit large binary files**
Avoid:
- Images (unless small icons for configs)
- Videos
- Compiled binaries
- Large datasets

❌ **Don't edit files directly in `~/.dotfiles/`**
The bare repository has no working tree. Always edit files in their normal locations:
- ✅ Edit `~/.zshrc`
- ❌ Don't edit `~/.dotfiles/zshrc` (doesn't exist anyway)

❌ **Don't skip the review step**
Always run `config diff` before committing to know what's changing.

## What's Tracked

Your dotfiles repository tracks:

**Shell Configurations:**
- `.zshrc` - Zsh interactive shell config
- `.zshenv` - Environment variables
- `.zimrc` - Zim framework modules
- `.bashrc`, `.bash_profile`, `.profile` - Bash configs

**Hyprland (Window Manager):**
- Complete `~/.config/hypr/` directory
  - `hyprland.conf`, `bindings.conf`, `monitors.conf`, `input.conf`
  - `looknfeel.conf`, `autostart.conf`, `hypridle.conf`, `hyprlock.conf`
  - Shaders in `shaders/` directory

**Waybar (Status Bar):**
- `~/.config/waybar/config.jsonc`
- `~/.config/waybar/style.css`

**Terminals:**
- `~/.config/alacritty/alacritty.toml`
- `~/.config/kitty/kitty.conf`
- `~/.config/ghostty/config`

**Neovim:**
- Complete `~/.config/nvim/` directory
  - LazyVim configuration
  - Custom plugins
  - `lazy-lock.json` (plugin versions)

**Development Tools:**
- `~/.config/git/config` - Git configuration
- `~/.config/starship.toml` - Starship prompt
- `~/.config/lazygit/config.yml` - LazyGit TUI
- `~/.config/mise/config.toml` - Mise version manager

**System Utilities:**
- `~/.config/btop/btop.conf` - System monitor
- `~/.config/mako/config` - Notifications
- `~/.local/bin/` - Custom scripts

**Claude Code:**
- `~/.claude/` - Skills and documentation (this directory)

See `tracked-files.md` for the complete list.

## New Machine Setup

To set up your dotfiles on a new machine:

**1. Clone the bare repository:**
```bash
git clone --bare git@github.com:amagdy46/dotfiles.git ~/.dotfiles
```

**2. Run the bootstrap script:**
```bash
bash <(curl -s https://raw.githubusercontent.com/amagdy46/dotfiles/main/bootstrap.sh)
```

The bootstrap script:
- Creates the `config` alias temporarily
- Checks out your dotfiles
- Backs up any existing conflicting files
- Configures git to hide untracked files
- Sets up the permanent `config` alias

**3. Install Zim Framework:**
```bash
source ~/.zshrc
# Zim will auto-install on first run
```

**4. Reload shell:**
```bash
exec zsh
```

**5. Verify setup:**
```bash
config status
# Should show: "On branch main, Your branch is up to date with 'origin/main'"
```

## Integration with Claude

Claude can help manage your dotfiles using these skills:

**`/dotfiles-commit`**
Commit changes with AI-generated commit message based on what changed.

**`/dotfiles-status`**
Quick overview of repository state, recent commits, and pending changes.

**`/dotfiles-track`**
Add new configuration files to dotfiles tracking.

**`/dotfiles-rollback`**
Safely rollback changes with confirmation.

These skills understand your dotfiles workflow and use the `config` alias correctly.

## Common Tasks

### Sync Changes from Another Machine

```bash
# Pull latest changes
config pull origin main
```

### See All Tracked Files

```bash
config ls-tree -r main --name-only
```

### Untrack a File (Keep Local Copy)

```bash
config rm --cached <file>
config commit -m "Stop tracking <file>"
config push origin main
```

The file remains on disk but is no longer tracked.

### Find Files Modified Recently

```bash
config log --since="2 weeks ago" --name-only
```

### Compare with Remote

```bash
# Fetch latest remote state
config fetch

# See differences
config diff origin/main
```

## Troubleshooting

**Changes not showing up:**
1. Verify file is tracked: `config ls-files | grep <filename>`
2. If not tracked, add it: `config add <file>`
3. Check status: `config status`

**Conflicts after pull:**
```bash
# See conflicting files
config status

# For each conflict, choose:
# Keep your version: config checkout --ours <file>
# Use remote version: config checkout --theirs <file>
# Or manually edit the file to resolve

# After resolving:
config add <resolved-files>
config commit -m "Resolve merge conflicts"
config push origin main
```

**Accidentally committed sensitive data:**
```bash
# Remove from history (requires force push)
config filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch <sensitive-file>' \
  --prune-empty --tag-name-filter cat -- --all

# Force push (⚠️ WARNING: rewrites history)
config push origin main --force
```

Better: Add to `.gitignore` immediately to prevent tracking sensitive files.

## Advanced Usage

### Create a Branch for Experiments

```bash
# Create and switch to new branch
config checkout -b experimental-theme

# Make changes and commit
config-commit "Experiment with new theme settings"

# Switch back to main
config checkout main

# Merge if successful
config merge experimental-theme
```

### Tag Stable Configurations

```bash
# Create tag
config tag v1.0-stable

# Push tags
config push origin --tags

# Revert to tagged version later
config checkout v1.0-stable
```

### View Beautiful Diff

```bash
# Use delta or diff-so-fancy if installed
config diff | delta
```

## Workflow Example

A typical editing session:

```bash
# 1. Check current state
config status
# Output: On branch main, nothing to commit

# 2. Edit configuration
nvim ~/.config/hypr/bindings.conf
# Add: bindd = SUPER SHIFT, V, VSCode, exec, code

# 3. See what changed
config diff
# Shows the new keybinding line added

# 4. Commit with descriptive message
config-commit "Add VSCode keybinding (Super+Shift+V)"
# ✓ Committed and pushed: Add VSCode keybinding (Super+Shift+V)

# 5. Verify
config log --oneline -1
# Shows latest commit
```

## Tips

- **Muscle memory**: Use `config` exactly like `git`—all git commands work
- **Frequent commits**: Commit often with clear messages for better history
- **Pull before major changes**: `config pull` to avoid conflicts
- **Test before commit**: Verify configs work before committing
- **Use skills**: Let Claude help with commits, tracking, and status via skills

Your dotfiles are the backbone of your system configuration. Keep them clean, well-organized, and regularly backed up to GitHub!
