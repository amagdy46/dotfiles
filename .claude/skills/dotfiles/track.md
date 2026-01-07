# Dotfiles Track Skill

## Purpose
Add new configuration files to your dotfiles repository tracking.

## How It Works

This skill helps you start tracking a new config file:
1. Accepts a file path (or asks for one)
2. Validates the file exists
3. Checks if it's already tracked
4. Adds the file to dotfiles repository
5. Shows what will be tracked
6. Optionally commits immediately

## When to Use

Use this skill when you:
- Created a new configuration file
- Installed a new application and want to track its config
- Have an untracked file that `config status` shows
- Want to add a file to your dotfiles backup

## Usage

### Interactive (Recommended)
```
/dotfiles-track
```
Claude will ask you which file to track.

### With File Path
```
/dotfiles-track ~/.config/newapp/config.yml
```

## What Claude Does

### 1. Validate File

Checks if the file exists:
```bash
ls -la <file-path>
```

If the file doesn't exist, Claude will tell you and stop.

### 2. Check Current Tracking Status

```bash
config ls-files | grep <filename>
```

If already tracked, Claude informs you and exits.

### 3. Add to Repository

```bash
config add <file-path>
```

The file is now staged for commit in your dotfiles repository.

### 4. Show What Was Added

```bash
config status
```

Shows the newly added file in "Changes to be committed" section.

### 5. Optionally Commit

Claude can immediately commit the new file:
```bash
config commit -m "Add <app-name> configuration"
config push origin main
```

Or you can commit later with `/dotfiles-commit`.

## Example Scenarios

### Example 1: New Application Config

**You:**
```
/dotfiles-track
```

**Claude:**
"Which file would you like to track in your dotfiles?"

**You:**
```
~/.config/bruno/bruno.json
```

**Claude:**
```bash
# Validates file exists
ls -la ~/.config/bruno/bruno.json

# Checks if already tracked
config ls-files | grep bruno.json

# Not tracked, adding now
config add ~/.config/bruno/bruno.json

# Shows status
config status
# Output:
# Changes to be committed:
#   new file:   .config/bruno/bruno.json
```

"Added ~/.config/bruno/bruno.json to tracking. Would you like to commit now or later?"

**You:** "Commit now"

**Claude:**
```bash
config commit -m "Add Bruno API client configuration"
config push origin main
```

"✓ Committed and pushed Bruno configuration to dotfiles."

### Example 2: Multiple Files

**You:**
```
/dotfiles-track ~/.config/cursor/settings.json
```

**Claude:**
```bash
config add ~/.config/cursor/settings.json
config status
```

"Added Cursor settings. You can continue adding more files or use /dotfiles-commit when ready."

**You:**
```
/dotfiles-track ~/.config/cursor/keybindings.json
```

**Both files now staged, commit together:**
```
/dotfiles-commit
```

**Claude generates:**
```
"Add Cursor IDE configuration (settings and keybindings)"
```

### Example 3: Already Tracked

**You:**
```
/dotfiles-track ~/.zshrc
```

**Claude:**
```bash
config ls-files | grep .zshrc
# Output: .zshrc
```

"~/.zshrc is already tracked in your dotfiles repository. No action needed."

### Example 4: File Doesn't Exist

**You:**
```
/dotfiles-track ~/.config/nonexistent/config.yml
```

**Claude:**
```bash
ls -la ~/.config/nonexistent/config.yml
# Error: cannot access: No such file or directory
```

"File ~/.config/nonexistent/config.yml doesn't exist. Please check the path and try again."

## Benefits

✅ **Validation** - Checks file exists before attempting to add

✅ **Duplicate prevention** - Won't re-add already tracked files

✅ **Interactive** - Can ask for file path if not provided

✅ **Flexible** - Commit immediately or stage for later

✅ **Safe** - Only adds what you explicitly request

## Workflow Options

### Option 1: Track and Commit Immediately

```
/dotfiles-track ~/.config/newapp/config.yml
# Claude asks: "Commit now?"
# You: "Yes"
# Result: File tracked and committed in one go
```

### Option 2: Track Multiple, Then Commit

```
/dotfiles-track ~/.config/app1/config.yml
/dotfiles-track ~/.config/app1/themes/dark.json
/dotfiles-track ~/.config/app1/keybindings.json

# All staged, now commit together:
/dotfiles-commit
# Claude: "Add app1 configuration (config, theme, keybindings)"
```

### Option 3: Track Now, Commit Later Manually

```
/dotfiles-track ~/.config/newapp/config.yml
# File is staged

# ... make more changes to other files ...

# Later:
config-commit "Add newapp config and update related settings"
```

## What Gets Tracked

When you add a file:
- **File content** is staged for commit
- **File path** relative to home directory
- **File is now tracked** - future changes will show in `config status`

The file stays in its original location (no copying or moving).

## Common Use Cases

**New application installed:**
```
# Install app: yay -S newtool
# Configure it: ~/.config/newtool/config.toml
# Track config: /dotfiles-track ~/.config/newtool/config.toml
```

**Created custom script:**
```
# Create script: ~/.local/bin/my-script.sh
# Make executable: chmod +x ~/.local/bin/my-script.sh
# Track it: /dotfiles-track ~/.local/bin/my-script.sh
```

**New shell config:**
```
# Create: ~/.config/fish/config.fish
# Track: /dotfiles-track ~/.config/fish/config.fish
```

## Tips

💡 **Use tab completion** when typing paths (if supported in your environment)

💡 **Track early** - Add config files right after creating them, while you remember

💡 **Group related files** - Track all configs for one app before committing

💡 **Check .gitignore** - Make sure the file type isn't excluded (e.g., `.env` files are ignored for security)

## Related Skills

- `/dotfiles-commit` - Commit tracked changes
- `/dotfiles-status` - See all tracked files and changes
- `/dotfiles-rollback` - Undo if you tracked something by mistake

## Manual Equivalent

```bash
# Add file
config add ~/.config/newapp/config.yml

# Verify it's staged
config status

# Commit
config commit -m "Add newapp configuration"

# Push
config push origin main
```

## Untracking Files

If you tracked a file by mistake:

```bash
# Remove from tracking (keeps local file)
config rm --cached ~/.config/unwanted/file

# Commit the removal
config commit -m "Stop tracking unwanted file"
config push origin main
```

Or use `/dotfiles-rollback` if you haven't pushed yet.

## Security Reminder

⚠️ **Never track sensitive files:**
- `.env` files with secrets
- API keys or tokens
- Passwords or credentials
- Private SSH/GPG keys

These are already excluded in `.gitignore`, but be cautious when tracking new file types.

## Technical Details

**Uses:**
- `config add <file>` - Stages file in bare repository
- `config ls-files` - Lists currently tracked files
- `config status` - Shows staged changes
- Bare repository at `~/.dotfiles/`

**Result:**
- File is added to git index
- File remains in original location
- Future changes will be detected by `config status`
- File will be included in `config diff` output

---

This skill makes it easy to expand your dotfiles tracking as you configure new tools and applications.
