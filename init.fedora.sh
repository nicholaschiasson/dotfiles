#!/usr/bin/env bash

set -e

>&2 sudo echo Root login successful.

sudo dnf upgrade -y

sudo dnf -y install dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install -y \
  bat \
  containerd.io \
  docker-buildx-plugin \
  docker-ce \
  docker-ce-cli \
  docker-compose-plugin \
  git-delta \
  fd-find \
  git \
  gitui \
  helix \
  libicu \
  net-tools \
  openssl-devel \
  tokei \
  wget \
  zsh

sudo systemctl enable --now docker

sudo usermod -aG docker $USER

sudo chsh -s $(chsh -l | grep zsh -m1) $USER

curl https://mise.run | sh

mise exec rust -- cargo install --locked \
  macchina \
  mir \
  starship \
  xh

curl -L https://github.com/zellij-org/zellij/releases/latest/download/zellij-$(uname -m)-unknown-linux-musl.tar.gz -o- | tar -xzC ~/.local/bin

curl -fsSL https://claude.ai/install.sh | bash

for f in $(find home -type f,l)
do
  cf=$HOME/${f#*/}
  mkdir -p $(dirname $cf)
  ln -sf $(realpath $f) $cf
done

echo
echo "You're all set up mate! Restart your shell and get hacking!"
