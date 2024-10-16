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

Update inputs to flake using the helper script added to the environment:

```shell
update
```

Reload configuration after updating inputs or making modifications to nix files using the upgrade helper script added to the environment:

```shell
upgrade
```

### Resources

[Elliott's video](https://www.youtube.com/watch?v=Z8BL8mdzWHI)

[Elliott's own dotfile](https://github.com/elliottminns/dotfiles)

[nix-darwin](https://github.com/LnL7/nix-darwin)

[MyNixOS](https://mynixos.com/)
