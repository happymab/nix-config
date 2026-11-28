{
  flake.modules.nixos.obsStudio = { pkgs, ... }: {
    programs.obs-studio = {
      enable = true;

      # Optional, to feed OBS output to other applications like zoom
      # Users must be added to the "video" group
      enableVirtualCamera = true;

      # optional Nvidia hardware acceleration
      # package = (
      #   pkgs.obs-studio.override {
      #     cudaSupport = true;
      #   }
      # );

      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture # Application/window audio capture via PipeWire
        wlrobs # Wayland screen capture for wlroots-based compositors
        obs-vaapi # AMD hardware acceleration
        obs-backgroundremoval # Background blur/replacement
        obs-move-transition # Animated transitions
        obs-composite-blur # Blur.
      ];
    };
  };
}
