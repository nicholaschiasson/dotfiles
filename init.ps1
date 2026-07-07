winget update --all

winget install \
    7zip.7zip \
    Alacritty.Alacritty \
    Audacity.Audacity \
    Brave.Brave \
    Discord.Discord \
    Ditto.Ditto \
    Docker.DockerDesktop \
    dotPDN.PaintDotNet \
    EpicGames.EpicGamesLauncher \
    Git.Git \
    Gyan.FFmpeg \
    Helix.Helix \
    Hibbiki.Chromium \
    JetBrains.Rider \
    LMMS.LMMS \
    Microsoft.PowerShell \
    Microsoft.WindowsTerminal \
    Microsoft.VisualStudio.2022.BuildTools \
    Microsoft.VisualStudioCode \
    NordSecurity.NordVPN \
    Nushell.Nushell \
    Obsidian.Obsidian \
    OBSProject.OBSStudio \
    OpenWhisperSystems.Signal \
    qBittorrent.qBittorrent \
    Rustlang.Rustup \
    SlackTechnologies.Slack \
    Spotify.Spotify \
    svenstaro.miniserve \
    Telegram.TelegramDesktop \
    Valve.Steam \
    VideoLAN.VLC

~\.cargo\bin\rustup.exe toolchain install stable-x86_64-pc-windows-gnu
~\.cargo\bin\rustup.exe default stable-x86_64-pc-windows-gnu

~\.cargo\bin\cargo.exe install --locked oytr

code --install-extension ms-vscode-remote.remote-wsl

if (((wsl -l -v)[2].split() | where {$_.trim() -ne ""})[1] -ne "FedoraLinux-42") {
    wsl --install FedoraLinux-42
}

# config dir symlinks...

# Further system configuration:
# - dark mode
# - developer mode
# - task bar
# - language
# - environment variables
#   - HOME
#   - etc...
