{ username, homedir }: { config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  programs.home-manager.enable = true;

  home.username = username;
  home.homeDirectory = homedir;

  home.stateVersion = "24.05";

  programs.alacritty = import ../home/alacritty.nix { inherit pkgs; };
  programs.git = import ../home/git.nix;
  programs.helix = import ../home/helix.nix;
  programs.nushell = import ../home/nushell.nix;
  programs.zellij = import ../home/zellij.nix { inherit pkgs; };
}
