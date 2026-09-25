# Amethyst OS AURORA Zsh configuration

if [[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi

alias ll="ls -lah"
alias la="ls -A"
alias cls="clear"

export AOS_NAME="Amethyst OS Linux"
export AOS_CODENAME="AURORA"
