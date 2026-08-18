{ self, inputs, ... }: {
  flake.nixosModules.desktopKde = { pkgs, ... }: {
    # Enable Wayland (X11 is disabled intentionally for modern KDE/Plasma 6)
    services.xserver = {
      enable = false;
    };

    # Configure keymap for display manager (Wayland session still uses this)
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable the KDE Plasma Desktop Environment
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true; # SDDM can serve Wayland sessions
    };

    services.desktopManager.plasma6.enable = true;

    # KDE-specific optimizations
    services.xserver.displayManager.sessionCommands = ''
      # Additional session commands if needed
    '';

    # Enable KDE-specific services and features
    programs.kdeconnect.enable = true;
    programs.partition-manager.enable = true;

    # Unmlock ssh keys
    environment.systemPackages = [
      pkgs.kdePackages.ksshaskpass
    ];
    environment.sessionVariables = {
      SSH_ASKPASS = "/run/current-system/sw/bin/ksshaskpass";
      SSH_ASKPASS_REQUIRE = "prefer";
    };
  };
}
