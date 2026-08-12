{ self, inputs, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    # Starship — customizable prompt for any shell
    programs.starship = {
      enable = true;

      settings = {
        add_newline = true;
        # AWS/GCloud/Line break can be disabled as needed:
        # aws.disabled = true;
        # gcloud.disabled = true;
        # line_break.disabled = true;
      };
    };

    # Zsh — shell configuration
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        la = "ls -la";
      };

      histSize = 10000;
      histFile = "$HOME/.zsh_history";
      setOptions = [ "HIST_IGNORE_ALL_DUPS" ];
    };
  };
}
