{ self, ... }: {
  flake.modules.nixos.devTools = { ... }: {

    # Enable direnv
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true; # caches nix evals — important, shells become instant
    };

    # Import Home-Manager module for devTools (defined below)
    home-manager.sharedModules = [
      self.modules.homeManager.devTools
    ];

  };

  flake.modules.homeManager.devTools = { pkgs, ... }: {

    home.packages = with pkgs; [
      # Development
      devenv # Declarative development environments
      nixfmt # Nix formatter
      nil # Nix language server
      nixd # Nix language server
    ];

    # Declarative development environments
    programs.devenv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

  };

}
