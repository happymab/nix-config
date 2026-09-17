{ self, inputs, ... }: {

  flake.homeModules.vscodeExtensions = { pkgs, lib, ... }: {

    programs.vscode = {
      enable = true;

      # VSCode variant to use
      package = pkgs.vscode; # or pkgs.vscodium

      # Extensions to install from the VSCode Marketplace
      extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
        # Editor enhancements
        ms-azuretools.vscode-containers
        ms-vscode-remote.remote-containers
        github.vscode-github-actions

        # Nix
        jnoortheen.nix-ide

        # Theme / UI
        github.github-vscode-theme
        dracula-theme.theme-dracula
        pkief.material-icon-theme

        # Tools
        streetsidesoftware.code-spell-checker
        eamodio.gitlens
        donjayamanne.githistory
        nefrob.vscode-just-syntax
        zoocodeorganization.zoo-code
      ];

      # Optional declarative settings for VS Code
      userSettings = {
        "files.autoSave" = "afterDelay";
        "editor.formatOnSave" = true;
        "editor.tabSize" = 4;
        "workbench.iconTheme" = "material-icon-theme";
        "git.confirmSync" = false;

        "[nix]" = {
          "editor.tabSize" = 2;
        };
      };

      # Optional: Disable built-in extensions
      # mutableExtensionsDir = false;
    };
  };
}
