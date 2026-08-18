{ self, inputs, ... }: {

  # Home configuration flake using hjem
  flake.nixosModules.homeMab = { pkgs, ... }: {

    imports = [
      # ── Default hjem module ─────────────────────────────────
      inputs.hjem.nixosModules.default

      # ── Features configurations ─────────────────────────────
      self.nixosModules.braveMab
    ];

    hjem.users = {
      mab = {
        user = "mab"; # this is the name of the user
        directory = "/home/mab"; # where the user's $HOME resides

        # Overwrite (dot-) files in the user's home directory with files from this flake
        clobberFiles = true;

        # Packages installed in the user's home profile
        packages = with pkgs; [

          # Proton
          proton-vpn
          proton-pass
          proton-authenticator
          protonmail-desktop

          # VSCode
          vscode

          # Development
          nixfmt

          # Utilities
          restic-browser

          # Miscellaneous
          cowsay
        ];

        files = {
          # Starship prompt configuration
          ".config/starship.toml".source = "${self}/config/starship/starship.toml";

          # Zsh configuration - create an empty .zshrc to avoid the initialization message
          ".zshrc".text = "";

          # Git configuration
          ".gitconfig".text = ''
                        [user]
                          name = happymab
                          email = happymab.dev@pm.me
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

          # KDE config for ssh keys
          ".config/environment.d/ssh_askpass.conf".text = ''
                        SSH_ASKPASS=/run/current-system/sw/bin/ksshaskpass
                        SSH_ASKPASS_REQUIRE=prefer   
          '';

        };

        xdg.data.files = {
          # Copy wallpapers
          "wallpapers".source = "${self}/assets/wallpapers";

        };
      };
    };
  };
}
