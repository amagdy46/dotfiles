# System Architecture

## Directory Structure

### Omarchy System Files

**Location**: `~/.local/share/omarchy/`

This is the core Omarchy installation directory containing system components:

```
~/.local/share/omarchy/
├── bin/              # Omarchy utility commands (omarchy-*, omakase-*)
├── boot.sh           # Boot initialization script
├── config/           # System configuration
├── default/          # Default Omarchy configurations
├── install/          # Installation scripts
├── migrations/       # System migration scripts
├── themes/           # All available themes (14 themes)
├── applications/     # Application definitions
└── autostart/        # Autostart application configs
```

**Key Subdirectories:**
- `bin/` - Contains all Omarchy commands like `omarchy-update`, `omarchy-theme-set`, etc.
- `default/` - Default configs that Omarchy provides (Hyprland, Waybar, etc.)
- `themes/` - All 14 built-in themes with their complete configurations

### User Omarchy Configuration

**Location**: `~/.config/omarchy/`

This directory manages your active Omarchy configuration:

```
~/.config/omarchy/
├── current/          # Symlink to active theme in ~/.local/share/omarchy/themes/<theme-name>/
├── branding/         # Omarchy branding assets
├── hooks/            # Custom hook scripts
└── themes/           # User theme customizations
```

**Important**: `~/.config/omarchy/current/` is a symlink pointing to the currently active theme. Applications import theme configs from this location.

### User Configuration Directories

**Base**: `~/.config/`

All application configurations live here:

**Window Manager:**
```
~/.config/hypr/
├── hyprland.conf       # Main config (sources other files)
├── bindings.conf       # Custom keybindings
├── monitors.conf       # Monitor configuration
├── input.conf          # Input device settings (keyboard, mouse, touchpad)
├── looknfeel.conf      # Appearance settings
├── autostart.conf      # Startup applications
├── hypridle.conf       # Idle behavior configuration
├── hyprlock.conf       # Lock screen configuration
├── hyprsunset.conf     # Night light/sunset configuration
├── xdph.conf           # XDG Desktop Portal for Hyprland
└── shaders/            # Visual effect shaders (GLSL files)
```

**Status Bar:**
```
~/.config/waybar/
├── config.jsonc        # Waybar modules and layout
└── style.css           # Waybar styling
```

**Notifications:**
```
~/.config/mako/
└── config              # Mako notification daemon config
```

**Terminals:**
```
~/.config/alacritty/
└── alacritty.toml      # Alacritty terminal emulator

~/.config/kitty/
└── kitty.conf          # Kitty terminal emulator

~/.config/ghostty/
└── config              # Ghostty terminal emulator
```

**Text Editor:**
```
~/.config/nvim/
├── init.lua            # Entry point
├── lua/
│   ├── config/         # LazyVim configuration
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   ├── autocmds.lua
│   │   └── lazy.lua
│   └── plugins/        # Plugin configurations
└── lazy-lock.json      # Plugin version lock
```

**Development Tools:**
```
~/.config/git/
└── config              # Git configuration

~/.config/starship.toml # Starship prompt configuration

~/.config/lazygit/
└── config.yml          # LazyGit TUI configuration

~/.config/mise/
└── config.toml         # Mise version manager configuration

~/.config/btop/
├── btop.conf           # System monitor configuration
└── themes/
    └── current.theme   # Current btop theme
```

### Shell Configuration

**Location**: `~/` (home directory root)

Shell configuration files:
```
~/
├── .zshrc              # Zsh interactive shell config (aliases, functions)
├── .zshenv             # Environment variables (sourced always)
├── .zimrc              # Zim Framework module configuration
├── .bashrc             # Bash configuration
├── .bash_profile       # Bash login profile
└── .profile            # Generic POSIX shell profile
```

### Dotfiles Repository

**Location**: `~/.dotfiles/` (bare git repository)

This is a bare git repository that tracks your configuration files in their original locations:
```
~/.dotfiles/            # Bare repository (no working tree)
├── HEAD
├── config              # Git configuration for bare repo
├── description
├── hooks/
├── info/
├── objects/
└── refs/
```

**Remote**: git@github.com:amagdy46/dotfiles.git

Files are tracked in place (no symlinks), managed via the `config` alias:
```bash
config status    # Check dotfiles status
config diff      # See changes
config add       # Stage files
config commit    # Commit changes
config push      # Push to GitHub
```

### Custom Scripts

**Location**: `~/.local/bin/`

User-created utility scripts and executables. This directory is in your PATH.

### Claude Code

**Location**: `~/.claude/`

Claude Code skills and documentation (this directory):
```
~/.claude/
├── README.md
├── skills/             # Executable Claude skills
│   ├── dotfiles/
│   ├── system/
│   ├── hyprland/
│   └── dev/
├── docs/              # Reference documentation
│   ├── system/
│   ├── dotfiles/
│   ├── hyprland/
│   └── development/
├── templates/         # Configuration templates
└── plans/             # Claude Code planning documents
```

## Configuration Inheritance Pattern

Omarchy uses a layered configuration approach for Hyprland and other components:

### Layer 1: Omarchy Defaults
**Location**: `~/.local/share/omarchy/default/`

Default configurations provided by Omarchy. These are the foundation.

### Layer 2: Theme Configurations
**Location**: `~/.config/omarchy/current/theme/`

The active theme provides colors, styling, and visual configurations. This is a symlink to:
`~/.local/share/omarchy/themes/<theme-name>/theme/`

### Layer 3: User Overrides
**Location**: `~/.config/<app>/`

Your personal configurations override defaults and theme settings.

### Example: Hyprland Config Loading

`~/.config/hypr/hyprland.conf` sources files in this order:
1. Omarchy default Hyprland config
2. Active theme Hyprland settings (colors, styling)
3. User configs (`bindings.conf`, `monitors.conf`, `input.conf`, etc.)

User settings take precedence, allowing customization without breaking Omarchy updates.

## Theme System

### Theme Storage
All themes located at: `~/.local/share/omarchy/themes/`

Available themes (14 total):
- catppuccin (multiple variants)
- ethereal
- everforest
- flexoki-light
- gruvbox
- hackerman
- kanagawa
- matte-black
- nord
- osaka-jade
- ristretto
- rose-pine
- tokyo-night

### Active Theme
The active theme is symlinked at: `~/.config/omarchy/current/`

This symlink points to: `~/.local/share/omarchy/themes/<current-theme-name>/`

### Theme Structure
Each theme directory contains:
```
~/.local/share/omarchy/themes/<theme-name>/
├── theme/
│   ├── hyprland.conf    # Hyprland colors
│   ├── waybar.css       # Waybar styling
│   ├── alacritty.toml   # Alacritty colors
│   ├── kitty.conf       # Kitty colors
│   ├── mako.conf        # Notification styling
│   └── ...
├── backgrounds/         # Theme wallpapers
└── metadata.yml         # Theme information
```

### Application Theme Integration

Applications import the active theme:

**Alacritty** (`~/.config/alacritty/alacritty.toml`):
```toml
general.import = [ "~/.config/omarchy/current/theme/alacritty.toml" ]
```

**Kitty** (`~/.config/kitty/kitty.conf`):
```conf
include ~/.config/omarchy/current/theme/kitty.conf
```

**Waybar** (`~/.config/waybar/config.jsonc`):
Automatically uses `~/.config/waybar/style.css` which imports theme styles.

**Neovim**: LazyVim plugin automatically applies the theme's colorscheme.

## File Locations Quick Reference

| Component | Configuration Location |
|-----------|----------------------|
| Hyprland | `~/.config/hypr/*.conf` |
| Waybar | `~/.config/waybar/` |
| Neovim | `~/.config/nvim/` |
| Terminals | `~/.config/{alacritty,kitty,ghostty}/` |
| Shell (Zsh) | `~/.zshrc`, `~/.zshenv`, `~/.zimrc` |
| Starship | `~/.config/starship.toml` |
| Git | `~/.config/git/config` |
| Mise | `~/.config/mise/config.toml` |
| Lazygit | `~/.config/lazygit/config.yml` |
| btop | `~/.config/btop/btop.conf` |
| Mako | `~/.config/mako/config` |
| Dotfiles | `~/.dotfiles/` (bare repo) |
| Omarchy System | `~/.local/share/omarchy/` |
| Active Theme | `~/.config/omarchy/current/` (symlink) |
| Custom Scripts | `~/.local/bin/` |
| Claude Code | `~/.claude/` |

## Important Paths

```bash
# Omarchy commands location
~/.local/share/omarchy/bin/omarchy-*

# Active theme (symlink)
~/.config/omarchy/current/

# All available themes
~/.local/share/omarchy/themes/

# Dotfiles bare repository
~/.dotfiles/

# User configs (most frequently edited)
~/.config/hypr/bindings.conf     # Keybindings
~/.config/hypr/monitors.conf     # Monitors
~/.config/nvim/                  # Neovim
~/.zshrc                         # Shell config
```

## Configuration Workflow

1. **Edit configs** in their normal locations (`~/.config/...`, `~/.zshrc`, etc.)
2. **Test changes** (e.g., `hyprctl reload` for Hyprland)
3. **Review changes** with `config diff`
4. **Commit to dotfiles** with `config-commit "description"`
5. **Push to GitHub** (automatic with `config-commit`)

This architecture enables:
- **Portability** - Dotfiles work on any machine
- **Theme flexibility** - Easy theme switching without breaking customizations
- **Update safety** - User configs override defaults
- **Version control** - All configs tracked in git
