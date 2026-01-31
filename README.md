# dotfiles

개인 개발 환경 설정. Fedora / macOS 지원.

## 설치

```bash
git clone https://github.com/snacky/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 둘 중 하나 선택
make setup       # wezterm 제외
make setup-full  # wezterm 포함
```

> 기존 설정은 `~/.dotfiles_backup/`에 자동 백업됨.
> 설치 후 터미널 재시작. tmux에서 `Prefix + I`로 플러그인 설치.

### 명령어

| 명령어 | 설명 |
|--------|------|
| `make setup` | 설치 (wezterm 제외) |
| `make setup-full` | 설치 (wezterm 포함) |
| `make uninstall` | symlink 제거 |
| `make post-nvim` | nvim 플러그인/LSP 설치 |
| `make post-tmux` | tmux 플러그인 설치 |

## 구조

```
dotfiles/
├── zsh/zshrc               → ~/.zshrc
├── tmux/tmux.conf          → ~/.tmux.conf
├── starship/starship.toml  → ~/.config/starship.toml
├── nvim/                   → ~/.config/nvim
└── wezterm/                → ~/.config/wezterm (선택)
```

## 포함된 도구

| 도구 | 용도 |
|------|------|
| zsh + oh-my-zsh | Shell |
| tmux | Terminal multiplexer |
| Neovim | 에디터 |
| Starship | Prompt |
| fzf, ripgrep, fd | 검색 |
| zoxide | 디렉토리 이동 |
| lazygit | Git TUI |
| Wezterm | Terminal emulator (선택) |

## 키바인딩

### Neovim

| 키 | 동작 |
|----|------|
| `<Space>` | Leader |
| `<leader>e` | 파일 탐색기 |
| `<leader>f` | 파일 찾기 |
| `<leader>sg` | 텍스트 검색 |
| `<leader>gg` | Lazygit |
| `<leader>l` | Lazy |
| `<leader>m` | Mason |
| `gd` / `gr` | 정의 / 참조 |
| `gh` | Hover 문서 |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |
| `<leader>d` | Diagnostic |
| `[d` / `]d` | 이전/다음 diagnostic |

> 저장시 자동 포맷

### Tmux

| 키 | 동작 |
|----|------|
| `Ctrl-a` | Prefix |
| `Ctrl-h/j/k/l` | 패널 이동 |
| `Prefix + m` | 마우스 토글 |
| `Prefix + r` | 설정 리로드 |
| `Prefix + I` | 플러그인 설치 |

## 언어 추가

### 1. LSP (Mason)

```vim
:Mason
```

`i`로 설치 후 `nvim/lua/plugins/lsp.lua`에 추가:

```lua
vim.lsp.config("lua_ls", {})
vim.lsp.enable({ "gopls", "ts_ls", "lua_ls" })
```

### 2. Treesitter

```vim
:TSInstall <language>
```

### 3. Formatter

`nvim/lua/plugins/conform.lua`에 추가:

```lua
formatters_by_ft = {
  python = { "black" },
  rust = { "rustfmt" },
},
```

## 참고

- [lazy.nvim](https://github.com/folke/lazy.nvim) - Neovim 플러그인 매니저
- [tpm](https://github.com/tmux-plugins/tpm) - Tmux 플러그인 매니저
- [Catppuccin](https://github.com/catppuccin/catppuccin) - ColorScheme
