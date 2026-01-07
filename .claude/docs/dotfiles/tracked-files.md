# Tracked Configuration Files

This document lists all files currently tracked in your dotfiles repository.

## Shell Configuration

**Zsh (Primary Shell):**
- `~/.zshrc` - Interactive shell configuration (aliases, functions, key bindings)
- `~/.zshenv` - Environment variables (sourced for all shells)
- `~/.zimrc` - Zim Framework module configuration

**Bash (Fallback):**
- `~/.bashrc` - Bash interactive shell configuration
- `~/.bash_profile` - Bash login profile
- `~/.profile` - POSIX-compliant shell profile

**Purpose:**
These files configure your shell environment, including:
- Command aliases (yay helpers, git shortcuts, vim → nvim)
- Dotfiles management functions (config-commit, config-rollback)
- Shell behavior (history, keybindings, completion)
- PATH and environment variables
- Framework integration (Zim, direnv, mise)

## Hyprland (Window Manager)

**Location:** `~/.config/hypr/`

All configuration files:
- `hyprland.conf` - Main configuration file (sources all others)
- `bindings.conf` - Custom keybindings for applications
- `monitors.conf` - Monitor setup (resolution, position, scale)
- `input.conf` - Keyboard, mouse, and touchpad settings
- `looknfeel.conf` - Visual appearance (gaps, borders, animations)
- `autostart.conf` - Applications to start on login
- `hypridle.conf` - Idle behavior and timeouts
- `hyprlock.conf` - Lock screen configuration
- `hyprsunset.conf` - Night light/blue light filter
- `xdph.conf` - XDG Desktop Portal configuration
- `shaders/` - Visual effect shaders (GLSL files)

**Purpose:**
Complete window manager configuration including:
- Application launch keybindings
- Window manipulation shortcuts
- Workspace management
- Monitor layouts
- System appearance
- Startup behavior

## Waybar (Status Bar)

**Location:** `~/.config/waybar/`

- `config.jsonc` - Waybar modules, layout, and functionality
- `style.css` - Waybar styling and colors

**Purpose:**
Status bar showing:
- Workspaces
- System information (CPU, memory, network)
- Audio controls
- Time and date
- Custom modules

## Mako (Notifications)

**Location:** `~/.config/mako/`

- `config` - Notification daemon configuration

**Purpose:**
Desktop notification appearance and behavior

## Terminal Emulators

**Alacritty:**
- `~/.config/alacritty/alacritty.toml` - Main configuration
  - Font settings
  - Color scheme (imported from theme)
  - Window appearance
  - Key bindings

**Kitty:**
- `~/.config/kitty/kitty.conf` - Main configuration
  - Font and rendering
  - Colors (imported from theme)
  - Layouts and tabs
  - Key mappings

**Ghostty:**
- `~/.config/ghostty/config` - Configuration
  - Font configuration
  - Theme integration
  - Behavior settings

**Purpose:**
Multiple terminal emulator options with consistent theming

## Neovim (Text Editor)

**Location:** `~/.config/nvim/`

Complete LazyVim distribution:
- `init.lua` - Entry point that loads all configs
- `lua/config/options.lua` - Vim options and settings
- `lua/config/keymaps.lua` - Custom key mappings
- `lua/config/autocmds.lua` - Autocommands
- `lua/config/lazy.lua` - Lazy.nvim plugin manager bootstrap
- `lua/plugins/` - Plugin configurations
  - `all-themes.lua` - Additional colorscheme plugins
  - `omarchy-theme-hotreload.lua` - Live theme reloading
  - `supermaven.lua` - AI code completion
  - `theme.lua` - Theme configuration
  - `snacks-animated-scrolling-off.lua` - Disable scroll animations
  - (Add custom plugins here)
- `lazy-lock.json` - Plugin version lockfile for reproducibility

**Purpose:**
Complete text editor configuration:
- LSP integration for code intelligence
- Syntax highlighting for all languages
- Git integration
- File explorer
- Custom keybindings
- Plugin ecosystem

## Development Tools

**Git:**
- `~/.config/git/config` - Git configuration
  - User information
  - Aliases
  - Diff and merge tools
  - Default behaviors

**Starship (Prompt):**
- `~/.config/starship.toml` - Prompt configuration
  - Prompt format
  - Git status display
  - Command duration
  - Directory truncation

**Lazygit (Git TUI):**
- `~/.config/lazygit/config.yml` - LazyGit configuration
  - UI preferences
  - Key bindings
  - Git behavior

**Mise (Version Manager):**
- `~/.config/mise/config.toml` - Global tool versions
  - Currently: node 25.2.1
  - Add: python, ruby, go, etc.

**Purpose:**
Development environment tools:
- Version control
- Runtime version management
- Visual git interface
- Enhanced shell prompt

## System Utilities

**btop (System Monitor):**
- `~/.config/btop/btop.conf` - Configuration
- `~/.config/btop/themes/current.theme` - Active theme

**Purpose:**
Beautiful system resource monitoring

## Custom Scripts

**Location:** `~/.local/bin/`

User-created utility scripts and executables.
Add any custom shell scripts, Python scripts, or compiled binaries here.

**Purpose:**
Personal automation scripts accessible from anywhere (in PATH)

## Claude Code

**Location:** `~/.claude/`

All Claude Code skills and documentation:
- `README.md` - Overview of Claude directory
- `skills/` - Executable Claude skills
  - `dotfiles/` - Dotfiles management
  - `system/` - System maintenance
  - `hyprland/` - Hyprland customization
  - `dev/` - Development environment
- `docs/` - Reference documentation
  - `system/` - System overview and architecture
  - `dotfiles/` - Dotfiles workflow
  - `hyprland/` - Window manager reference
  - `development/` - Dev tools documentation
- `templates/` - Configuration templates
- `plans/` - Claude planning documents

**Purpose:**
Shared knowledge base for user and Claude

## Other Tracked Configs

**Font Configuration:**
- `~/.config/fontconfig/` - Font rendering settings

**GTK Themes:**
- `~/.config/gtk-3.0/` - GTK3 theme settings
- `~/.config/gtk-4.0/` - GTK4 theme settings

**Input Methods:**
- `~/.config/fcitx5/` - Fcitx5 input method (if used)
- `~/.config/ibus/` - IBus input method (if used)

**Browsers:**
- `~/.config/chromium/` - Chromium browser settings (selective)
- `~/.mozilla/` - Firefox settings (selective)

**Other Apps:**
- `~/.config/obsidian/` - Obsidian note-taking
- Various other app configs as added

## Tracking Status

To see all currently tracked files:
```bash
config ls-tree -r main --name-only
```

To check if a specific file is tracked:
```bash
config ls-files | grep <filename>
```

## What's NOT Tracked

For security and privacy, these are explicitly excluded in `.gitignore`:

**Sensitive:**
- `~/.ssh/` - SSH keys
- `~/.gnupg/` - GPG keys
- `~/.aws/credentials` - AWS credentials
- `~/.env` and all `.env` files
- API tokens and keys

**Temporary/Cache:**
- Node modules
- Python virtual environments
- Build artifacts
- Cache directories
- Log files
- Temporary files

**State/Data:**
- Browser history and cookies
- Application databases
- User data files
- Downloads

**System-Specific:**
- Hardware-specific configurations that won't work on other machines
- Local-only settings

## Adding New Files

When you create a new config file:

1. **Check if tracked:**
   ```bash
   config status
   ```

2. **Add the file:**
   ```bash
   config add ~/.config/newapp/config.yml
   ```
   Or use: `/dotfiles-track`

3. **Commit:**
   ```bash
   config-commit "Add newapp configuration"
   ```
   Or use: `/dotfiles-commit`

## Updating This List

When you add new tracked files, update this document:
```bash
# Edit this file
nvim ~/.claude/docs/dotfiles/tracked-files.md

# Commit the documentation update
/dotfiles-commit
```

This keeps the documentation in sync with your actual tracked files.

## File Organization

Your dotfiles follow standard XDG Base Directory conventions:
- `~/.config/` - Application configurations
- `~/.local/bin/` - User executables
- `~/.local/share/` - User data files
- `~/` - Shell configuration files (historical convention)

This organization makes configs:
- Easy to find
- Portable across machines
- Compatible with application expectations
- Clean and organized

## Benefits of Tracking These Files

✅ **Portability** - Set up new machines quickly with one git clone

✅ **Backup** - All configs backed up to GitHub automatically

✅ **History** - Track when and why you changed configs

✅ **Experimentation** - Try changes safely, rollback if needed

✅ **Consistency** - Same environment across all your machines

✅ **Documentation** - Commit messages explain your configuration journey

✅ **Sharing** - Others can learn from your setup (public repo)

---

This comprehensive tracking system ensures your entire development environment is version-controlled, backed up, and reproducible.
