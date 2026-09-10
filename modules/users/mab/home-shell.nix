{ self, inputs, ... }: {

  flake.homeModules.mabShell = { pkgs, lib, ... }: {

    # Starship — customizable prompt for any shell
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
    xdg.configFile."starship.toml".source = "${self}/config/starship/starship.toml";

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

      shellAliases = {
        ll = "ls -l";
        la = "ls -la";
        j = "just --global-justfile";
      };

      # Anything that would be in .zshrc goes here
      initExtra = "";

      history.size = 10000;
      history.ignoreDups = true;
      history.path = "$HOME/.zsh_history";
      history.ignorePatterns = [
        "rm *"
        "pkill *"
        "cp *"
      ];
    };

    # Fish shell configuration
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };
  };
}
