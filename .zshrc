export ZSH="$HOME/.oh-my-zsh"

setopt globdots
setopt EXTENDED_GLOB
ZSH_THEME="minimal"

autoload -U compinit
compinit

setopt COMPLETE_IN_WORD

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-bat
)

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin/:$PATH"
export NIX_REMOTE=daemon
export EDITOR="emacs"

alias cd="z"
alias cat="bat"
alias ls='eza -A --color=always --group-directories-first --icons'
alias ll='eza -Ahl --color=always --group-directories-first --icons'
alias lt='eza -aT --color=always --group-directories-first'
alias jctl="journalctl -p 3 -xb"

alias dsync="doom sync && pkill emacs && emacsclient -c -a 'emacs' &"

alias update="sudo dnf upgrade --refresh && home-manager switch"

eval "$(zoxide init zsh)"

fastfetch

if ! tmux has-session -t thinkfor 2>/dev/null; then
    tmux new-session -ds thinkfor
fi
