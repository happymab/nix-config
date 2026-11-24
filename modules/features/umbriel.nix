{ inputs, ... }: {
  flake.modules.nixos.umbriel = { pkgs, ... }: {

    # Use official Umbriel flake
    imports = [ inputs.umbriel.nixosModules.default ];

    # Add luciole to nixpkgs
    nixpkgs.overlays = [ inputs.luciole.overlays.default ];

    # Configure cache for Umbriel flake
    nix.settings = {
      extra-substituters = [ "https://umbriel.cachix.org" ];
      extra-trusted-public-keys = [
        "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
      ];
    };

    # Enable Umbriel
    programs.umbriel.enable = true;

    # Install packages
    environment.systemPackages = with pkgs; [
      kitty
      noctalia
      luciole # File Manager
      kdePackages.kcolorscheme # Theming of KDE applications
      adw-gtk3 # Theming of GTK applications
      glib.bin # gdbus, gsettings — glib's bin output
      sshfs # optional, phone file browsing
    ];

  };

  flake.modules.homeManager.umbriel = { pkgs, ... }: {

    imports = [ inputs.umbriel.homeModules.default ];

    programs.umbriel = {
      enable = true;

    };

    xdg.dataFile."dbus-1/services/org.freedesktop.secrets.service".text = ''
      [D-BUS Service]
      Name=org.freedesktop.secrets
      Exec=${pkgs.kdePackages.kwallet}/bin/ksecretd
    '';

    # Add sercice to unlock KWallet in Umbriel session
    systemd.user.services.kwallet-pam-init = {
      Unit = {
        Description = "Unlock KWallet from PAM credentials";
        ConditionEnvironment = "PAM_KWALLET5_LOGIN";
        After = [
          "graphical-session-pre.target"
          "umbriel.service"
        ];
        Before = [ "umbriel-session.target" ];
        PartOf = [ "umbriel-session.target" ];
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init";
      };
      Install.WantedBy = [ "umbriel-session.target" ];
    };

  };
}
