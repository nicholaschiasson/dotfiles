autoload -U select-word-style
autoload -Uz compinit && compinit
select-word-style bash

# see: bindkey -L
bindkey "^[[3~" delete-char
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "^[\b" backward-kill-word
bindkey "^\b" backward-delete-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

eval "$(mise activate zsh)"
eval "$(starship init zsh)"

macchina
