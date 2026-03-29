if [ "$(uname)" = "Darwin" ]; then
    export XDG_CONFIG_HOME="$HOME/.config"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    alias prod='export AWS_PROFILE=production-poweruser && aws sso login --profile production-poweruser && aws eks update-kubeconfig --name production --region eu-central-1 --profile production-poweruser'
fi

eval "$(starship init zsh)"
source ~/.config/zsh-autosuggestions.zsh

export CARGO_NET_GIT_FETCH_WITH_CLI=true

if [ -d "$HOME/.bun/bin" ]; then
  export PATH="$HOME/.bun/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

export PATH="$HOME/.local/share/nvim/site:$PATH"

# aliases
alias gst="git status"
alias ga="git add"
alias gc="git commit -v"
alias gl="git pull"
alias gp="git push"
alias gf="git fetch"
alias gco="git checkout"
alias gcm="git checkout \$(git symbolic-ref refs/remotes/origin/HEAD | cut -d'/' -f4)"
alias l="ls -alh --color=auto"
alias cr="cargo run"
alias cw="cargo watch -x run"
alias docker="podman"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

