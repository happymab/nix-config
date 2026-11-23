{ self, inputs, ... }: {
  flake.modules.nixos.umbriel = { pkgs, lib, ... }: {

    # Use official Umbriel flake
    imports = [ inputs.umbriel.modules.nixos.default ];

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
}
