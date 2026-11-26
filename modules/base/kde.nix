{
  flake.modules.nixos.kde = { pkgs, lib, ... }: {

    # Enable Wayland, disable X11
    services.xserver = {
      enable = false;
      # Configure keymap for display manager (Wayland session still uses this)
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    # Enable KDE SDD login service
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true; # SDDM can serve Wayland sessions
    };

    # Enable KDE Plasma
    services.desktopManager.plasma6.enable = true;

    # Enable KDE-specific services and features
    programs.kdeconnect.enable = true;
    programs.partition-manager.enable = true;

    # Packages for kwallet integration
    environment.systemPackages = with pkgs.kdePackages; [
      ksshaskpass # Unlock ssh keys
      kwallet-pam # PAM manager
      kdialog # Show dialog boxes
    ];

    environment.variables = {
      SSH_ASKPASS = lib.mkForce "/run/current-system/sw/bin/ksshaskpass";
      SSH_ASKPASS_REQUIRE = lib.mkDefault "prefer";
    };

    # Enable KWallet PAM module (for other sessions like Niri or Umbriel)
    security.pam.services.login.kwallet = {
      enable = true; # sddm's stack includes `login`
      # forceRun = true;                    # only needed if you also login on a TTY and run start-umbriel
    };

  };
}
