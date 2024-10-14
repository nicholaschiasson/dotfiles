Set-ExecutionPolicy Bypass -Scope Process -Force

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

$wc = New-Object System.Net.WebClient

iex ($wc.DownloadString('https://community.chocolatey.org/install.ps1'))

cinst -y 7zip
cinst -y alacritty
cinst -y audacity
cinst -y chromium
cinst -y discord
cinst -y ditto
cinst -y docker-desktop
cinst -y Firefox
cinst -y geforce-experience
cinst -y git
cinst -y kdenlive
cinst -y lmms
cinst -y microsoft-windows-terminal
cinst -y nordvpn
cinst -y obs-studio
cinst -y paint.net
cinst -y qbittorrent
cinst -y signal
cinst -y slack
cinst -y spotify
cinst -y steam-client
cinst -y telegram
cinst -y vlc
cinst -y vscode
cinst -y WhatsApp
