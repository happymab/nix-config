# ====== Oh My Zsh ======
export ZSH="$HOME/.cache/oh-my-zsh"
# ZSH_THEME="robbyrussell"
plugins=(git z sudo extract dotenv)
source $ZSH/oh-my-zsh.sh

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

# ====== External Plugins ======
# These need to be symlinked via hjem too
if [[ -f ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [[ -f ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ====== Aliases & Functions ======
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh
[[ -f ~/.config/zsh/functions.zsh ]] && source ~/.config/zsh/functions.zsh

# ====== Local Overrides ======
[[ -f ~/.zsh_local ]] && source ~/.zsh_local