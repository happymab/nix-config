{ self, inputs, ... }: {

  flake.nixosModules.nixos-vmModule = { pkgs, ... }: {

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # starship - an customizable prompt for any shell
    programs.starship = {
      enable = true;
      # custom settings
      settings = {
        add_newline = true;
        # aws.disabled = true;
        # gcloud.disabled = true;
        # line_break.disabled = true;
      };
    };

    # Install firefox.
    programs.firefox.enable = true;

    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
      git
      vim
      wget
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