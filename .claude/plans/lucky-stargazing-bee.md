# Omarchy Claude Skills & Documentation Implementation Plan

## Overview
Create comprehensive Claude Code skills and documentation for your Omarchy Arch Linux system, enabling both you and Claude to have shared knowledge and efficient workflows for daily tasks.

## Target Location
`~/.claude/` directory (to be tracked in dotfiles repo)

## Directory Structure

```
~/.claude/
├── README.md                        # Overview of Claude directory
├── skills/                          # Executable Claude skills
│   ├── dotfiles/
│   │   ├── commit.md               # AI-assisted dotfiles commit
│   │   ├── status.md               # Quick status overview
│   │   ├── track.md                # Add new files to tracking
│   │   └── rollback.md             # Safe rollback
│   ├── system/
│   │   ├── update.md               # System & package updates
│   │   ├── packages.md             # Package management
│   │   └── cleanup.md              # Clean orphans & cache
│   ├── hyprland/
│   │   ├── keybind.md              # Add/modify keybindings
│   │   ├── theme.md                # Switch themes
│   │   └── reload.md               # Reload configuration
│   └── dev/
│       ├── mise-install.md         # Install dev tools with mise
│       ├── nvim-config.md          # Modify Neovim config
│       └── terminal-setup.md       # Configure terminals
│
├── docs/                            # Reference documentation
│   ├── system/
│   │   ├── overview.md             # Omarchy system overview
│   │   ├── architecture.md         # Directory structure & file locations
│   │   ├── packages.md             # Package management reference
│   │   └── troubleshooting.md      # Common issues & solutions
│   ├── dotfiles/
│   │   ├── management.md           # Dotfiles workflow guide
│   │   ├── tracked-files.md        # List of tracked configs
│   │   └── backup-restore.md       # Backup & restore procedures
│   ├── hyprland/
│   │   ├── keybindings.md          # Complete keybindings reference
│   │   ├── configuration.md        # Hyprland config structure
│   │   ├── themes.md               # Available themes & customization
│   │   └── waybar.md               # Waybar configuration
│   └── development/
│       ├── neovim.md               # Neovim/LazyVim setup
│       ├── terminals.md            # Terminal configurations
│       ├── mise.md                 # Mise version manager guide
│       ├── shell.md                # Zsh, Zim, Starship setup
│       └── tools.md                # Dev tools (lazygit, lazydocker, etc.)
│
└── templates/                       # Configuration templates
    ├── hypr-keybind-template.conf
    └── waybar-module-template.jsonc
```

## Implementation Steps

### Phase 1: Foundation & Core Documentation (Start Here)

**1. Create directory structure**
```bash
mkdir -p ~/.claude/{skills/{dotfiles,system,hyprland,dev},docs/{system,dotfiles,hyprland,development},templates}
```

**2. Create master README**
- File: `~/.claude/README.md`
- Content: Overview of Claude directory, how to use skills vs docs, what each section contains

**3. Core system documentation**

**File: `~/.claude/docs/system/overview.md`**
- What is Omarchy (philosophy, keyboard-centric workflow)
- Core components (Hyprland, Waybar, Mako, Neovim)
- User info (pokerface, zsh + zim, starship)
- Key characteristics (rolling release, themes, developer tools)

**File: `~/.claude/docs/system/architecture.md`**
- Omarchy system files: `~/.local/share/omarchy/`
- Configuration directories (hypr, waybar, nvim, terminals)
- Theme system: symlink at `~/.config/omarchy/current`
- Config inheritance pattern (defaults → theme → user overrides)

**File: `~/.claude/docs/dotfiles/management.md`**
- Bare git repository explanation
- Core commands: `config`, `config-status`, `config-diff`, `config-commit`, `config-rollback`
- Workflow: edit → review → commit → push
- Best practices (review before commit, descriptive messages, no secrets)
- New machine setup instructions

### Phase 2: Dotfiles Skills & Documentation

**4. Dotfiles skills**

**File: `~/.claude/skills/dotfiles/commit.md`**
```markdown
Skill: /dotfiles-commit

Purpose: Commit dotfile changes with AI-generated message

Actions:
1. Run `config status` to check changes
2. Run `config diff` to analyze modifications
3. Generate meaningful commit message based on changes
4. Stage: `config add -u`
5. Commit: `config commit -m "message"`
6. Push: `config push origin main`
7. Show confirmation
```

**File: `~/.claude/skills/dotfiles/status.md`**
- Show `config status` output
- Display recent commits with `config log --oneline --decorate --graph --all -5`
- Check ahead/behind remote
- List uncommitted changes

**File: `~/.claude/skills/dotfiles/track.md`**
- Accept file path argument
- Run `config add <file>`
- Show what will be tracked
- Optionally commit immediately

**File: `~/.claude/skills/dotfiles/rollback.md`**
- Show recent commits
- Accept number of commits to rollback (default: 1)
- Run `config-rollback N`
- Verify success and show current state

**5. Tracked files documentation**

**File: `~/.claude/docs/dotfiles/tracked-files.md`**
- Shell configs: .zshrc, .zshenv, .zimrc, .bashrc, .bash_profile, .profile
- Hyprland: all conf files in `~/.config/hypr/`
- Waybar: config.jsonc, style.css
- Terminals: Alacritty, Kitty, Ghostty
- Neovim: Complete `~/.config/nvim/` directory
- Dev tools: git, starship, lazygit, mise configs
- Utilities: btop, custom scripts in `~/.local/bin/`

### Phase 3: System Maintenance Skills & Docs

**6. System maintenance skills**

**File: `~/.claude/skills/system/update.md`**
- Check for Omarchy updates
- Run `yay -Syu` for package updates
- Show summary of what will be updated
- Execute updates with confirmation
- Clean package cache if needed

**File: `~/.claude/skills/system/packages.md`**
- Search: `yay -Ss <query>`
- Install: `yay -S <package>`
- Query info: `yay -Qi <package>`
- List AUR packages: `yay -Qm`
- Show package files: `yay -Ql <package>`

**File: `~/.claude/skills/system/cleanup.md`**
- List orphan packages: `yay -Qdt`
- Remove orphans: `yay -Rns $(yay -Qtdq)` with confirmation
- Clean cache: `yay -Sc`
- Show disk space saved

**7. Package management documentation**

**File: `~/.claude/docs/system/packages.md`**
- yay aliases from .zshrc (yayi, yays, yayI, yayr, yayrm, etc.)
- Common tasks with examples
- AUR package management
- Cache cleaning
- Orphan package removal

**File: `~/.claude/docs/system/troubleshooting.md`**
- Dotfiles issues (changes not appearing, rollback needed)
- Hyprland issues (keybindings not working, monitor config, theme not applying)
- System maintenance (boot issues after update, package conflicts)
- Development environment (Neovim LSP not working, terminal not applying theme)

### Phase 4: Hyprland Customization

**8. Hyprland skills**

**File: `~/.claude/skills/hyprland/keybind.md`**
- Read `~/.config/hypr/bindings.conf`
- Show existing bindings for context
- Add new binding in format: `bindd = MODIFIERS, KEY, Description, exec, command`
- Validate syntax
- Reload: `hyprctl reload`
- Optionally commit to dotfiles

**File: `~/.claude/skills/hyprland/theme.md`**
- List available themes
- Show current theme
- Run theme change command
- Preview changes
- Optionally commit

**File: `~/.claude/skills/hyprland/reload.md`**
- Run `hyprctl reload`
- Show any configuration errors
- Verify success

**9. Hyprland documentation**

**File: `~/.claude/docs/hyprland/keybindings.md`**
- All custom keybindings from `~/.config/hypr/bindings.conf`
- Format: organized by category (Applications, Development, Productivity, Media, etc.)
- Include modifier key reference (SUPER, SHIFT, ALT, CTRL)
- Customization instructions (edit bindings.conf, reload)

**File: `~/.claude/docs/hyprland/configuration.md`**
- Hyprland config structure
- Files in `~/.config/hypr/`: hyprland.conf, bindings.conf, monitors.conf, input.conf, looknfeel.conf, autostart.conf
- How configs are sourced
- Override patterns

**File: `~/.claude/docs/hyprland/themes.md`**
- List of 14 built-in themes
- Theme management commands
- Theme structure and locations
- Application integration (how terminals/neovim/waybar use themes)
- Customization options

**File: `~/.claude/docs/hyprland/waybar.md`**
- Waybar configuration files: config.jsonc, style.css
- Module configuration
- Styling customization
- Reload procedure

### Phase 5: Development Environment

**10. Development skills**

**File: `~/.claude/skills/dev/mise-install.md`**
- Install tool: `mise install <tool>@<version>`
- List available versions: `mise ls-remote <tool>`
- Show current tools: `mise list`
- Update `~/.config/mise/config.toml`
- Commit mise config

**File: `~/.claude/skills/dev/nvim-config.md`**
- Navigate to `~/.config/nvim/lua/`
- Edit config files (options.lua, keymaps.lua)
- Add plugins to `~/.config/nvim/lua/plugins/`
- Validate Lua syntax
- Commit changes

**File: `~/.claude/skills/dev/terminal-setup.md`**
- Edit terminal configs (alacritty.toml, kitty.conf, ghostty config)
- Modify fonts, colors, keybindings
- Test configuration
- Commit to dotfiles

**11. Development documentation**

**File: `~/.claude/docs/development/neovim.md`**
- LazyVim distribution
- Configuration structure (`~/.config/nvim/lua/`)
- Current customizations (plugins, options)
- Adding plugins (create file in `lua/plugins/`)
- LSP management with Mason
- Common tasks (update plugins, add language support)

**File: `~/.claude/docs/development/mise.md`**
- What is mise (version manager)
- Configuration: global (`~/.config/mise/config.toml`), project (`.mise.toml`)
- Current tools (node 25.2.1)
- Common commands (install, list, use)
- Project workflow (mise use in project directory)

**File: `~/.claude/docs/development/terminals.md`**
- Alacritty: `~/.config/alacritty/alacritty.toml`
- Kitty: `~/.config/kitty/kitty.conf`
- Ghostty: `~/.config/ghostty/config`
- Theme integration (import from current theme)
- Configuration options

**File: `~/.claude/docs/development/shell.md`**
- Zsh with Zim Framework
- Modules: syntax-highlighting, autosuggestions, vi-mode
- Starship prompt: `~/.config/starship.toml`
- direnv integration
- Custom aliases and functions

**File: `~/.claude/docs/development/tools.md`**
- Lazygit: `~/.config/lazygit/config.yml`
- Lazydocker configuration
- btop: `~/.config/btop/btop.conf`
- Git: `~/.config/git/config`
- Other dev tools

### Phase 6: Templates & Finalization

**12. Create templates**

**File: `~/.claude/templates/hypr-keybind-template.conf`**
```conf
# Template for Hyprland keybindings
# Format: bindd = MODIFIERS, KEY, Description, exec, command

bindd = SUPER SHIFT, KEY, App Name, exec, command-here
```

**File: `~/.claude/templates/waybar-module-template.jsonc`**
```jsonc
// Waybar custom module template
"custom/module-name": {
    "format": "{}",
    "exec": "command",
    "interval": 5
}
```

**13. Track in dotfiles**

```bash
# Add entire .claude directory to dotfiles tracking
config add ~/.claude/

# Commit with descriptive message
config commit -m "Add Claude Code skills and documentation for Omarchy system

- 12 Claude skills for automating common tasks
- Comprehensive documentation across 4 areas (system, dotfiles, hyprland, development)
- Templates for configuration files
- Enables shared knowledge between user and Claude"

# Push to remote
config push origin main
```

**14. Update main dotfiles README**

Edit `~/README.md` to add:
```markdown
- **Claude Code**: Skills and documentation (~/.claude/)
```

## Critical Files (Priority Order)

1. `~/.claude/README.md` - Master overview
2. `~/.claude/docs/system/overview.md` - Core system knowledge
3. `~/.claude/skills/dotfiles/commit.md` - Most-used skill
4. `~/.claude/docs/dotfiles/management.md` - Dotfiles workflow reference
5. `~/.claude/docs/hyprland/keybindings.md` - Daily reference

## Content Strategy

**Static (document once, update occasionally):**
- System overview, philosophy, architecture
- Keybindings reference
- Theme list
- Workflow guides
- Troubleshooting procedures

**Dynamic (query at runtime):**
- Package counts: `yay -Q | wc -l`
- Installed packages: `yay -Q`
- Dotfiles status: `config status`
- Current theme: Check symlink or Omarchy command
- Active bindings: `hyprctl binds`
- Mise tool versions: `mise list`

**Approach:**
- Skills execute dynamic queries when invoked
- Documentation provides commands and examples
- Update docs when significant system changes occur

## Maintenance

**When to update:**
- New package/tool installed → update docs/system/packages.md or docs/development/tools.md
- New theme added → update docs/hyprland/themes.md
- Keybinding added → update docs/hyprland/keybindings.md
- Major config change → update relevant documentation

**Version control:**
- Commit docs/skills with related config changes
- Use descriptive commit messages
- Tag major milestones

**Testing:**
- Test each skill after creation
- Verify skills work from fresh Claude session
- Ensure error handling is graceful

## Benefits

1. **Shared Knowledge** - Both you and Claude understand your Omarchy system equally
2. **Automation** - Skills automate common tasks (commits, updates, customization)
3. **Consistency** - Portable across machines via dotfiles repo
4. **Efficiency** - Quick reference docs eliminate searching
5. **Safety** - Skills incorporate best practices (backups, confirmations)
6. **Extensibility** - Easy to add new skills/docs as needs evolve
