# yuzhou-mac-theme

My terminal setup — **Ghostty + zsh + Starship + eza**. Works on macOS and Linux.

## What's inside

- **Ghostty config** — JetBrainsMono Nerd Font, Gruvbox Dark, slightly transparent background, bar cursor
- **zsh config** — history, completion, `zsh-autosuggestions`, `zsh-syntax-highlighting`
- **Starship** — fast cross-shell prompt (default config, no customization needed)
- **eza** — `ls` replacement that colors files by type and shows Nerd Font icons
  - `ls` — clean icon list
  - `ll` — long format with git status
  - `la` — long format including hidden files
  - `lt` — tree view (2 levels deep)

## Install

```bash
git clone https://github.com/BMEngineeR/yuzhou-mac-theme.git ~/yuzhou-mac-theme
cd ~/yuzhou-mac-theme
bash install.sh
```

Then:

```bash
exec zsh
```

…and restart Ghostty.

### Platform support

| Platform        | Package manager        | Font install                                              | Notes                          |
|-----------------|------------------------|-----------------------------------------------------------|--------------------------------|
| **macOS**       | Homebrew (auto)        | `brew --cask`                                             | Fully automatic                |
| **Ubuntu/Debian** | apt                  | Nerd Fonts release zip → `~/.local/share/fonts`            | `eza` requires 24.04+          |
| **Fedora/RHEL** | dnf                    | same                                                      | All packages in default repos  |
| **Arch**        | pacman                 | same                                                      | All packages in default repos  |
| Other Linux     | manual                 | same                                                      | Script prints missing packages |

`zshrc` auto-detects Homebrew / Linuxbrew / system package paths, so plugins source correctly regardless of where they were installed.

## File layout

```
yuzhou-mac-theme/
├── README.md
├── install.sh         one-shot installer (macOS + Linux)
├── zshrc              -> ~/.zshrc
└── ghostty/
    └── config         -> ~/.config/ghostty/config
```

## Switching themes

```bash
ghostty +list-themes
```

Edit the `theme = ...` line in `ghostty/config`. Popular picks: `Catppuccin Mocha`, `Tokyo Night`, `Dracula`, `Nord`, `Solarized Dark`.
