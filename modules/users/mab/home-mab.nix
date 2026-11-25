{ self, inputs, ... }: {

  # Home configuration flake using home-manager
  flake.modules.homeManager.homeMab =
    {
      config,
      pkgs,
      ...
    }:
    {

      imports = [
        self.homeManagerModules.stablePkgs
        self.modules.homeManager.mabBraveOrigin
      ];

      # Set user/directory options
      home.username = "mab";
      home.homeDirectory = "/home/mab";

      # Packages installed in the user's home profile
      home.packages = with pkgs; [

        # Proton
        proton-vpn
        proton-pass
        proton-authenticator
        protonmail-desktop

        # Utilities
        restic-browser

        # Miscellaneous
        cowsay
      ];

      fonts.fontconfig.enable = true;

      # These files end up as symlinks in $HOME
      home.file = {

        # Global justfile
        ".config/just/justfile".source = "${self}/config/just/justfile";

        # Git configuration
        ".gitconfig".text = ''
          [user]
            name = happymab
            email = happymab.dev@pm.me
          [init]
            defaultBranch = main
          [checkout]
            defaultRemote = origin
          [url "git@github.com:"]
            insteadOf = https://github.com/
        '';

        # ssh configuration
        ".ssh/config".text = ''
          Host github.com
            IdentityFile ~/.ssh/github_ed25519
            IdentitiesOnly yes
            AddKeysToAgent yes
        '';
      };

      # ── SSH Agent Service ───────────────────────────────────────
      systemd.user.services.ssh-agent-setup = {
        Unit = {
          Description = "Add GitHub SSH key to ssh-agent";
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
        };

        Service = {
          Type = "oneshot";
          ExecStart = pkgs.writeShellScript "ssh-agent-setup" ''
            export SSH_ASKPASS="${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass"
            export SSH_ASKPASS_REQUIRE=force
            export DISPLAY=":0"

            # Wait up to 30s for the kwallet daemon and wallet to be available
            for i in $(seq 1 30); do
              if qdbus --list-names 2>/dev/null | grep -q 'org\.kde\.kwalletd6$'; then
                break
              fi
              sleep 1
            done

            exec ${pkgs.openssh}/bin/ssh-add $HOME/.ssh/github_ed25519
          '';
        };

        Install.WantedBy = [ "graphical-session.target" ];
      };

      xdg.dataFile = {
        # Install custom fonts
        "fonts".source = "${self}/assets/fonts";

        # Copy wallpapers
        "wallpapers".source = "${self}/assets/wallpapers";
      };

    };
}
