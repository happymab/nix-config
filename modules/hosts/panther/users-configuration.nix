{ self, inputs, ... }: {

  flake.nixosModules.pantherUsers = { pkgs, ... }: {

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