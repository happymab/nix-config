{ self, inputs, ... }: {
  flake.modules.nixos.input = { pkgs, ... }: {

    # Enable touchpad support (enabled by default
    # and not required in most desktopManagers).
    services.libinput.enable = true;
  };
}
