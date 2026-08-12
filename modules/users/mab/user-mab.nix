{ self, inputs, ... }: {

  # User configuration flake
  flake.nixosModules.userMab = { pkgs, ... }: {

    imports = [
      # ── User and Home configuration ───────────────────────────
      self.nixosModules.homeMab
    ];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."mab" = {
      isNormalUser = true;
      shell = pkgs.fish; # define shell
      initialHashedPassword =
        "$y$j9T$mqXVyJk/jjF75FmL.6UsV0$N5QecXnSDe94jr9Fxh5NFjMmNSF9a63O5LZb8b9v1l0";

      # Add user to groups
      extraGroups =
        [ "networkmanager" "wheel" "video" "render" "libvirtd" "podman" ];
    };
  };
}
