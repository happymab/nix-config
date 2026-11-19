{ self, inputs, ... }: {

  flake.nixosModules.umbriel =
    { pkgs, lib, ... }:
    {
      # Use official Umbriel flake
      imports = [ inputs.umbriel.nixosModules.default ];
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
      ];

      # Enable KWallet PAM module
      security.pam.services.login.kwallet = {
        enable = true; # sddm's stack includes `login`
        # forceRun = true;                    # only needed if you also login on a TTY and run start-umbriel
      };

    };
}
