Set-ExecutionPolicy Bypass -Scope Process -Force

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

$wc = New-Object System.Net.WebClient

iex ($wc.DownloadString('https://community.chocolatey.org/install.ps1'))

cinst -y 7zip
cinst -y alacritty
cinst -y audacity
cinst -y battle.net
cinst -y bind-toolsonly
cinst -y chromium
cinst -y discord
cinst -y ditto
cinst -y docker-desktop
cinst -y epicgameslauncher
cinst -y ffmpeg
cinst -y fiddler
cinst -y Firefox
cinst -y geforce-experience
cinst -y git
cinst -y GoogleChrome
cinst -y inkscape
cinst -y iTunes
cinst -y kdenlive
cinst -y krita
cinst -y lmms
cinst -y microsoft-windows-terminal
cinst -y minecraft-launcher
cinst -y nordvpn
cinst -y notepadplusplus
cinst -y nvm
cinst -y obs-studio
cinst -y osu
cinst -y paint.net
cinst -y postman
cinst -y python
cinst -y qbittorrent
cinst -y rufus
cinst -y rustup.install
cinst -y signal
cinst -y slack
cinst -y sourcetree
cinst -y spotify
cinst -y steam-client
cinst -y telegram
cinst -y uplay
cinst -y visualstudio2019-workload-vctools
cinst -y vlc
cinst -y vscode
cinst -y WhatsApp

$rustup_init = "rustup-init.exe"
$rustup_init_file = "${env:TEMP}/$rustup_init"
$wc.DownloadFile("https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/$rustup_init", $rustup_init_file)
iex "$rustup_init_file -y"
