#
# ~/.zshrc
#

### ZSH HOME
export ZSH=$HOME/.zsh

### ---- history config -------------------------------------
export HISTFILE=$ZSH/.zsh_history

# How many commands zsh will load to memory.
export HISTSIZE=10000

# How many commands history will save on file.
export SAVEHIST=10000

# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS

# History won't show duplicates on search.
setopt HIST_FIND_NO_DUPS
 
autoload -Uz compinit
compinit
_comp_options+=(globdots)

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh

# fnm
export PATH="/home/njayman/.local/share/fnm:$PATH"
eval "`fnm env`"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# # [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"

source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $ZSH/plugins/zsh-shellfirm/shellfirm.plugin.zsh
source $ZSH/plugins/zsh-dirhistory/dirhistory.plugin.zsh
source $ZSH/plugins/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh
source $ZSH/plugins/fzf-tab/fzf-tab.plugin.zsh
fpath=($ZSH/plugins/zsh-completions/src $fpath)

# pnpm
export PNPM_HOME="/home/njayman/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# fnm
export PATH="/home/njayman/.local/share/fnm:$PATH"
eval "`fnm env`"
