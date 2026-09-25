if [[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi

export AOS_NAME="Amethyst OS Linux"
export AOS_CODENAME="AURORA"

alias ll="ls -lah"
alias la="ls -A"
alias l="ls -lah"
alias cls="clear"
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."

if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi
