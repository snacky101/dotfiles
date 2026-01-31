DOTFILES := $(shell pwd)
XDG_CONFIG := $(HOME)/.config
UNAME := $(shell uname -s)
BACKUP_DIR := $(HOME)/.dotfiles_backup/$(shell date +%Y%m%d_%H%M%S)

.PHONY: help setup setup-full install install-full uninstall clean
.PHONY: backup backup-full _install _install-wezterm
.PHONY: deps deps-full deps-packages deps-wezterm deps-lazygit deps-starship deps-tpm deps-omz
.PHONY: post-install post-tmux post-nvim

# =============================================================================
# Default & Help
# =============================================================================

all: help

help:
	@echo "Dotfiles - $(UNAME)"
	@echo ""
	@echo "Usage:"
	@echo "  make setup       Setup without wezterm"
	@echo "  make setup-full  Setup with wezterm"
	@echo "  make uninstall   Remove symlinks"
	@echo ""
	@echo "Individual:"
	@echo "  make deps        Install dependencies (without wezterm)"
	@echo "  make deps-full   Install dependencies (with wezterm)"
	@echo "  make install     Create symlinks (without wezterm)"
	@echo "  make install-full  Create symlinks (with wezterm)"
	@echo "  make post-nvim   Setup nvim (plugins, LSP, treesitter)"
	@echo "  make post-tmux   Install tmux plugins"

# =============================================================================
# Setup
# =============================================================================

setup: deps install post-install
	@echo ""
	@echo "Done! Restart your terminal."

setup-full: deps-full install-full post-install
	@echo ""
	@echo "Done! Restart your terminal."

# =============================================================================
# Symlinks
# =============================================================================

install: backup _install

install-full: backup-full _install _install-wezterm

_install:
	@echo "Creating symlinks..."
	@mkdir -p $(XDG_CONFIG)
	@ln -sfn $(DOTFILES)/zsh/zshrc $(HOME)/.zshrc
	@ln -sfn $(DOTFILES)/tmux/tmux.conf $(HOME)/.tmux.conf
	@ln -sfn $(DOTFILES)/starship/starship.toml $(XDG_CONFIG)/starship.toml
	@rm -rf $(XDG_CONFIG)/nvim && ln -sfn $(DOTFILES)/nvim $(XDG_CONFIG)/nvim
	@echo "Done!"

_install-wezterm:
	@rm -rf $(XDG_CONFIG)/wezterm && ln -sfn $(DOTFILES)/wezterm $(XDG_CONFIG)/wezterm
	@echo "Wezterm symlink created!"

backup:
	@echo "Backing up existing configs to $(BACKUP_DIR)..."
	@mkdir -p $(BACKUP_DIR)
	@[ -e $(HOME)/.zshrc ] && [ ! -L $(HOME)/.zshrc ] && cp -r $(HOME)/.zshrc $(BACKUP_DIR)/ || true
	@[ -e $(HOME)/.tmux.conf ] && [ ! -L $(HOME)/.tmux.conf ] && cp -r $(HOME)/.tmux.conf $(BACKUP_DIR)/ || true
	@[ -e $(XDG_CONFIG)/starship.toml ] && [ ! -L $(XDG_CONFIG)/starship.toml ] && cp -r $(XDG_CONFIG)/starship.toml $(BACKUP_DIR)/ || true
	@[ -e $(XDG_CONFIG)/nvim ] && [ ! -L $(XDG_CONFIG)/nvim ] && cp -r $(XDG_CONFIG)/nvim $(BACKUP_DIR)/ || true
	@echo "Backup complete!"

backup-full: backup
	@[ -e $(XDG_CONFIG)/wezterm ] && [ ! -L $(XDG_CONFIG)/wezterm ] && cp -r $(XDG_CONFIG)/wezterm $(BACKUP_DIR)/ || true

uninstall clean:
	@echo "Removing symlinks..."
	@rm -f $(HOME)/.zshrc $(HOME)/.tmux.conf
	@rm -rf $(XDG_CONFIG)/wezterm $(XDG_CONFIG)/nvim
	@rm -f $(XDG_CONFIG)/starship.toml
	@echo "Done!"

# =============================================================================
# Dependencies
# =============================================================================

deps: deps-packages deps-lazygit deps-starship deps-omz deps-tpm

deps-full: deps deps-wezterm

deps-packages:
ifeq ($(UNAME),Darwin)
	brew install zsh tmux neovim fzf ripgrep fd go node zoxide
else
	sudo dnf install -y zsh tmux neovim fzf ripgrep fd-find golang nodejs npm zoxide
endif

deps-wezterm:
ifeq ($(UNAME),Darwin)
	brew install --cask wezterm
else
	flatpak install -y flathub org.wezfurlong.wezterm
endif

deps-lazygit:
ifeq ($(UNAME),Darwin)
	brew install lazygit
else
	sudo dnf copr enable -y atim/lazygit && sudo dnf install -y lazygit
endif

deps-starship:
ifeq ($(UNAME),Darwin)
	brew install starship
else
	curl -sS https://starship.rs/install.sh | sh -s -- -y
endif

deps-omz:
	@[ -d $(HOME)/.oh-my-zsh ] || \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

deps-tpm:
	@[ -d $(HOME)/.tmux/plugins/tpm ] || \
		git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm

# =============================================================================
# Post Install
# =============================================================================

post-install: post-tmux post-nvim

post-tmux:
	@echo "Installing tmux plugins..."
	@[ -x $(HOME)/.tmux/plugins/tpm/bin/install_plugins ] && \
		$(HOME)/.tmux/plugins/tpm/bin/install_plugins || true

post-nvim:
	@echo "Setting up nvim..."
	@nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
	@nvim --headless "+TSUpdateSync" +qa 2>/dev/null || true
	@nvim --headless "+MasonInstall gopls typescript-language-server lua-language-server" +qa 2>/dev/null || true
