{ self, inputs, ... }: {

  # User configuration flake
  flake.nixosModules.userMab = { pkgs, ... }: {

    imports = [
      # ── Default home-manager module ─────────────────────────────────
      inputs.home-manager.nixosModules.default
    ];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."mab" = {
      isNormalUser = true;
      shell = pkgs.zsh; # define shell
      initialHashedPassword = "$y$j9T$mqXVyJk/jjF75FmL.6UsV0$N5QecXnSDe94jr9Fxh5NFjMmNSF9a63O5LZb8b9v1l0";

      # Add user to groups
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "render"
        "libvirtd"
        "podman"
        "docker"
      ];
    };

    # home-manager wiring for user mab
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    # self/inputs must be forwarded into the home-manager module system,
    # since your home modules destructure them
    # home-manager.extraSpecialArgs = { inherit self inputs; };

    # enable home-manager for user mab
    home-manager.users.mab = self.homeModules.homeMab;

  };
}
