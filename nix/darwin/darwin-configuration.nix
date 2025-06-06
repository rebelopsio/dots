{ pkgs, config, self, ... }: 

{
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowUnsupportedSystem = true;
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs;
        [
            neovim
            mkalias
            alacritty
            flameshot
            _1password-cli
            skhd
            terramate
            tenv
            qmk
            lazygit
            act
            ansible
            ansible-lint
            argocd
            git
            fish
            fzf
            bat
            lsd
            stats
            tmux
            eslint_d
            exercism
            gh
            fd
            gitsign
            golangci-lint
            kubernetes-helm
            helm-ls
            helmsman
            kubectl
            k9s
            jq
            yq
            starship
            zoxide
            zellij
            nil
            obsidian
            nushell
            stow
            carapace
            # pre-commit # Removed due to Julia build failure - install via pipx instead
            pipx
            awscli2
            tree
            go-task
            packer
        ];
      fonts.packages = 
        [
            # Include all nerd fonts
        ] ++ builtins.filter pkgs.lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

      homebrew = {
          enable = true;
          taps = [
            "cloudquery/tap"
            "dagger/tap"
            "turbot/tap"
            "fluxcd/tap"
          ];
          brews = [
            "kind"
            "mas"
            "cloudquery"
            "dagger"
            "pulumi"
            "go"
            "pkg-config"
            "openssl@3"
            "bash-completion@2"
            "mcfly"
            "pyenv"
            "bash"
            "bash-preexec"
            "uv"
            "operator-sdk"
          ];
          casks = [
            "firefox@developer-edition"
            "iina"
            "the-unarchiver"
            "caffeine"
            "ghostty"
            "raycast"
            "orbstack"
          ];
          masApps = {
            "iBar" = 6737150304;
            "Meetingbar" = 1532419400;
            "Tailscale" = 1475387142;
            "Slack" = 803453959;
          };
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
          onActivation.cleanup = "zap";
        };

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while IFS= read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
            '';

      # Apple system settings
      system.defaults = {
          dock.autohide = true;
          finder.FXPreferredViewStyle = "clmv";
          loginwindow.GuestEnabled = false;
          NSGlobalDomain.AppleInterfaceStyle = "Dark";
        };

      # Auto upgrade nix package and the daemon service.
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      # programs.zsh.enable = true;  # default shell on catalina
      #programs.fish.enable = true;
      programs.bash.enable = true;

      # Set Git commit hash for darwin-version.
      # system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;
      system.primaryUser = "smorgan";

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

        # Optionally, start yabai as a service via launchd
        services.yabai = {
          enable = true;
        };
      services.sketchybar = {
        enable = true;
  };
    }
