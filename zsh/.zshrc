# ~/.zshrc

# Plugins (local clones or apt-installed)
_source_plugin() {
  local name="$1"
  [ -f "$HOME/.zsh/plugins/$name/$name.zsh" ] && source "$HOME/.zsh/plugins/$name/$name.zsh" && return
  [ -f "/usr/share/zsh-$name/$name.zsh" ] && source "/usr/share/zsh-$name/$name.zsh" && return
}
_source_plugin zsh-syntax-highlighting
_source_plugin zsh-autosuggestions
_source_plugin zsh-history-substring-search
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#585858'

# Bind substring search to Up/Down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Completions
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

# Colored man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Prompt
eval "$(starship init zsh)"

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"' 

# Core tools
. "$HOME/.local/bin/env" 2>/dev/null

# fnm
FNM_PATH="$HOME/.local/share/fnm"
[ -d "$FNM_PATH" ] && { export PATH="$FNM_PATH:$PATH"; eval "$(fnm env)"; }

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# cargo
export PATH="$HOME/.cargo/bin:$PATH"

# go
export PATH="$HOME/go/bin:$PATH"

# Corepack
alias npm="corepack npm"
alias npx="corepack npx"
alias pnpm="corepack pnpm"
alias pnpx="corepack pnpx"
alias yarn="corepack yarn"
alias yarnpkg="corepack yarnpkg"

# Editor
export EDITOR=nvim

# Machine-specific (not in dotfiles)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# zoxide
eval "$(zoxide init zsh)"

# dotnet
export PATH="$HOME/.dotnet:$PATH"

source <(proz completion)
