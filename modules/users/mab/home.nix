{ self, inputs, ... }: {

  # This is your standalone home-manager configuration, meant to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.mab = inputs.home-manager.lib.homeManagerConfiguration {
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

    home.packages = with pkgs; [
      kdePackages.kate

      # Brave browser
      brave

      # Proton
      proton-vpn
      proton-pass
      proton-authenticator
      protonmail-desktop

      # VSCode
      vscode

      hello 
    ];
    home.stateVersion = "26.05";
  };

}