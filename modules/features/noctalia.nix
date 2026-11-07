{ self, inputs, ... }: {
  flake.nixosModules.noctalia = { pkgs, ... }: {
    imports = [
      inputs.noctalia.nixosModules.default
      inputs.umbriel.nixosModules.default
    ];

    programs.umbriel.enable = true;

    programs.noctalia = {
      enable = true;

      # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
      recommendedServices.enable = true;
    };

    environment.systemPackages = with pkgs; [
      alacritty
      kitty
      fuzzel
      swaylock
      mako
      swayidle
    ];

    security.polkit.enable = true; # polkit
    services.gnome.gnome-keyring.enable = true; # secret service
    security.pam.services.swaylock = { };
  };
}
