# Hyprland Keybindings Reference

Complete reference of all Hyprland keybindings for your Omarchy system.

## Modifier Keys

- `SUPER` - Windows/Command key (primary modifier)
- `SHIFT` - Shift key
- `ALT` - Alt/Option key
- `CTRL` - Control key

## Primary Launchers

### Core Access
- `Super + Space` - Omarchy Menu (application launcher)
- `Super + Alt + Space` - Omarchy Controls (system controls)
- `Super + Return` - Terminal (default terminal emulator)

## Application Launchers

### Development
- `Super + Shift + N` - Editor (Neovim in terminal)
- `Super + Shift + T` - Activity Monitor (btop)
- `Super + Shift + D` - Docker Management (lazydocker)

### Productivity
- `Super + Shift + F` - File Manager (Nautilus)
- `Super + Shift + B` - Browser (default)
- `Super + Shift + Alt + B` - Browser (private/incognito mode)
- `Super + Shift + O` - Obsidian (note-taking)
- `Super + Shift + W` - Typora (markdown editor)
- `Super + Shift + /` - 1Password (password manager)

### Communication
- `Super + Shift + G` - Signal (messaging)
- `Super + Shift + C` - Calendar (HEY Calendar web app)
- `Super + Shift + E` - Email (HEY Email web app)
- `Super + Shift + Alt + G` - WhatsApp Web
- `Super + Shift + Ctrl + G` - Google Messages

### Media & Entertainment
- `Super + Shift + M` - Music (Spotify)
- `Super + Shift + Y` - YouTube
- `Super + Shift + P` - Google Photos
- `Super + Shift + X` - X (Twitter)
- `Super + Shift + Alt + X` - X Post composer

### AI Assistants
- `Super + Shift + A` - ChatGPT
- `Super + Shift + Alt + A` - Grok

## Window Management

Window management keybindings are provided by Omarchy defaults.

**Common Operations:**
(Located in Omarchy's default bindings - use `hyprctl binds` to see all)

### Window Focus
- Moving focus between windows
- Cycling through windows
- Focusing specific directions

### Window Movement
- Moving windows between workspaces
- Repositioning windows
- Swapping window positions

### Window Sizing
- Resizing windows
- Maximizing/minimizing
- Fullscreen toggle
- Floating toggle

### Workspaces
- Switching between workspaces
- Moving windows to workspaces
- Creating/destroying workspaces

## Media Controls

Media controls are provided by Omarchy defaults.

**Common Media Keys:**
(Check Omarchy defaults for exact bindings)

- Volume up/down/mute
- Media play/pause
- Media next/previous track
- Brightness up/down

## System Utilities

Utility keybindings from Omarchy defaults.

**Common Utilities:**
- Screenshots (area, window, full screen)
- Screen recording
- Screen sharing
- Clipboard manager
- Color picker

## Custom Keybindings

Your personal keybindings are defined in:
`~/.config/hypr/bindings.conf`

### Currently Defined

All the application launchers listed above are custom keybindings in `bindings.conf`.

### Adding New Keybindings

**Format:**
```conf
bindd = MODIFIERS, KEY, Description, exec, command
```

**Examples:**
```conf
# Launch VSCode
bindd = SUPER SHIFT, V, VSCode, exec, code

# Launch Cursor IDE
bindd = SUPER SHIFT, U, Cursor, exec, cursor

# Custom script
bindd = SUPER SHIFT, R, My Script, exec, ~/.local/bin/my-script.sh
```

**Omarchy Helper Commands:**

For web apps:
```conf
bindd = SUPER SHIFT, KEY, App Name, exec, omarchy-launch-webapp "https://url.com"
```

For installed apps (launch or focus if already open):
```conf
bindd = SUPER SHIFT, KEY, App Name, exec, omarchy-launch-or-focus ^app-regex$ "command"
```

For terminal UI apps:
```conf
bindd = SUPER SHIFT, KEY, App Name, exec, omarchy-launch-tui command
```

### Overriding Default Bindings

To override an Omarchy default binding:

```conf
# First unbind the default
unbind = SUPER, SPACE

# Then bind your custom action
bindd = SUPER, SPACE, My Custom Launcher, exec, my-launcher
```

## Keybinding Commands

### View All Active Bindings
```bash
hyprctl binds
```
Shows every keybinding currently active (defaults + custom).

### Reload Configuration
```bash
hyprctl reload
```
After editing `bindings.conf`, reload to apply changes.

### Test Keybinding
Just press the key combination - if nothing happens, check:
1. Syntax in `bindings.conf`
2. Run `hyprctl reload`
3. Check `hyprctl binds` to verify it's registered

## Editing Keybindings

### Manual Method
```bash
# Edit bindings
nvim ~/.config/hypr/bindings.conf

# Reload Hyprland
hyprctl reload

# Test the binding
```

### Using Claude Skill
```
/hypr-keybind
```
Claude will help you add keybindings correctly.

### Commit Changes
```
/dotfiles-commit
```
After adding keybindings, commit to dotfiles.

## Keybinding Organization

### By Category

**SUPER + SHIFT + Letter** - Applications
- Each letter corresponds to an app (B=Browser, M=Music, etc.)
- Easy to remember: first letter of app name when possible

**SUPER + SHIFT + ALT + Letter** - Alternative/Related Apps
- Alt variants of main apps (e.g., private browser, alt messaging)

**SUPER + SHIFT + CTRL + Letter** - Tertiary Apps
- Less common variations

**SUPER + Return** - Terminal (muscle memory from other tiling WMs)

**SUPER + Space** - Primary launcher (universal convention)

### By Function

**Launching apps** - SUPER + combinations

**Window management** - Various (from Omarchy defaults)

**System functions** - Media keys, function keys

**Workspaces** - SUPER + number keys (typically)

## Tips

💡 **Consistency** - Stick to the pattern (SUPER + SHIFT + FirstLetter)

💡 **Memorable** - Use first letter of app name when possible

💡 **Test immediately** - After adding, test before committing

💡 **Document** - Update this file when adding important bindings

💡 **Avoid conflicts** - Check `hyprctl binds` before adding new ones

💡 **Use helpers** - Omarchy's `omarchy-launch-*` commands are optimized

## Common Conflicts to Avoid

Some keys are commonly bound by Omarchy defaults:
- SUPER + 1-9 (usually workspaces)
- SUPER + Arrow keys (window focus/movement)
- SUPER + Mouse (window actions)
- Function keys (system functions)

Check with `hyprctl binds` before using these combinations.

## Web Apps vs Native Apps

**Web Apps** (opened in browser window):
```conf
bindd = KEY, App, exec, omarchy-launch-webapp "URL"
```

**Native Apps** (installed applications):
```conf
bindd = KEY, App, exec, omarchy-launch-or-focus regex "command"
```

The launcher will focus the app if it's already running, or launch it if not.

## Special Notes

### URL with # Symbol

When launching web apps with `#` in URL:
```conf
# Type ## instead of single #
bindd = SUPER SHIFT, K, App, exec, omarchy-launch-webapp "https://example.com##/path"
```

This prevents Hyprland from treating `#` as a comment.

### App Class/Regex

To find an app's class for `omarchy-launch-or-focus`:
```bash
hyprctl clients | grep -i "app-name"
```

Look for the `class` field - use it in the regex pattern.

## Quick Reference Card

**Most Used:**
```
Super + Space          → Launcher
Super + Return         → Terminal
Super + Shift + B      → Browser
Super + Shift + N      → Neovim
Super + Shift + F      → Files
Super + Shift + M      → Music
Super + Shift + E      → Email
Super + Shift + O      → Obsidian
```

**Reload:**
```
hyprctl reload         → Apply keybinding changes
```

**View All:**
```
hyprctl binds          → List all keybindings
```

---

Keep this reference handy! Print it or keep it open in Obsidian for quick lookup while you learn your keybindings.

For window management bindings not listed here, run `hyprctl binds` to see Omarchy's default window management keybindings.
