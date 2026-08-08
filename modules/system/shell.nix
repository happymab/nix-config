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
  };
}
