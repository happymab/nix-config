{ self, inputs, ... }: {
  flake.nixosModules.audio = { pkgs, ... }: {
    # Enable sound with PipeWire (PulseAudio disabled)
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # If you want to use JACK applications, uncomment this
      # jack.enable = true;

      # Use the example session manager (no others are packaged yet)
      # media-session.enable = true;

      # Optional: WirePlumber for enhanced session management
      wireplumber.enable = true;
    };
  };
}
