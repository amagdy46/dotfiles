# Dotfiles Commit Skill

## Purpose
Commit dotfile changes with an AI-generated commit message that accurately describes what was modified.

## How It Works

This skill automates the dotfiles commit process:
1. Checks current repository state
2. Shows what changed
3. Analyzes the changes to generate a meaningful commit message
4. Stages tracked files
5. Commits with descriptive message
6. Pushes to GitHub
7. Confirms success

## When to Use

Use this skill whenever you've made changes to your tracked configuration files:
- Modified shell configs (`.zshrc`, `.zshenv`, etc.)
- Updated Hyprland or Waybar settings
- Changed Neovim configuration
- Modified terminal emulator configs
- Updated any other tracked dotfiles

## Usage

Simply invoke the skill:
```
/dotfiles-commit
```

Claude will:
- Run `config status` to see changed files
- Run `config diff` to analyze the specific changes
- Generate a descriptive commit message based on what changed
- Execute the commit and push

## What Claude Does

1. **Check Status**
```bash
config status
```
Identifies which files have been modified.

2. **View Changes**
```bash
config diff
```
Examines the actual line-by-line changes to understand what was modified.

3. **Generate Commit Message**
Claude analyzes the diff output and creates a commit message that:
- Describes **what** was changed (files/components)
- Explains **why** or **what it does** (the purpose)
- Follows commit message best practices

Example messages:
- "Add VSCode keybinding to Hyprland (Super+Shift+V)"
- "Update Alacritty font to JetBrainsMono Nerd Font size 12"
- "Configure mise to use Node 20 LTS for development"
- "Refactor zshrc aliases for better package management"

4. **Stage Changes**
```bash
config add -u
```
Stages all tracked files that have been modified (doesn't add new untracked files).

5. **Commit**
```bash
config commit -m "Generated commit message"
```

6. **Push to GitHub**
```bash
config push origin main
```

7. **Confirm Success**
Shows you the commit was created and pushed successfully.

## Examples

### Example 1: Keybinding Addition

**You changed:**
- Added new keybinding to `~/.config/hypr/bindings.conf`

**Claude generates:**
```
"Add Obsidian keybinding (Super+Shift+O) to Hyprland"
```

### Example 2: Multiple Related Changes

**You changed:**
- Updated font in `~/.config/alacritty/alacritty.toml`
- Updated font in `~/.config/kitty/kitty.conf`

**Claude generates:**
```
"Update terminal fonts to FiraCode Nerd Font across Alacritty and Kitty"
```

### Example 3: Configuration Tweak

**You changed:**
- Modified `~/.zshrc` to add new aliases

**Claude generates:**
```
"Add Docker convenience aliases to zshrc (dps, dimg, dlogs)"
```

## Benefits

✅ **Saves time** - No need to write commit messages manually

✅ **Consistency** - Commit messages follow a consistent style

✅ **Accuracy** - Claude reads the actual diff to understand changes

✅ **Automation** - Stages, commits, and pushes in one command

✅ **Best practices** - Commit messages are descriptive and meaningful

## Safety Features

- **Only stages tracked files** (`-u` flag) - Won't accidentally commit untracked files
- **Shows what's being committed** - You see the status and diff before commit
- **Preserves history** - Can always rollback with `/dotfiles-rollback`

## Comparison with Manual Method

**Manual:**
```bash
config add -u
config commit -m "update stuff"  # Vague message
config push origin main
```

**With Skill:**
```bash
/dotfiles-commit
# Claude analyzes changes and creates:
# "Configure Hyprland to use 2x scale on external 4K monitor"
```

The skill produces better commit messages with less effort.

## Tips

- **Review changes first**: Run `config diff` yourself before using the skill if you want to review
- **Commit frequently**: Make small, focused commits rather than large batches
- **Trust Claude's analysis**: The generated messages are based on actual code changes
- **Edit if needed**: If you want a different message, you can still commit manually

## Related

- `/dotfiles-status` - View repository state without committing
- `/dotfiles-track` - Add new files to tracking
- `/dotfiles-rollback` - Undo commits
- See `~/.claude/docs/dotfiles/management.md` for detailed dotfiles workflow

## Technical Details

**Uses:**
- `config` alias (defined in `.zshrc`)
- Git commands via the bare repository at `~/.dotfiles/`

**Equivalent to:**
```bash
config status
config diff
config add -u
config commit -m "AI-generated message based on diff analysis"
config push origin main
echo "✓ Committed and pushed: [message]"
```

**Repository:**
- Remote: git@github.com:amagdy46/dotfiles.git
- Branch: main
- Method: Bare git repository tracking files in place
