{ self, inputs, ... }: {
  flake.nixosModules.basePackages = { pkgs, ... }: {
    # Allow unfree packages (required for some multimedia codecs, NVIDIA drivers, etc.)
    nixpkgs.config.allowUnfree = true;

    programs = {
      # Install firefox.
      firefox.enable = true;
    };

    environment.shells = with pkgs; [ bash zsh fish ];

    # List packages installed in system profile
    environment.systemPackages = with pkgs; [ 
      git
      vim
      wget
      curl
      htop
      tree
      just
      just-lsp
      rsync
      rclone
      restic
      p7zip
      ripgrep
    ];

    # Install default fonts
    fonts.enableDefaultPackages = true;

    # List additional fonts to be installed in system profile
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      liberation_ttf
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      ubuntu-sans
      cm_unicode
      corefonts
      unifont

      # Nerd Fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.iosevka
      nerd-fonts.geist-mono
      nerd-fonts.sauce-code-pro
      nerd-fonts.droid-sans-mono
    ];

    fonts.fontconfig.defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font"];
    };

  };
}
