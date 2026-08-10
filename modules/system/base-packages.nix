{ self, inputs, ... }: {
  flake.nixosModules.basePackages = { pkgs, ... }: {
    # Allow unfree packages (required for some multimedia codecs, NVIDIA drivers, etc.)
    nixpkgs.config.allowUnfree = true;

    programs = {
      # Enable zsh program at system level
      # zsh.enable = true;

      # Install firefox.
      firefox.enable = true;
    };

    # Enable multiple shells
    environment.shells = with pkgs; [ bash zsh fish ];

    # Default shell for new users
    users.defaultUserShell = pkgs.bash;

    # List packages installed in system profile
    environment.systemPackages = with pkgs; [ git vim wget ];
  };
}
