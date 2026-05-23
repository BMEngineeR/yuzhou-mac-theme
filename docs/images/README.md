# Screenshot checklist

This folder holds the screenshots referenced from `../setup.qmd`.
Take each one in Ghostty (so the font/theme are correct), then
**redact** anything sensitive before committing.

## Capture tools (macOS)

- **Built-in:** `Cmd-Shift-4` for a region, `Cmd-Shift-5` for window selection.
- **Open in Preview** → Tools menu → **Annotate** → choose the rectangle or
  blur tool to mask regions before saving.
- **CLI redaction with ImageMagick** (after `brew install imagemagick`):
  ```bash
  # Blur a region: x,y is top-left, WxH is region size
  magick input.png \
    -region 200x30+400+50 -blur 0x10 \
    output.png
  ```

## What to redact in every screenshot

Before saving, blur or crop out:

- Absolute paths containing your **username** (e.g. `/Users/yuzhou/...`)
  - …unless the path is the point of the screenshot. Then blur just the
    username segment.
- **Hostname** in the prompt (Starship hides it by default — verify yours
  does too).
- Any **environment variable values** that look like tokens
  (`gh_...`, `sk-...`, `ghp_...`, AWS keys, `BUN_INSTALL=...` is fine).
- **Git remote URLs** with embedded credentials (`https://USER:TOKEN@github.com/...`).
- **Email addresses** that appear in `git config` output, commit author
  lines, or `gh auth status`.
- Anything from a private repo: branch names, file names, internal hostnames.

## Per-image checklist

### 01-before.png — "Before" state

- **Show:** plain default `bash`/`zsh` prompt, `ls` output without colors,
  default font.
- **Suggestion:** boot a fresh Docker container or open Terminal.app and
  run `bash --noprofile --norc` to get a vanilla prompt, then `ls -la`.
- **Redact:** absolute paths with your username.

### 02-after.png — "After" state

- **Show:** Ghostty window with Starship prompt + colored `ls` output
  in the same directory as 01-before.
- **Redact:** absolute paths with your username (if visible above the
  prompt in scrollback).

### 03-installer-run.png — Installer progress

- **Show:** the final portion of `bash install.sh` output: `==> Installing…`
  and `==> Linked …` lines, ending with `Done. Restart Ghostty…`.
- **Redact:** any `brew` warning lines that include `gh auth` tokens or
  remote URLs. Username in `==> Linked /Users/<user>/.zshrc -> …` lines —
  blur the `<user>` portion.

### 04-starship-git.png — Starship inside a git repo

- **Show:** `cd` into this repo, then a `❯` prompt — should display
  `yuzhou-mac-theme on  main` (with a Nerd Font branch icon).
- **Redact:** absolute paths in scrollback above the prompt.

### 05-eza-ll.png — `ll` long format with git column

- **Show:** running `ll` inside `~/Documents/GitHub/yuzhou-mac-theme/`.
- **Redact:** the user portion of any paths printed in the user/group
  columns (`yuzhou staff` → blur `yuzhou`).

### 06-zsh-plugins.png — Syntax highlight + autosuggestion

- **Show:** type `git st` partially — `zsh-autosuggestions` should show
  a gray suggestion like `git status --short`. Type a misspelled command
  to show red highlighting.
- **Redact:** anything in scrollback that references file paths or
  hostnames.

### 07-theme-catppuccin.png and 08-theme-tokyo.png

- **Show:** identical command run (e.g. `ll`) in each theme.
- **Redact:** same as 05.

### 09-verify.png — Verification commands

- **Show:** the block of commands from the "Verification" section,
  each returning a value.
- **Redact:** username portion of the font path printed by `fc-list`.

## Saving and committing

Save all images as **PNG** (lossless; renders crisply in HTML/PDF). After
masking each file, verify:

```bash
# Sanity check — should show 9 PNGs
ls docs/images/*.png

# Quick visual review of every image
open docs/images/*.png   # macOS
```

Only commit images you've confirmed are masked.
