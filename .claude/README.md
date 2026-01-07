# Claude Code for Omarchy

This directory contains Claude Code skills and documentation for your Omarchy Arch Linux system. It creates a shared knowledge base that enables both you and Claude to work efficiently with your system.

## What's Inside

### Skills (`skills/`)
Executable Claude skills that automate common tasks. Invoke with `/skill-name`.

**Dotfiles Management** (`skills/dotfiles/`)
- `/dotfiles-commit` - Commit dotfile changes with AI-generated message
- `/dotfiles-status` - Quick overview of dotfiles repository state
- `/dotfiles-track` - Add new configuration files to tracking
- `/dotfiles-rollback` - Safely rollback dotfile changes

**System Maintenance** (`skills/system/`)
- `/omarchy-update` - Update system packages and Omarchy components
- `/packages` - Search, install, or query packages with yay
- `/cleanup` - Clean up orphan packages and cache

**Hyprland Customization** (`skills/hyprland/`)
- `/hypr-keybind` - Add or modify Hyprland keybindings
- `/hypr-theme` - Change Omarchy theme
- `/hypr-reload` - Reload Hyprland configuration

**Development Environment** (`skills/dev/`)
- `/mise-install` - Install development tools with mise
- `/nvim-config` - Modify Neovim/LazyVim configuration
- `/terminal-setup` - Configure terminal emulators

### Documentation (`docs/`)
Reference documentation that Claude reads to understand your system.

**System** (`docs/system/`)
- `overview.md` - Omarchy system overview and philosophy
- `architecture.md` - Directory structure and file locations
- `packages.md` - Package management with yay
- `troubleshooting.md` - Common issues and solutions

**Dotfiles** (`docs/dotfiles/`)
- `management.md` - Dotfiles workflow and best practices
- `tracked-files.md` - List of tracked configuration files
- `backup-restore.md` - Backup and restore procedures

**Hyprland** (`docs/hyprland/`)
- `keybindings.md` - Complete keybindings reference
- `configuration.md` - Hyprland config structure
- `themes.md` - Available themes and customization
- `waybar.md` - Waybar configuration guide

**Development** (`docs/development/`)
- `neovim.md` - Neovim/LazyVim setup and customization
- `terminals.md` - Terminal emulator configurations
- `mise.md` - Mise version manager guide
- `shell.md` - Zsh, Zim, and Starship setup
- `tools.md` - Development tools reference

### Templates (`templates/`)
Configuration templates for quick customization.

- `hypr-keybind-template.conf` - Template for Hyprland keybindings
- `waybar-module-template.jsonc` - Template for Waybar modules

## How to Use

### Using Skills
Skills automate common tasks. Simply invoke them by name:
```bash
# Commit dotfile changes
/dotfiles-commit

# Update system packages
/omarchy-update

# Add a new keybinding
/hypr-keybind
```

Claude will execute the skill, performing all necessary actions and showing you the results.

### Reading Documentation
Documentation provides reference information that both you and Claude can consult:
- Quick lookup for keybindings, commands, and configurations
- Understanding system architecture and workflows
- Troubleshooting common issues
- Learning about available tools and features

### When to Use What
- **Need to DO something?** → Use a skill
- **Need to LEARN something?** → Read the docs
- **Need a template?** → Check `templates/`

## Philosophy

This system follows the Omarchy principle: **"A beautiful system is a motivating system."**

By documenting your system comprehensively and creating helpful automation, we:
1. **Reduce friction** - Common tasks become one command
2. **Preserve knowledge** - No need to remember obscure commands
3. **Enable consistency** - Same approach across machines via dotfiles
4. **Empower collaboration** - Claude understands your system as well as you do

## Maintenance

This directory is tracked in your dotfiles repository at `~/.dotfiles`, meaning:
- All skills and docs are version-controlled
- Changes sync across machines
- You can rollback if needed
- Skills and docs evolve with your system

### Updating Documentation
When you make significant system changes:
- New package installed → update `docs/system/packages.md` or `docs/development/tools.md`
- New keybinding added → update `docs/hyprland/keybindings.md`
- New theme → update `docs/hyprland/themes.md`
- Config change → update relevant documentation

Use `/dotfiles-commit` to commit both config changes and documentation updates together.

## Quick Reference

**Dotfiles Commands:**
```bash
config status          # See what's changed
config diff           # Show changes
config-commit "msg"   # Commit and push
config-rollback [N]   # Rollback N commits
```

**Package Management:**
```bash
yayi        # Update all packages
yays <pkg>  # Search for package
yayI <pkg>  # Install package
yayor       # Remove orphans
yayc        # Clean cache
```

**Hyprland:**
```bash
hyprctl reload       # Reload configuration
hyprctl monitors     # List monitors
hyprctl binds        # List keybindings
```

**Development:**
```bash
mise list            # Show installed tools
mise install <tool>  # Install tool
vim                  # Opens Neovim (aliased)
```

## Getting Help

- Browse documentation in `docs/` for reference information
- Use skills in `skills/` to automate tasks
- Check `~/.claude/plans/` for implementation plans from Claude
- Refer to main dotfiles README at `~/README.md`

---

**Built for Omarchy** - Beautiful, keyboard-centric, developer-focused Arch Linux
