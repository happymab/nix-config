# ====== History ======
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

# ====== Options ======
setopt AUTO_CD
setopt COMPLETE_IN_WORD
unsetopt BEEP

# ====== Environment ======
export PATH="$HOME/bin:$PATH"

# ====== Aliases & Functions ======
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh
[[ -f ~/.config/zsh/functions.zsh ]] && source ~/.config/zsh/functions.zsh

# ====== Local Overrides ======
[[ -f ~/.zsh_local ]] && source ~/.zsh_local