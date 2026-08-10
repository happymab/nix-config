{ self, inputs, ... }: {
  flake.nixosModules.basePackages = { pkgs, ... }: {
    # Allow unfree packages (required for some multimedia codecs, NVIDIA drivers, etc.)
    nixpkgs.config.allowUnfree = true;

    programs = {
      # Enable Zsh
      zsh.enable = true;

      # Install firefox.
      firefox.enable = true;
    };

    # List packages installed in system profile
    environment.systemPackages = with pkgs; [
      git
      vim
      wget
      bash
      fish
    ];
  };
}
