{ self, inputs, ... }: {
  flake.nixosModules.basePackages = { pkgs, ... }: {
    # Allow unfree packages (required for some multimedia codecs, NVIDIA drivers, etc.)
    nixpkgs.config.allowUnfree = true;

    # Install firefox.
    programs.firefox.enable = true;

    # List packages installed in system profile
    environment.systemPackages = with pkgs; [
      git
      vim
      wget
      # Add more packages here as needed
    ];
  };
}
