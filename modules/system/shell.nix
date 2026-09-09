{ self, inputs, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    # Install bash
    programs.bash.enable = true;
    # Zsh — shell configuration
    programs.zsh.enable = true;
    # Fish shell configuration
    programs.fish.enable = true;
  };

}
