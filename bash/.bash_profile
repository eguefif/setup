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

if which rbenv >/dev/null; then eval "$(rbenv init -)"; fi # rbenv shims
eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(rbenv init -)"

alias ls="ls -G"

export BASH_SILENCE_DEPRECATION_WARNING=1

alias lg="lazygit"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgreprc"
. "$HOME/.cargo/env"

export EDITOR=nvim
