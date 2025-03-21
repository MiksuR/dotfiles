#!/usr/bin/env zsh

# Lambdas: λ 𝝺
PROMPT_DEFAULT_END=λ
PROMPT_ROOT_END=#
PROMPT_SUCCESS_COLOR=$FG[002]
PROMPT_FAILURE_COLOR=$FG[001]

autoload -U add-zsh-hook

function git_prompt_info() {
  local ref
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "(%{$PROMPT_SUCCESS_COLOR%}$(parse_git_dirty)${ref#refs/heads/}%{$PROMPT_SUCCESS_COLOR%})"
  fi
}

PROMPT='%(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})${SSH_TTY:+[%n@%m]}%{$FX[bold]%}%$%~ $(git_prompt_info)%<<%(!.$PROMPT_ROOT_END.$PROMPT_DEFAULT_END)%{$FX[no-bold]%}%{$FX[reset]%} '
RPROMPT='%{$fg[red]%}%*%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_DIRTY="%{$PROMPT_FAILURE_COLOR%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
