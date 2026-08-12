{ self, inputs, ... }: {

  # Home configuration flake using hjem
  flake.nixosModules.homeMab = { pkgs, ... }: {

    imports = [
      # ── Default hjem module ─────────────────────────────────
      inputs.hjem.nixosModules.default

      # ── Features configurations ─────────────────────────────
      self.nixosModules.braveMab
      # self.nixosModules.zshMab
    ];

    hjem.users = {
      mab = {
        user = "mab"; # this is the name of the user
        directory = "/home/mab"; # where the user's $HOME resides

        # Overwrite (dot-) files in the user's home directory with files from this flake
        clobberFiles = true;

        # Packages installed in the user's home profile
        packages = with pkgs; [

          # kdePackages.kate

          # Proton
          proton-vpn
          proton-pass
          proton-authenticator
          protonmail-desktop

          # VSCode
          vscode

          # Nix formatter
          nixfmt
        ];
      };
    };
  };
}
