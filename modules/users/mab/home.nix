{ self, inputs, ... }: {

  # home configuration flake
  flake.nixosModules.mabUser = { pkgs, ... }: {

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."mab" = {
      isNormalUser = true;
      shell = pkgs.zsh; # define shell
      initialHashedPassword =
        "$y$j9T$mqXVyJk/jjF75FmL.6UsV0$N5QecXnSDe94jr9Fxh5NFjMmNSF9a63O5LZb8b9v1l0";

      # Add user to groups
      extraGroups =
        [ "networkmanager" "wheel" "video" "render" "libvirtd" "podman" ];
    };
  };

  # Module to configure home-hjem
  flake.nixosModules.mabHjemModule = { pkgs, ... }: {

    # imports = [ self.nixosModules.braveConfigMabHjem ];
    imports =
      [ 
        inputs.hjem.nixosModules.default 
        self.nixosModules.braveConfigMabHjem 
      ];

    hjem.users = {
      mab = {
        # enable = true; # This is not necessary, since enable is 'true' by default
        user = "mab"; # this is the name of the user
        directory = "/home/mab"; # where the user's $HOME resides

        packages = with pkgs; [

          kdePackages.kate

          # Brave browser
          brave

          # Proton
          proton-vpn
          proton-pass
          proton-authenticator
          protonmail-desktop

          # VSCode
          vscode

          # Nix formatter
          nixfmt

          hello
        ];
      };
    };
  };
}
