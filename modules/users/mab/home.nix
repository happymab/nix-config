{ self, inputs, ... }: {

  # home-manager configuration flake for nixos, import in configuration.nix
  flake.nixosModules.mabUser = { pkgs, ... }: {

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."mab" = {
      isNormalUser = true;
      # shell = pkgs.zsh;
      initialHashedPassword =
        "$y$j9T$mqXVyJk/jjF75FmL.6UsV0$N5QecXnSDe94jr9Fxh5NFjMmNSF9a63O5LZb8b9v1l0";

      # Add user to groups
      extraGroups =
        [ "networkmanager" "wheel" "video" "render" "libvirtd" "podman" ];
    };

    # Use home-manager
    home-manager.users.mab = self.homeModules.mabModule;
  };

  # Standalone home-manager configuration, to be used on non-nixos machines
  # with the home-manager command
  flake.homeConfigurations.mab =
    inputs.home-manager.lib.homeManagerConfiguration {
      modules = [
        self.homeModules.mabModule
        {
          home.username = "mab";
          home.homeDirectory = "/home/mab";
        }
      ];
    };

  # Module to configure home-manager
  # It's imported both in standalone configuration above, and in nixos configuration
  flake.homeModules.mabModule = { pkgs, ... }: {

    programs.zsh = {
      enable = true;

      # Plugins
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "z"
          "zsh-autosuggestions"
          "zsh-autocomplete"
          "zsh-syntax-highlighting"
        ];
      };

      # Shell options
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      # Default aliases
      autocd = true; # cd without typing 'cd' command

      history.size = 10000;
      history.ignoreAllDups = true;
      history.path = "$HOME/.zsh_history";
      history.ignorePatterns = [ "rm *" "pkill *" "cp *" ];

      # Custom shell functions
      shellAliases = {
        ll = "ls -l --color=auto";
        la = "ls -la --color=auto";
        ls = "ls --color=auto";
        grep = "grep --color=auto";
        h = "history";
        ".." = "cd ..";
      };

    };

    imports = [ self.homeModules.braveConfigMab ];

    home.packages = with pkgs; [
      kdePackages.kate

      # Proton
      proton-vpn
      proton-pass
      proton-authenticator
      protonmail-desktop

      # VSCode
      vscode

      # Nix formatter
      nixfmt

      hello
    ];
    home.stateVersion = "26.05";
  };

}
