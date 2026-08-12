{ self, inputs, ... }: {
  flake.nixosModules.zshMab = { pkgs, lib, ... }: {

    hjem.users.mab = {
      packages = with pkgs; [ zsh-autosuggestions zsh-syntax-highlighting ];

      files = {
        ".zshrc".source = ./dotfiles/.zshrc;
        ".config/zsh/aliases.zsh".source = ./dotfiles/aliases.zsh;
      };

    };
  };
}
