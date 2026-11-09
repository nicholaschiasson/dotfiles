#!/usr/bin/env bash

set -ex

>&2 sudo echo Root login successful.

VOL_ALACRITTY=/Volumes/alacritty
VOL_DOCKER=/Volumes/Docker
TEMP_DIR=$(mktemp -d)

cleanup() {
	hdiutil detach ${VOL_ALACRITTY}
	hdiutil detach ${VOL_DOCKER}
	rm -rf ${TEMP_DIR}
}

trap cleanup EXIT

softwareupdate --install-rosetta --agree-to-license

curl -fsSLo ${TEMP_DIR}/Docker.dmg https://desktop.docker.com/mac/main/arm64/236216/Docker.dmg
curl -fsSLo ${TEMP_DIR}/alacritty.dmg https://github.com/alacritty/alacritty/release/download/v0.17.0/Alacritty-v0.17.0.dmg

hdiutil attach ${TEMP_DIR}/Docker.dmg

sudo ${VOL_DOCKER}/Docker.app/Contents/MacOS/install --accept-license --user=$(whoami)

hdiutil attach ${TEMP_DIR}/alacritty.dmg

sudo cp -R ${VOL_ALACRITTY}/Alacritty.app /Applications/

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install -y \
	brave-browser \
	git-delta \
	gitui \
	helix \
	hurl \
	macchina \
	maccy \
	mise \
	nushell \
	obsidian \
	powershell \
	starship \
	tokei \
	visual-studio-code \
	windows-app \
	xh \
	zed \
	zellij

for f in $(find home -type f,l)
do
	cf=$HOME/${f#*/}
	mkdir -p $(dirname $cf)
	ln -sf $(realpath $f) $cf
done

echo
echo "You're all set up mate! Restart your shell and get hacking!"
