# Prompt
TIME=$(date +"%I:%M")

parse_git_branch() {
  if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" != "true" ]; then
    return
  fi
  branch=$(git branch --show-current)
  if [ -z "$(git update-index --refresh)" ]; then
    symbol="O"
  else
    symbol="X"
  fi
  echo "$color($branch $symbol)"
}

set_color() {
  git update-index --refresh &>/dev/null
  if [ $? == 0 ]; then
    printf '\e[32m'
  else
    printf '\e[31m'
  fi
}

PS1="[\e[0;34m\u@\h\e[0;m | \e[0;31m$TIME\e[0;35m "'`set_color`'"\$(parse_git_branch)\e[0;m \w\e[0;m \n\$ \e[0;m"

if which rbenv >/dev/null; then eval "$(rbenv init -)"; fi # rbenv shims
eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(rbenv init -)"

alias ls="ls -G"

export BASH_SILENCE_DEPRECATION_WARNING=1
