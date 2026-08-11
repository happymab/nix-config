{ self, inputs, ... }: {
  flake.nixosModules.zshMab = { pkgs, lib, ... }: {

    hjem.users.mab = {
      # Enable oh-my-zsh for managing the zsh configuration
      packages = [ pkgs.oh-my-zsh ];

      files = {
        ".zshrc".source = ./dotfiles/.zshrc;
        ".zshenv".source = ./dotfiles/.zshenv;
        #".config/zsh".source = ./dotfiles/.config/zsh;
        ".config/aliases.zsh".source = ./dotfiles/aliases.zsh;

        # Zsh plugins
        ".config/zsh/plugins/zsh-autosuggestions".source =
          builtins.readFile "${my-inputs.zsh-users}/zsh-autosuggestions";
        ".config/zsh/plugins/zsh-syntax-highlighting".source =
          builtins.readFile "${my-inputs.zsh-users}/zsh-syntax-highlighting";
      };

    };
  };
}
