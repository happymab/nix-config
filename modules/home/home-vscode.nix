{ self, inputs, ... }: {

  flake.homeModules.vscodeExtensions =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {

      # ── VSCode ────────────────────────────────────────────────
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
          "workbench.colorTheme" = "Dark+";
          "git.confirmSync" = false;
          "zoo-code.debug" = false;
          "zoo-code.allowedCommands" = [
            "git log"
            "git diff"
            "git show"
          ];
          "zoo-code.deniedCommands" = [ ];
          "containers.containerClient" = "com.microsoft.visualstudio.containers.podman";
          "containers.orchestratorClient" = "com.microsoft.visualstudio.orchestrators.podmancompose";
          "dev.containers.dockerComposePath" = "podman-compose";
          "dev.containers.dockerPath" = "podman";
          "dev.containers.dockerSocketPath" = "/var/run/podman.sock";
          "remote.autoForwardPortsSource" = "hybrid";
          "[dockercompose]" = {
            "editor.defaultFormatter" = "ms-azuretools.vscode-containers";
          };
          "redhat.telemetry.enabled" = false;

          "[nix]" = {
            "editor.tabSize" = 2;
          };
        };

        # Optional: Disable built-in extensions
        # mutableExtensionsDir = false;
      };

      # ── Container with Qdrant DB for Code Indexing ────────────
      services.podman = {
        enable = true;
        containers."qdrant" = {
          image = "docker.io/qdrant/qdrant:latest";
          ports = [ "6333:6333" ];
          volumes = [ "qdrant-storage:/qdrant/storage:Z" ];
        };
      };
    };
}
