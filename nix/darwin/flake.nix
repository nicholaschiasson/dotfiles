{
  description = "Witchy Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
    }:
    let
      username = "nicholaschiasson";

      homedir = "/Users/${username}";

      # THIS IS A HACK BUT I DON'T KNOW HOW TO WORK AROUND IT FOR NOW!
      flakerepo = "~/Projects/github.com/nicholaschiasson/dotfiles";
      flakedir = "${flakerepo}/nix/darwin";

      # Enable binfmt emulation of aarch64-linux.
      configuration =
        { pkgs, config, ... }:
        {

          nixpkgs.config.allowUnfree = true;

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = with pkgs; [
            alacritty
            audacity
            # darwin.xcode
            discord
            docker
            gimp
            git
            gitui
            # google-chrome
            helix
            hurl
            maccy
            macchina
            mkalias
            # minecraft
            nushell
            qbittorrent
            reaper
            starship
            telegram-desktop
            zellij

            (writeShellScriptBin "update" ''
              nix flake update ${flakedir}
            '')

            (writeShellScriptBin "upgrade" ''
              darwin-rebuild switch --flake ${flakedir}#witchy
            '')
          ];

          environment.interactiveShellInit = ''
            alias dotfiles="cd ${flakerepo}"
          '';

          environment.shells = [
            pkgs.nushell
          ];

          users.users.${username} = {
            name = username;
            home = homedir;
            shell = pkgs.zsh;
          };

          homebrew = {
            enable = true;
            brews = [
              "mas"
            ];
            casks = [
              "blender"
              "firefox"
              "lmms"
              "spotify"
              "vlc"
              "zed"
            ];
            masApps = {
              "DaVinci Resolve" = 571213070;
              "Xcode" = 497799835;
            };
            onActivation.cleanup = "zap";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;
          };

          networking = {
            computerName = "The Grimoire";
            hostName = "TheGrimoire";
          };

          system.activationScripts.applications.text =
            let
              env = pkgs.buildEnv {
                name = "system-applications";
                paths = config.environment.systemPackages;
                pathsToLink = "/Applications";
              };
            in
            pkgs.lib.mkForce ''
              # Setup applications.
              echo "setting up /Applications..." >&2
              rm -rf /Applications/Nix\ Apps
              mkdir -p /Applications/Nix\ Apps
              find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
              while read src; do
                app_name=$(basename "$src")
                echo "copying $src" >&2
                ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
              done
            '';

          system.defaults = {
            dock.largesize = 128;
            dock.magnification = true;
            dock.persistent-apps = [
              "/System/Applications/Mail.app"
              "/Applications/Firefox.app"
              "${pkgs.alacritty}/Applications/Alacritty.app"
              "/Applications/Zed.app"
              "/System/Applications/Messages.app"
              "${pkgs.telegram-desktop}/Applications/Telegram.app"
              "${pkgs.discord}/Applications/Discord.app"
            ];
            dock.tilesize = 16;
            finder.AppleShowAllExtensions = true;
            finder.AppleShowAllFiles = true;
            finder.ShowPathbar = true;
            finder.ShowStatusBar = true;
            finder.FXPreferredViewStyle = "clmv";
            loginwindow.GuestEnabled = false;
            NSGlobalDomain."com.apple.swipescrolldirection" = false;
            NSGlobalDomain.AppleICUForce24HourTime = true;
            NSGlobalDomain.AppleInterfaceStyle = "Dark";
            NSGlobalDomain.KeyRepeat = 2;
            SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
            CustomSystemPreferences = {
              "com.apple.systempreferences" = {
                "NSWindow Frame Main Window Frame SystemPreferencesApp 8.0" = "310 653 668 306 0 0 1680 1025 ";
              };
            };
          };

          # Auto upgrade nix package and the daemon service.
          services.nix-daemon.enable = true;
          # nix.package = pkgs.nix;

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Create /etc/zshrc that loads the nix-darwin environment.
          programs.zsh = {
            enable = true;
            promptInit = ''
              eval "$(starship init zsh)"
              macchina
            '';
          };

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "x86_64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."witchy" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = username;
            };
          }
          home-manager.darwinModules.home-manager
          {
            # `home-manager` config
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home.nix { inherit username homedir flakerepo; };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."witchy".pkgs;
    };
}
