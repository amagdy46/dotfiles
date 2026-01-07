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
- **Claude Code**: Skills and documentation (~/.claude/)

## Repository Structure

Files are tracked in their original locations (no symlinks):
- Shell configs: `~/`
- Application configs: `~/.config/`
- Custom scripts: `~/.local/bin/`
