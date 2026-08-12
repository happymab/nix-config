{ self, inputs, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    # Starship — customizable prompt for any shell
    programs.starship = {
      enable = true;

      settings = {
        add_newline = true;
      };
    };

    # Install bash
    programs.bash = {
      enable = true;
    };

    # Zsh — shell configuration
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      ohMyZsh = {
        enable = true;
        plugins = [ "git" "z" ];
        theme = "robbyrussell";
      };

      shellAliases = {
        ll = "ls -l";
        la = "ls -la";
      };

      histSize = 10000;
      histFile = "$HOME/.zsh_history";
      setOptions = [ "HIST_IGNORE_ALL_DUPS" ];
    };

    # Fish shell configuration
    programs.fish = { enable = true; };

    environment.systemPackages = with pkgs; [
      fishPlugins.done
      fishPlugins.fzf-fish
      fishPlugins.forgit
      fishPlugins.hydro
      fzf
      fishPlugins.grc
      grc
    ];
  };

}
