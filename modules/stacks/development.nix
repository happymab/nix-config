{ self, ... }: {

  flake.modules.nixos.development = { ... }: {

    # Import nixos modules
    imports = with self.modules.nixos; [
      vscode
      podman
      virtualization
    ];

    # Import separate Home-Manager modules
    home-manager.sharedModules = with self.modules.homeManager; [
      zed
    ];

  };
}
