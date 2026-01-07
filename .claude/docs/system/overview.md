# Omarchy System Overview

## What is Omarchy?

Omarchy is a beautiful, keyboard-centric Arch Linux distribution built on the Hyprland Wayland tiling window manager. It follows an "omakase" philosophy—everything is pre-configured and thoughtfully curated for an optimal developer experience.

### Core Philosophy

**"A beautiful system is a motivating system"**

Omarchy demonstrates that aesthetic design and productivity work hand-in-hand, not as competing interests. Visual appeal motivates you to use your system more effectively, creating a positive feedback loop of engagement and efficiency.

## Key Characteristics

### Keyboard-Centric Workflow
Everything operates through hotkeys:
- `Super + Space` - Launch applications (Omarchy Menu)
- `Super + Alt + Space` - System controls (Omarchy Controls)
- `Super + Return` - Terminal
- Custom keybindings for all frequently used apps

The mouse becomes optional—your hands stay on the keyboard for maximum flow.

### Pre-configured Developer Stack
Ships with essential tools ready to use:
- **Editor**: Neovim with LazyVim distribution
- **Terminals**: Alacritty, Kitty, Ghostty (multiple options)
- **Git UI**: Lazygit for interactive git operations
- **Docker UI**: Lazydocker for container management
- **System Monitor**: btop for resource monitoring
- **Version Manager**: mise for managing development tool versions
- **Shell**: Zsh with Zim Framework, Starship prompt

### Visual Customization
- **14 built-in themes** style the entire desktop cohesively
- Themes affect: Hyprland, Waybar, terminals, Neovim, GTK apps
- Easy theme switching with Omarchy commands
- Theme-specific backgrounds and color schemes

### Curated, Not Bloated
Includes tools the creator actually uses:
- Productivity: Obsidian, Typora, LibreOffice
- Browsers: Chromium, Firefox, Zen Browser
- Communication: Signal, WhatsApp Web, Google Messages
- Media: Spotify, YouTube
- AI: ChatGPT, Grok
- And more...

No unnecessary bloat—just practical, daily-use applications.

## Core Components

### Window Manager: Hyprland
- Modern Wayland compositor
- Tiling window management
- Smooth animations and effects
- Highly customizable via config files
- Configuration: `~/.config/hypr/`

### Status Bar: Waybar
- Beautiful, customizable status bar
- Shows workspace info, system stats, time, etc.
- Themeable with CSS
- Configuration: `~/.config/waybar/`

### Notification Daemon: Mako
- Desktop notifications
- Theme-aware styling
- Configuration: `~/.config/mako/`

### Application Launcher: Omarchy Menu
- Fuzzy-finding application launcher
- Accessible via `Super + Space`
- Fast keyboard-driven search

### Control Center: Omarchy Controls
- System control panel (volume, brightness, network, etc.)
- Accessible via `Super + Alt + Space`

## System Features

### Security by Default
- **Full-disk encryption** mandatory during installation
- Firewall enabled out of the box
- Secure defaults for all services

### Rolling Updates
- Arch Linux base provides cutting-edge packages
- Always up-to-date software
- System updates via Omarchy commands and `yay`

### System Snapshots
- Automatic restoration points created during updates
- Easy rollback if updates cause issues
- Peace of mind when updating

### Mac Support
- Native installation available for Intel-based Macs
- Dual-boot capable
- Full feature parity with Linux installations

### Extensibility
- Full access to Arch repositories (official + AUR)
- `yay` AUR helper for easy package installation
- Customizable configs for all components

## User Information

**Your System:**
- **Username**: pokerface
- **Home Directory**: `/home/pokerface`
- **Shell**: Zsh with Zim Framework
- **Prompt**: Starship
- **Dotfiles**: Managed with bare git repository at `~/.dotfiles`
- **Dotfiles Remote**: git@github.com:amagdy46/dotfiles.git

## The Omarchy Workflow

1. **Launch apps with keyboard** - `Super + Space`, type app name, press Enter
2. **Navigate with keybindings** - Switching workspaces, moving windows, all via keyboard
3. **Customize as needed** - Edit configs in `~/.config/`, commit to dotfiles
4. **Update regularly** - `yay -Syu` or `/omarchy-update` keeps system current
5. **Theme when inspired** - Switch themes to refresh your environment

## Learning Resources

- **Official Manual**: https://learn.omacom.io/2/the-omarchy-manual
- **Omarchy Subreddit**: Community support and discussions
- **Local Documentation**: This `.claude/docs/` directory
- **Hyprland Wiki**: https://wiki.hyprland.org/ for window manager details

## Philosophy in Practice

Omarchy embodies several principles:
- **Beauty motivates** - Aesthetic design encourages engagement
- **Keyboard efficiency** - Hands on keyboard = faster workflow
- **Curated over comprehensive** - Quality over quantity in tool selection
- **Opinionated defaults** - Strong defaults that you can override
- **Developer-focused** - Built by a developer, for developers

This system is designed to get out of your way and let you focus on your work, while looking beautiful the entire time.

## Next Steps

To learn more about your Omarchy system:
- Read `architecture.md` for directory structure and file locations
- Check `../hyprland/keybindings.md` for complete keyboard shortcuts
- Explore `../dotfiles/management.md` for managing configurations
- Review `packages.md` for package management with yay
