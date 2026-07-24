{ self, inputs, ... }: {

  flake.nixosModules.nixos-vmModule = { pkgs, ... }: {
    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = [
      pkgs.git
      pkgs.vim
      pkgs.wget
    ];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."mab" = {
      isNormalUser = true;
      shell = pkgs.bash;
      extraGroups = [ "networkmanager" "wheel" ];
    };

    # Use home-manager
    home-manager.users.mab = self.homeModules.mabModule;

  };

}