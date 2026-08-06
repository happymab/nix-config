{ self, inputs, ... }: {

  # home-manager configuration flake for nixos, import in configuration.nix
  flake.nixosModules.mabUser = { pkgs, ... }: {

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."mab" = {
      isNormalUser = true;
      shell = pkgs.bash; # define shell
      initialHashedPassword = "$y$j9T$mqXVyJk/jjF75FmL.6UsV0$N5QecXnSDe94jr9Fxh5NFjMmNSF9a63O5LZb8b9v1l0"

      # Add user to groups
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "render"
        "libvirtd"
        "podman"
      ];
    };

    # Use home-manager
    home-manager.users.mab = self.homeModules.mabModule;
  };

  # Standalone home-manager configuration, to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.mab = inputs.home-manager.lib.homeManagerConfiguration {
    modules = [
      self.homeModules.mabModule
      {
        home.username = "mab";
        home.homeDirectory = "/home/mab";
      }
    ];
  };

  # Module to configure home-manager
  # It's imported both in standalone configuration above, and in nixos configuration
  flake.homeModules.mabModule = { pkgs, ... }: {

    imports = [
      self.homeModules.braveConfigMab
    ];

    programs.bash.enable = true;
    programs.bash.shellAliases.ll = "ls -l";

    programs.firefox.enable = true;

    home.packages = with pkgs; [
      kdePackages.kate

      # Brave browser
      # brave

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
    home.stateVersion = "26.05";
  };

}
