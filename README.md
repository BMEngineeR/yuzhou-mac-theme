# yuzhou-mac-theme

我的终端环境配置 —— **Ghostty + zsh + Starship + eza**。支持 macOS 和 Linux。

## 包含什么

- **Ghostty 配置** — JetBrainsMono Nerd Font、Gruvbox Dark、半透明背景、bar 光标
- **zsh 配置** — history、补全、`zsh-autosuggestions`、`zsh-syntax-highlighting`
- **Starship** — 跨 shell 的 prompt(默认配置,启动快)
- **eza** — 替代 `ls`,按文件类型上色 + Nerd Font 图标
  - `ls` —— 带图标的简洁列表
  - `ll` —— 长格式 + git 状态
  - `la` —— 包含隐藏文件
  - `lt` —— 树形视图

## 安装

```bash
git clone https://github.com/YuzhouChang/yuzhou-mac-theme.git ~/yuzhou-mac-theme
cd ~/yuzhou-mac-theme
bash install.sh
```

完成后:

```bash
exec zsh
```

然后重启 Ghostty。

### 平台支持

| 平台 | 包管理器 | 字体安装 | 备注 |
|---|---|---|---|
| **macOS** | Homebrew(自动安装) | `brew --cask` | 全自动 |
| **Ubuntu/Debian** | apt | Nerd Fonts release zip → `~/.local/share/fonts` | `eza` 需要 24.04+ |
| **Fedora/RHEL** | dnf | 同上 | 全套包都在仓库 |
| **Arch** | pacman | 同上 | 全套包都在仓库 |
| 其他 Linux | 手动 | 同上 | 脚本会打印缺的包列表 |

`zshrc` 会自动探测 Homebrew / Linuxbrew / 系统包路径,所以无论装在哪都能 source 到插件。

## 文件结构

```
yuzhou-mac-theme/
├── README.md
├── install.sh         一键安装脚本(macOS + Linux)
├── zshrc              -> ~/.zshrc
└── ghostty/
    └── config         -> ~/.config/ghostty/config
```

## 主题切换

```bash
ghostty +list-themes
```

改 `ghostty/config` 里的 `theme = ...` 那一行。常用选项: `Catppuccin Mocha`、`Tokyo Night`、`Dracula`、`Nord`、`Solarized Dark`。
