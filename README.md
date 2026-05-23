# yuzhou-mac-theme

我的 macOS 终端环境配置 —— Ghostty + zsh + Starship + eza。

## 包含什么

- **Ghostty 配置** — JetBrainsMono Nerd Font、Gruvbox Dark 主题、半透明背景、bar 光标
- **zsh 配置** — history、补全、`zsh-autosuggestions`、`zsh-syntax-highlighting`
- **Starship** — 跨 shell 的 prompt(默认配置,启动快)
- **eza** — 替代 `ls`,按文件类型上色 + Nerd Font 图标
  - `ls` —— 带图标的简洁列表
  - `ll` —— 长格式 + git 状态
  - `la` —— 包含隐藏文件
  - `lt` —— 树形视图

## 安装

新机器上 clone 并运行 `install.sh`:

```bash
git clone https://github.com/YuzhouChang/yuzhou-mac-theme.git ~/yuzhou-mac-theme
cd ~/yuzhou-mac-theme
bash install.sh
```

脚本会:
1. 安装 Homebrew(如果没有)
2. 安装 `starship`、`eza`、`zsh-autosuggestions`、`zsh-syntax-highlighting`、`gh`
3. 安装 JetBrainsMono Nerd Font
4. 把仓库里的 `zshrc` 和 `ghostty/config` 软链到 `~/.zshrc` 和 `~/.config/ghostty/config`(旧文件会备份成 `.backup-<时间戳>`)

完成后 `exec zsh`,重启 Ghostty。

## 文件结构

```
yuzhou-mac-theme/
├── README.md
├── install.sh         一键安装脚本
├── zshrc              -> ~/.zshrc
└── ghostty/
    └── config         -> ~/.config/ghostty/config
```

## 主题切换

Ghostty 内置很多主题,看完整列表:

```bash
ghostty +list-themes
```

改 `ghostty/config` 里的 `theme = ...` 那一行即可。常用选项: `Catppuccin Mocha`、`Tokyo Night`、`Dracula`、`Nord`、`Solarized Dark`。
