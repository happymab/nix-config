{ self, inputs, ... }: {

  # Home configuration flake using hjem and home-manager
  flake.nixosModules.homeMab = { config, pkgs, ... }: {

    imports = [
      # ── Default hjem module ─────────────────────────────────
#      inputs.hjem.nixosModules.default

      # ── Default home-manager module ─────────────────────────────────
      inputs.home-manager.nixosModules.default

      # ── Features configurations ─────────────────────────────
      self.nixosModules.braveMab
    ];

    home-manager.users = {
      mab = {
        # Equivalent of hjem's user/directory options
        home.username = "mab";
        home.homeDirectory = "/home/mab";

        # Packages installed in the user's home profile
        home.packages = with pkgs; [

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

        # Equivalent of hjem's `files` — these end up as symlinks in $HOME
        home.file = {
          # Starship prompt configuration
          ".config/starship.toml".source = ./config/starship/starship.toml;

          # Zsh configuration - create an empty .zshrc to avoid the initialization message
          ".zshrc".text = "";

          # Global justfile
          ".config/just/justfile".source = ./config/just/justfile;

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

        # Equivalent of hjem's xdg.data.files
        xdg.dataFile = {
          # Copy wallpapers
          "wallpapers".source = ./assets/wallpapers;
        };

        # Required for home-manager to activate
        home.stateVersion = "26.05"; # match this to the HM/NixOS version you started with
      };
    };

#    hjem.users = {
#      mab = {
#        user = "mab"; # this is the name of the user
#        directory = "/home/mab"; # where the user's $HOME resides
#
#        # Overwrite (dot-) files in the user's home directory with files from this flake
#        clobberFiles = true;
#
#        # Packages installed in the user's home profile
#        packages = with pkgs; [
#
#          # Proton
#          proton-vpn
#          proton-pass
#          proton-authenticator
#          protonmail-desktop
#
#          # VSCode
#          vscode
#
#          # Development
#          nixfmt
#
#          # Utilities
#          restic-browser
#
#          # Miscellaneous
#          cowsay
#        ];
#
#        files = {
#          # Starship prompt configuration
#          ".config/starship.toml".source = "${self}/config/starship/starship.toml";
#
#          # Zsh configuration - create an empty .zshrc to avoid the initialization message
#          ".zshrc".text = "";
#
#          # Global justfile
#          ".config/just/justfile".source = "${self}/config/just/justfile";
#
#          # Git configuration
#          ".gitconfig".text = ''
#                        [user]
#                          name = happymab
#                          email = happymab.dev@pm.me
#                        [init]
#                          defaultBranch = main
#                        [checkout]
#            	            defaultRemote = origin
#                        [url "git@github.com:"]
#                          insteadOf = https://github.com/
#          '';
#
#          # ssh configuration
#          ".ssh/config".text = ''
#            Host github.com
#              IdentityFile ~/.ssh/github_ed25519
#              IdentitiesOnly yes
#              AddKeysToAgent yes
#          '';
#        };
#
#        xdg.data.files = {
#          # Copy wallpapers
#          "wallpapers".source = "${self}/assets/wallpapers";
#
#        };
#      };
#    };
  };
}
