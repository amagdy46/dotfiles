# Dotfiles Management Setup Plan

## Overview
Set up a bare git repository dotfiles management system optimized for AI-assisted config editing with easy rollback capabilities.

## Approach
Using the **bare git repository method** - files stay in their original locations, no symlinks, pure git for version control and rollback.

## Critical Files to Modify/Create

### Files to Track in Git
**Shell Configurations:**
- `~/.zshrc` (4.4 KB) - Main Zsh config with Zim, Starship, custom aliases
- `~/.zshenv` (645 B) - Environment variables, PATH, AWS config
- `~/.zimrc` - Zim framework module configuration
- `~/.bashrc` - Bash interactive shell config
- `~/.bash_profile` - Bash startup
- `~/.profile` - POSIX profile

**~/.config/ Selective Tracking:**
- `~/.config/nvim/` - Neovim/LazyVim complete setup
- `~/.config/starship.toml` - Prompt configuration
- `~/.config/git/config` - Git global config with aliases
- `~/.config/alacritty/` - Alacritty terminal config
- `~/.config/kitty/` - Kitty terminal config
- `~/.config/ghostty/` - Ghostty terminal config
- `~/.config/lazygit/` - LazyGit config
- `~/.config/mise/` - Tool version manager config
- `~/.config/hypr/` - Hyprland window manager
- `~/.config/waybar/` - Wayland bar
- `~/.config/mako/` - Notification daemon
- `~/.config/btop/` - System monitor

**Other Dotfiles:**
- `~/.yarnrc` - Yarn configuration
- `~/.local/bin/switch-audio-to-headphones.sh` - Custom script
- `~/.local/bin/env` - Shell helper script

### Files to Create
- `~/.dotfiles/` - Bare git repository (will be hidden)
- `~/README.md` - Dotfiles documentation with AI instructions
- `~/bootstrap.sh` - Setup script for new machines
- `~/.gitignore` - Global gitignore for dotfiles repo

## Implementation Steps

### 1. Initialize Bare Git Repository
```bash
git init --bare ~/.dotfiles
```

### 2. Create and Add Config Alias to .zshrc
Add to the end of `~/.zshrc`:
```bash
# Dotfiles management with bare git repo
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Helper aliases for common operations
alias config-status='config status'
alias config-diff='config diff'
alias config-log='config log --oneline --decorate --graph --all'
alias config-push='config push origin main'

# Function for AI-assisted commits with auto-backup
config-commit() {
    config add -u  # Stage all tracked changes
    config commit -m "$1"
    config push origin main
    echo "✓ Committed and pushed: $1"
}

# Quick rollback function
config-rollback() {
    config reset --hard HEAD~${1:-1}
    echo "✓ Rolled back ${1:-1} commit(s)"
}
```

### 3. Configure Git Repository
```bash
# Hide untracked files (critical for bare repo method)
config config --local status.showUntrackedFiles no

# Set default branch
config config --local init.defaultBranch main

# Configure user info (already set globally, but good to confirm)
config config --local user.name "Abdulrahman Magdy"
config config --local user.email "abdulrahman.magdy406@gmail.com"
```

### 4. Create .gitignore for Home Directory
Create `~/.gitignore` with:
```
# Ignore everything by default
*

# Shell configs - explicitly track
!.zshrc
!.zshenv
!.zimrc
!.bashrc
!.bash_profile
!.profile

# Config directory - track selectively
!.config/
.config/*
!.config/nvim/
!.config/starship.toml
!.config/git/
!.config/alacritty/
!.config/kitty/
!.config/ghostty/
!.config/lazygit/
!.config/mise/
!.config/hypr/
!.config/waybar/
!.config/mako/
!.config/btop/

# Neovim - ignore cache/state files
.config/nvim/.luarc.json
.config/nvim/lazy-lock.json

# Other dotfiles
!.yarnrc

# Local binaries - selective
!.local/
.local/*
!.local/bin/
.local/bin/*
!.local/bin/switch-audio-to-headphones.sh
!.local/bin/env

# Dotfiles repo metadata
!README.md
!bootstrap.sh
!.gitignore

# Never track sensitive data
.ssh/
.gnupg/
.aws/credentials
*.pem
*.key
*_rsa
*_dsa
*_ecdsa
*_ed25519
```

### 5. Create README.md with AI Instructions
Create `~/README.md`:
```markdown
# Pokerface's Dotfiles

Personal dotfiles managed with bare git repository for easy AI-assisted editing and rollback.

## AI Instructions for Dotfiles Management

**Before editing any config:**
```bash
config status  # See current state
```

**After editing configs:**
```bash
config diff  # Show me what changed
```

**To commit changes:**
```bash
config-commit "description of changes"
# This auto-commits, and pushes to GitHub
```

**To rollback changes:**
```bash
config-rollback [number]  # Rollback N commits (default: 1)
config checkout HEAD -- <file>  # Revert single file
config reset --hard origin/main  # Nuclear: match GitHub
```

## Setup on New Machine

1. Clone this repository:
```bash
git clone --bare https://github.com/AbdulrahmanMagdy/dotfiles.git ~/.dotfiles
```

2. Run bootstrap script:
```bash
bash <(curl -s https://raw.githubusercontent.com/AbdulrahmanMagdy/dotfiles/main/bootstrap.sh)
```

## What's Tracked

- **Shell configs**: .zshrc, .zshenv, .zimrc, .bashrc, .bash_profile, .profile
- **Neovim**: Complete LazyVim setup (~/.config/nvim/)
- **Terminals**: Alacritty, Kitty, Ghostty configs
- **Dev tools**: Git config, Starship, LazyGit, Mise
- **Window manager**: Hyprland, Waybar, Mako
- **Utilities**: btop, custom scripts

## Repository Structure

Files are tracked in their original locations (no symlinks):
- Shell configs: `~/`
- Application configs: `~/.config/`
- Custom scripts: `~/.local/bin/`
```

### 6. Create Bootstrap Script
Create `~/bootstrap.sh`:
```bash
#!/usr/bin/env bash
set -e

echo "🚀 Setting up dotfiles..."

# Define the config alias for this script
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Backup existing configs
backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"

echo "📦 Backing up existing configs to $backup_dir"
for file in .zshrc .zshenv .zimrc .bashrc .bash_profile .profile; do
    if [ -f "$HOME/$file" ]; then
        cp "$HOME/$file" "$backup_dir/"
        echo "  ✓ Backed up $file"
    fi
done

# Checkout dotfiles
echo "📥 Checking out dotfiles..."
config checkout 2>/dev/null || {
    echo "⚠️  Conflicts detected - files backed up, forcing checkout..."
    config checkout -f
}

# Configure git to hide untracked files
config config --local status.showUntrackedFiles no

# Source the new .zshrc to get the config alias
echo "🔄 Sourcing new shell configuration..."
if [ -f "$HOME/.zshrc" ]; then
    source "$HOME/.zshrc"
fi

echo "✅ Dotfiles setup complete!"
echo ""
echo "Next steps:"
echo "  1. Install Zim framework: zimfw install"
echo "  2. Restart your shell or run: source ~/.zshrc"
echo "  3. Install missing tools (nvim, starship, etc.)"
echo ""
echo "Backup location: $backup_dir"
```

### 7. Add Files to Git
```bash
# Source the new alias
source ~/.zshrc

# Add all tracked files
config add ~/.gitignore
config add ~/.zshrc
config add ~/.zshenv
config add ~/.zimrc
config add ~/.bashrc
config add ~/.bash_profile
config add ~/.profile
config add ~/.yarnrc
config add ~/.config/nvim/
config add ~/.config/starship.toml
config add ~/.config/git/config
config add ~/.config/alacritty/
config add ~/.config/kitty/
config add ~/.config/ghostty/
config add ~/.config/lazygit/
config add ~/.config/mise/
config add ~/.config/hypr/
config add ~/.config/waybar/
config add ~/.config/mako/
config add ~/.config/btop/
config add ~/.local/bin/switch-audio-to-headphones.sh
config add ~/.local/bin/env
config add ~/README.md
config add ~/bootstrap.sh

# Make bootstrap script executable
chmod +x ~/bootstrap.sh
config add ~/bootstrap.sh  # Re-add with execute permission
```

### 8. Initial Commit
```bash
config commit -m "Initial dotfiles commit

- Shell configs: zsh, bash with Zim framework integration
- Neovim: Complete LazyVim setup
- Terminals: alacritty, kitty, ghostty
- Dev tools: git config, starship, lazygit, mise
- Window manager: Hyprland, waybar, mako
- Utilities: btop, custom scripts
- Bootstrap script for new machine setup

🤖 Generated with Claude Code
Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
```

### 9. Create GitHub Repository and Push
```bash
# Create GitHub repository (if gh CLI is installed)
gh repo create dotfiles --public --description "Personal dotfiles managed with bare git repository"

# Or create manually on GitHub, then:
config remote add origin https://github.com/AbdulrahmanMagdy/dotfiles.git
config branch -M main
config push -u origin main
```

### 10. Verify Setup
```bash
# Check status
config status

# View tracked files
config ls-tree -r main --name-only

# Test the helper functions
config-status
config-log
```

## AI-Friendly Workflow

### Daily Usage Pattern
1. **User**: "Update my Neovim config to add X plugin"
2. **AI**: Edits `~/.config/nvim/lua/plugins/X.lua`
3. **AI**: Runs `config diff` to show changes
4. **User**: Reviews diff
5. **AI**: Runs `config-commit "Add X plugin to Neovim"`
6. **Auto-pushed to GitHub** ✓

### Rollback Pattern
1. **User**: "That broke my config, rollback"
2. **AI**: Runs `config-rollback` or `config checkout HEAD~1 -- ~/.config/nvim/`
3. **User**: Config restored to previous state ✓

## Success Criteria
- ✓ `config status` shows clean working tree
- ✓ `config log` shows initial commit
- ✓ GitHub repository exists and is synced
- ✓ `config-commit "test"` works and pushes
- ✓ All helper aliases work in new shell session
- ✓ Bootstrap script can setup dotfiles on a fresh machine
- ✓ AI can use `config` commands naturally

## Maintenance Notes
- **Before AI edits**: Always commit current state
- **After AI edits**: Review with `config diff`, then `config-commit`
- **Experiments**: Use branches (`config checkout -b experiment-feature`)
- **Push frequently**: Automatic with `config-commit` function
- **Never track**: Secrets, credentials, API keys, SSH keys
