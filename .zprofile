export XDG_CONFIG_HOME="$HOME/.config"
export CARGO_NET_GIT_FETCH_WITH_CLI=true

# alias
alias gst="git status"
alias ga="git add"
alias gc="git commit -v"
alias gl="git pull"
alias gp="git push"
alias gf="git fetch"
alias l="ls -alh"
alias cr="cargo run"
alias cw="cargo watch -x run"
alias docker="podman"
alias prod='export AWS_PROFILE=production-poweruser && aws sso login --profile production-poweruser && aws eks update-kubeconfig --name production --region eu-central-1 --profile production-poweruser'
