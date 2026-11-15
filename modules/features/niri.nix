{ self, inputs, ... }: {

  flake.nixosModules.niri =
    { pkgs, config, ... }:
    {
      programs.niri.enable = true;

      # Required settings
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
      security.polkit.enable = true; # polkit
      services.gnome.gnome-keyring.enable = false; # secret service
      security.pam.services.swaylock = { };

      programs.waybar.enable = true; # top bar
      environment.systemPackages = with pkgs; [
        alacritty
        fuzzel
        swaylock
        mako
        swayidle
        noctalia
      ];

      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${config.programs.niri.package}/bin/niri-session";
            user = "mab";
          };
        };
      };
    };
}
