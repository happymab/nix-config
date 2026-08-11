{ self, inputs, ... }: {
  flake.nixosModules.zshMab = { pkgs, lib, ... }: {

    hjem.users.mab = {
      # Enable oh-my-zsh for managing the zsh configuration
      packages = with pkgs; [
        oh-my-zsh
        zsh-powerlevel10k
        zsh-autosuggestions
        zsh-syntax-highlighting
      ];

      files = {
        ".zshrc".source = ./dotfiles/.zshrc;
        ".zshenv".source = ./dotfiles/.zshenv;
        #".config/zsh".source = ./dotfiles/.config/zsh;
        ".config/zsh/aliases.zsh".source = ./dotfiles/aliases.zsh;
      };

    };
  };
}
