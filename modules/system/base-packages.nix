{ self, inputs, ... }: {
  flake.nixosModules.basePackages = { pkgs, ... }: {
    # Allow unfree packages (required for some multimedia codecs, NVIDIA drivers, etc.)
    nixpkgs.config.allowUnfree = true;

    programs = {
      # Install firefox.
      firefox.enable = true;

      # Install zsh and fish
      zsh.enable = true;
      fish.enable = true;
    };

    # List packages installed in system profile
    environment.systemPackages = with pkgs; [
      git
      vim
      wget

    ];
  };
}
