# dotfiles

_by nchiasson_

## Preamble

This repo is for my own workstation. It used to be more geared for NixOS. Now I am not a big fan of that...

## Setup

### Windows

Step one is to run the Windows side initialization. This is done by invoking the powershell script `init.ps1`.

First, open an escalated privilege powershell window and set the execution policy to allow script execution:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```

Next, run the powershell initialization script:

```powershell
.\init.ps1
```

This will install some programs, place some configuration, and install Fedora in WSL.

Step two is to run the WSL side initialization. This is done by invoking the bash script `init.sh` from within Fedora (WSL).

Run the following in a WSL terminal window:

```bash
./init.sh
```

### Linux

Simply run the init shell script in a terminal.

```bash
./init.sh
```
