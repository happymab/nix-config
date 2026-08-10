{ self, inputs, ... }: {
  flake.nixosModules.basePackages = { pkgs, ... }: {
    # Allow unfree packages (required for some multimedia codecs, NVIDIA drivers, etc.)
    nixpkgs.config.allowUnfree = true;

    programs = {
      # Install firefox.
      firefox.enable = true;

      # Install shells
      bash.enable = true;
      zsh.enable = true;
      fish.enable = true;
    };

    environment.shells = with pkgs; [ bash zsh fish ];

    # List packages installed in system profile
    environment.systemPackages = with pkgs; [
      git
      vim
      wget
      # Add more packages here as needed
    ];
  };
}
