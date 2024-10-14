# dotfiles

Using this repo, you can get a new system setup in just a few commands.

## Mac

### Setup

Install NixOS:

```shell
sh <(curl -L https://nixos.org/nix/install)
```

Clone this repo:

```shell
nix-shell -p git --run 'git clone https://github.com/nicholaschiasson/dotfiles.git ~/Projects/github.com/nicholaschiasson/dotfiles'
```

Install configuration:

```shell
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/Projects/github.com/nicholaschiasson/dotfiles/nix/darwin#witchy
```

### Upgrading

Either update flake manually or update inputes to flake:

```shell
nix flake update ~/Projects/github.com/nicholaschiasson/dotfiles/nix/darwin
```

Reload configuration:

```shell
darwin-rebuild switch --flake ~/Projects/github.com/nicholaschiasson/dotfiles/nix/darwin#witchy
```

If you have a convenient symlink to the flake, for example at `~/nix`, nix will not be able to use this directly.

You can use `readlink` to resolve the symlink inline:

```shell
darwin-rebuild switch --flake $(readlink -f ~/nix)#witchy
```

### Resources

[Elliott's video](https://www.youtube.com/watch?v=Z8BL8mdzWHI)

[Elliott's own dotfile](https://github.com/elliottminns/dotfiles)

[nix-darwin](https://github.com/LnL7/nix-darwin)

[MyNixOS](https://mynixos.com/)
