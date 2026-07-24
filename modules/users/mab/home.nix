{ self, inputs, ... }: {

  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.mab = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.mabModule
      {
        home.mab = "mab";
        home.homeDirectory = "/home/mab";
      }
    ];
  };

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  flake.homeModules.mabModule = { pkgs, ... }: {

    programs.bash.enable = true;
    programs.bash.shellAliases.ll = "ls -l";

    programs.firefox.enable = true;

    home.packages = [
      pkgs.kdePackages.kate

      # Brave browser
      pkgs.brave

      # Proton
      pkgs.proton-vpn
      pkgs.proton-pass
      pkgs.proton-authenticator
      pkgs.protonmail-desktop

      # VSCode
      pkgs.vscode

      pkgs.hello 
    ];
    home.stateVersion = "26.05";
  };

}