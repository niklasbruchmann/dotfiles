#! /usr/bin/env sh

set -eu

packages=""
for d in */; do
  d=${d%/}
  packages="$packages $d"
done

echo "unstowing packages: $packages"

# shellcheck disable=SC2086
stow -D -t "$HOME" $packages
