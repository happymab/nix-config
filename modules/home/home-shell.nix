{ self, inputs, ... }: {

  flake.homeModules.shell = { pkgs, lib, ... }: {

    # Starship — customizable prompt for any shell
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      configPath = "${config.xdg.configHome}/starship.toml";
;
    };

    # Starship config file
    xdg.configFile."starship.toml".source = ${self}/config/starship/starship.toml;

    # Install bash
    programs.bash = {
      enable = true;
      enableCompletion = true;

      shellAliases = {
        ll = "ls -l";
        la = "ls -la";
        j = "just --global-justfile";
      };      
    };

    # Zsh — shell configuration
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "z"
          "sudo"
        ];
        theme = "robbyrussell";
      };

      shellAliases = {
        ll = "ls -l";
        la = "ls -la";
        j = "just --global-justfile";
      };

      history.size = 10000;
      history.ignoreDups = true;
      history.path = "$HOME/.zsh_history";
      history.ignorePatterns = [
        "rm *"
        "pkill *"
        "cp *"
      ];
    };

    home.file = {
      # Zsh configuration - create an empty .zshrc to avoid the initialization message
      ".zshrc".text = "";
    };

    # Fish shell configuration
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins = [
        # Enable a plugins
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
        {
          name = "fzf-fish";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
        {
          name = "forgit";
          src = pkgs.fishPlugins.forgit.src;
        }
        {
          name = "hydro";
          src = pkgs.fishPlugins.hydro.src;
        }
      ];
    };
  };
}
