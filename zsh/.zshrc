export EDITOR="/opt/homebrew/bin/nvim"

if [ "$(uname)" = "Darwin" ]; then
    export XDG_CONFIG_HOME="$HOME/.config"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    alias oldprod='export AWS_PROFILE=production-poweruser && aws sso login --profile production-poweruser && aws eks update-kubeconfig --name production --region eu-central-1 --profile production-poweruser'
    alias prod='export AWS_PROFILE=production-poweruser-26 && aws sso login --profile production-poweruser-26 && aws eks update-kubeconfig --name production --region eu-central-1 --profile production-poweruser-26'
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

    deploy() {
      emulate -L zsh
      setopt err_return pipefail

      local skip_confirm=false
      if [[ "$1" == "-y" ]]; then
        skip_confirm=true
      fi

      # Ensure we're in a cargo project
      if [[ ! -f Cargo.toml ]]; then
        echo "deploy: no Cargo.toml found in current directory" >&2
        return 1
      fi

      # Extract version via cargo metadata
      local version
      version=$(cargo metadata --no-deps --format-version 1 | jq -r '.packages[0].version')

      if [[ -z "$version" || "$version" == "null" ]]; then
        echo "deploy: could not extract version from Cargo.toml" >&2
        return 1
      fi

      local tag="${version}"

      # Check if tag already exists locally or on remote
      if git rev-parse -q --verify "refs/tags/${tag}" >/dev/null; then
        echo "deploy: tag ${tag} already exists locally" >&2
        return 1
      fi

      if git ls-remote --tags origin | grep -q "refs/tags/${tag}$"; then
        echo "deploy: tag ${tag} already exists on origin" >&2
        return 1
      fi

      # Find the latest existing tag (by version sort)
      local old_tag
      old_tag=$(git tag --sort=-v:refname | head -n1)
      old_tag=${old_tag:-none}

      # Confirmation prompt, unless -y was passed
      if [[ "$skip_confirm" == false ]]; then
        echo "You are about to deploy a new version: ${old_tag} -> ${tag}"
        read -q "REPLY?Proceed? [y/N] "
        echo
        if [[ "$REPLY" != "y" ]]; then
          echo "deploy: aborted"
          return 1
        fi
      fi

      echo "deploy: creating tag ${tag}"
      git tag -a "$tag" -m "$tag"

      echo "deploy: pushing main and tags"
      git push origin main --follow-tags

      echo "deploy: creating GitHub release ${tag}"
      gh release create "$tag"
    }
else
    eval $(keychain -q --eval ~/.ssh/github)
fi

eval "$(ssh-agent -s)"
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
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."


# pnpm
export PNPM_HOME="/Users/niklas/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

