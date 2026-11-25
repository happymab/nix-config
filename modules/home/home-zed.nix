{

  flake.modules.homeManager.zed = { ... }: {

    programs.zed-editor = {
      enable = true;
      extensions = [ ];
      userSettings = {
        load_direnv = "shell_hook";
      };
    };

  };
}
