{
  description = "Zen and the Art of Coding";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable }:
    let
      unstablePkgs = import nixpkgs-unstable {
        system = "aarch64-darwin";
        config = { allowUnfree = true; };
      };
      configuration = { pkgs, lib, ... }: {
        nix.package = pkgs.nix;
        nix.settings.experimental-features = "nix-command flakes";
        nix.settings.trusted-substituters =
          [ "https://cache.nixos.org" "https://devenv.cachix.org" ];
        nix.settings.trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        ];
        nix.settings.extra-sandbox-paths =
          [ "/private/tmp" "/private/var/tmp" "/usr/bin/env" ];
        nix.settings.auto-optimise-store = false;
        nix.optimise.automatic = false;
        nix.gc = {
          automatic = true;
          interval = { Weekday = 0; Hour = 0; Minute = 0; };
          options = "--delete-older-than 30d";
        };

        programs.zsh.enable = true;
        programs.fish.enable = true;
        programs.fish.interactiveShellInit = '' 
        fish_add_path /run/current-system/sw/bin
        set -gx LIBRARY_PATH "${lib.makeLibraryPath [ pkgs.darwin.libiconv ]}"
        '';

        environment.systemPackages = [
          # pkgs.ghostty NOTE: this is broken in nixpkgs for now
          pkgs.fish
          pkgs.tmux
          pkgs.go
          pkgs.python312
          pkgs.python312.pkgs.invoke
          pkgs.python312.pkgs.numpy
          pkgs.zig
          pkgs.clojure
          pkgs.kotlin
          unstablePkgs.uv
          pkgs.rustc
          pkgs.nodejs_20
          pkgs.ripgrep
          pkgs.fzf
          pkgs.fd
          pkgs.jq
          pkgs.yq
          pkgs.btop
          pkgs.lazygit
          pkgs.wget
          pkgs.direnv
          pkgs.opentofu
          pkgs.tree
          pkgs.gh
          pkgs.gnused
          pkgs.gnupg
          pkgs.mkcert
          pkgs.openssl
          pkgs.watchman
          pkgs.xplr
          pkgs.cmake
          pkgs.clang
          pkgs.gcc
          pkgs.openblas
          pkgs.nss
          pkgs.duckdb
          pkgs.sqlite
          pkgs.kubectl
          pkgs.kind
          pkgs.kubernetes-helm
          pkgs.google-cloud-sdk
          pkgs.brotli
          pkgs.gitleaks
          pkgs.git-secret
          pkgs._1password-cli
          pkgs.changie
          pkgs.adrgen
          pkgs.pre-commit
          unstablePkgs.ruff
          pkgs.cz-cli
          pkgs.darwin.libiconv
          pkgs.darwin.apple_sdk.frameworks.SystemConfiguration
          pkgs.openssl
          pkgs.xz
          pkgs.starship
          pkgs.bat
          pkgs.zoxide
          pkgs.eza
          unstablePkgs.k9s
          pkgs.delta
          pkgs.cowsay
          pkgs.fastfetch
          pkgs.coreutils
          unstablePkgs.go-task
        ];

        environment.shells = with pkgs; [ fish bashInteractive zsh ];
        environment.variables.SHELL = "${pkgs.fish}/bin/fish";
        environment.variables.LANG = "en_US.UTF-8";
        environment.variables.EDITOR = "nvim";

        environment.variables.PGHEADER = "${pkgs.postgresql}/include/libpq-fe.h";

        nix.extraOptions = ''
          gc-keep-derivations = true
          gc-keep-outputs = true
          min-free = 17179870000
          max-free = 17179870000
          log-lines = 128
        '';

        nixpkgs.config.permittedInsecurePackages = [ "olm-3.2.16" ];
        nixpkgs.config.allowUnfree = true;
        nixpkgs.hostPlatform = "aarch64-darwin";

        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.stateVersion = 4;

        services.dnsmasq.enable = true;
        services.dnsmasq.addresses = { ".datacoveslocal.com" = "127.0.0.1";  };
        services.nix-daemon.enable = true;

        system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
        system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
        system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
        system.defaults.NSGlobalDomain.KeyRepeat = 1;
        system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
        system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled =
          false;
        system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled =
          false;
        system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled =
          false;
        system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled =
          false;
        system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode =
          true;
        system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 =
          true;
        system.defaults.NSGlobalDomain._HIHideMenuBar = true;

        system.defaults.NSGlobalDomain.NSAutomaticWindowAnimationsEnabled =
          false;
        system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
        system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
        system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;

        system.defaults.spaces.spans-displays = false;

        system.defaults.LaunchServices.LSQuarantine = false;

        system.defaults.screencapture.location = "$HOME/Pictures";
        system.defaults.screencapture.type = "png";
        system.defaults.screencapture.disable-shadow = true;

        system.defaults.dock.autohide = true;
        system.defaults.dock.mru-spaces = false;
        system.defaults.dock.orientation = "left";
        system.defaults.dock.showhidden = true;

        system.defaults.finder.AppleShowAllFiles = true;
        system.defaults.finder.FXDefaultSearchScope = "SCcf";
        system.defaults.finder.FXEnableExtensionChangeWarning = false;
        system.defaults.finder._FXShowPosixPathInTitle = true;
        system.defaults.finder.FXPreferredViewStyle = "Nlsv";
        system.defaults.finder.ShowStatusBar = false;
      };
    in {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake ~/.config/nix/nix-darwin#Alexander-Butle
      darwinConfigurations."Alexander-Butle" =
        nix-darwin.lib.darwinSystem { modules = [ configuration ]; };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Alexander-Butle".pkgs;
    };
}
