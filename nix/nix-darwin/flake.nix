{
  description = "Zen and the Art of Coding";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      configuration = { pkgs, ... }: {
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
        nix.settings.auto-optimise-store = true;
        nix.gc = {
          automatic = true;
          interval = { Weekday = 0; Hour = 0; Minute = 0; };
          options = "--delete-older-than 30d";
        };

        programs.zsh.enable = true;
        programs.fish.enable = true;

        environment.systemPackages = [
          pkgs.fish
          pkgs.tmux
          pkgs.go
          pkgs.python311
          pkgs.python311.pkgs.invoke
          pkgs.rustup
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
          pkgs._1password
          pkgs.changie
          pkgs.adrgen
          pkgs.pre-commit
          pkgs.ruff
          pkgs.cz-cli
          pkgs.visidata
        ];

        environment.shells = with pkgs; [ fish bashInteractive zsh ];
        environment.loginShell = "${pkgs.fish}/bin/fish -l";
        environment.variables.SHELL = "${pkgs.fish}/bin/fish";
        environment.variables.LANG = "en_US.UTF-8";
        environment.variables.EDITOR = "nvim";

        environment.etc."hosts" = {
          copy = true;
          text = ''
            127.0.0.1	localhost
            255.255.255.255	broadcasthost
            ::1             localhost

            127.0.0.1       localhost.local

            10.10.0.116       datacoves.orrum.com
            10.10.0.116       api.datacoves.orrum.com
            10.10.0.116       authenticate-dev123.datacoves.orrum.com
            10.10.0.116       dev123.datacoves.orrum.com
            10.10.0.116       airbyte-dev123.datacoves.orrum.com
            10.10.0.116       dbt-docs-dev123.datacoves.orrum.com
            10.10.0.116       airflow-dev123.datacoves.orrum.com
            10.10.0.116       superset-dev123.datacoves.orrum.com
            10.10.0.116       ale-5-transform-dev123.datacoves.orrum.com
            10.10.0.116       ale-7-transform-dev123.datacoves.orrum.com

            127.0.0.1     kubernetes.docker.internal

            127.0.0.1     datacoveslocal
            127.0.0.1     datacoveslocal.com
            127.0.0.1     api.datacoveslocal.com
          '';
        };

        nix.extraOptions = ''
          gc-keep-derivations = true
          gc-keep-outputs = true
          min-free = 17179870000
          max-free = 17179870000
          log-lines = 128
        '';

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
        system.defaults.NSGlobalDomain.KeyRepeat = 2;
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
