{ self, inputs, ... }: {

  flake.nixosModules.umbriel =
    { pkgs, config, ... }:
    {
      imports = [ inputs.umbriel.nixosModules.default ];

      programs.umbriel.enable = true;

      environment.systemPackages = with pkgs; [
        alacritty
        noctalia
      ];

    };
}
