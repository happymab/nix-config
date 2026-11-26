{
  flake.modules.nixos.niri = { pkgs, ... }: {

    programs.niri.enable = true;

    # Required settings
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    security.polkit.enable = true; # polkit
    services.gnome.gnome-keyring.enable = false; # secret service
    security.pam.services.swaylock = { };

    environment.systemPackages = with pkgs; [
      xwayland-satellite # xwayland support
      alacritty
      fuzzel
      swaylock
      mako
      swayidle
      noctalia
    ];

  };
}
