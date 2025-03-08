#!/usr/bin/env bash

set -ex

>&2 sudo echo Root login successful.

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

curl -fsSL https://apt.fury.io/nushell/gpg.key | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/fury-nushell.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

echo "deb https://apt.fury.io/nushell/ /" | sudo tee /etc/apt/sources.list.d/fury.list

sudo add-apt-repository -y ppa:maveonair/helix-editor
sudo add-apt-repository -y ppa:lepapareil/hurl

sudo apt update

sudo apt upgrade -y

sudo apt install -y \
	alacritty \
	blender \
	brave-browser \
	build-essential \
	clang \
	clang-format \
	clang-tidy \
	clang-tools \
	clangd \
	cmake \
	discord \
	g++ \
	git \
	helix \
	hurl \
	libc++-dev \
	libc++1 \
	libc++abi-dev \
	libc++abi1 \
	libclang-dev \
	libclang1 \
	libfontconfig1-dev \
	libfreetype6-dev \
	liblldb-dev \
	libllvm-ocaml-dev \
	libomp-dev \
	libomp5 \
	libxcb-xfixes0-dev \
	libxkbcommon-dev \
	lld \
	lldb \
	llvm \
	llvm-dev \
	llvm-runtime \
	nushell \
	pkg-config \
	python3 \
	python3-clang \
	qbittorrent \
	steam \
	telegram-desktop \
	vlc \
	zsh

chsh -s $(which zsh)

# Not managed
# # docker
# # gimp
# # balenaetcher
# # godot
# # obsidian
# # rider
# # spotify
# # davinci resolve

# Update path with cargo bin dir

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

curl -sS https://starship.rs/install.sh | sh -s -- -y

cargo install --locked \
	gitui \
	macchina \
	zellij

for f in $(find home -type f)
do
	cf=$HOME/${f#*/}
	mkdir -p $(dirname $cf)
	ln -sf $(realpath $f) $cf
done
