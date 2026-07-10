#!/usr/bin/env bash

set -ex

>&2 sudo echo Root login successful.

TEMP_DIR=$(mktemp -d)

cleanup() {
	rm -rf ${TEMP_DIR}
}

trap cleanup EXIT

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

curl -fsSL https://apt.fury.io/nushell/gpg.key | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/fury-nushell.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

echo "deb https://apt.fury.io/nushell/ /" | sudo tee /etc/apt/sources.list.d/fury.list

curl -fsSLo ${TEMP_DIR}/balena-etcher.deb https://github.com/balena-io/etcher/releases/download/v2.1.4/balena-etcher_2.1.4_amd64.deb

sudo add-apt-repository -y ppa:fish-shell/release-4
sudo add-apt-repository -y ppa:maveonair/helix-editor
sudo add-apt-repository -y ppa:lepapareil/hurl

sudo apt update

sudo apt upgrade -y

sudo apt install -y \
	${TEMP_DIR}/balena-etcher.deb \
	arduino \
	bat \
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
	fd-find \
	fish \
	g++ \
	git \
	git-delta \
	helix \
	hurl \
	libapr1 \
	libaprutil1 \
	libasound2-dev \
	libc++-dev \
	libc++1 \
	libc++abi-dev \
	libc++abi1 \
	libclang-dev \
	libclang1 \
	libfontconfig1-dev \
	libfreetype6-dev \
	libicu-dev \
	liblldb-dev \
	libllvm-ocaml-dev \
	libomp-dev \
	libomp5 \
	libudev-dev \
	libx11-dev \
	libxcb-cursor0 \
	libxcb-damage0 \
	libxcb-xfixes0-dev \
	libxkbcommon-dev \
	libxkbcommon-x11-0 \
	lld \
	lldb \
	llvm \
	llvm-dev \
	llvm-runtime \
	net-tools \
	nushell \
	openssl \
	pkg-config \
	qbittorrent \
	steam \
	vlc \
	wget \
	zsh

chsh -s $(which fish)

curl -fsSL https://tailscale.com/install.sh | sh

# Not managed
# # docker
# # gimp
# # balenaetcher
# # godot
# # obsidian
# # rider
# # spotify
# # telegram
# # davinci resolve

curl -f https://zed.dev/install.sh | sh

curl https://mise.run | sh

mise exec rust -- cargo install --locked \
	alacritty \
	gitui \
	macchina \
	mir \
	starship \
	tokei \
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

