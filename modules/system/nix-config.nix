{ self, inputs, ... }: {

  flake.nixosModules.nixConfig = { pkgs, ... }: {
    nix.settings = {

      # Enable the Flakes feature and the accompanying new nix command-line tool
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Deduplicate files in nix store
      auto-optimise-store = true;

      # Enable binary cache for nix-community
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

    };

    # Automatic clean up of nix store
    nix.gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
    };

  };
}
