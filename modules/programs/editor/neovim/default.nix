{ ... }:
{
  home-manager.sharedModules = [
    (
      {
        config,
        pkgs,
        lib,
        ...
      }:
      let
        inherit (pkgs)
          tree-sitter
          lua54Packages
          luajitPackages
          nodePackages_latest
          vimPlugins
          ;
        inherit (pkgs.tree-sitter-grammars)
          tree-sitter-lua
          tree-sitter-nix
          tree-sitter-go
          tree-sitter-python
          tree-sitter-bash
          tree-sitter-regex
          tree-sitter-markdown
          tree-sitter-json
          ;
      in
      {
        programs.neovim = {
          enable = true;
          vimAlias = true;
          vimdiffAlias = true;

          extraPackages = with pkgs; [
            tree-sitter
            lua54Packages.jsregexp
            tree-sitter-lua
            tree-sitter-nix
            tree-sitter-go
            tree-sitter-python
            tree-sitter-bash
            tree-sitter-regex
            tree-sitter-markdown
            tree-sitter-json

            nodePackages_latest.vscode-json-languageserver
            fzf
            lua-language-server
            luajitPackages.jsregexp
            nixd
            go
	    gcc
            gopls
            gofumpt
            stylua
            cargo
            rustc
            basedpyright
            nixfmt-rfc-style
            ripgrep
            imagemagick
          ];

          plugins = [
            vimPlugins.nvim-treesitter.withAllGrammars
            vimPlugins.nvim-treesitter
          ];
        };

        home.file.".config/nvim".source = builtins.toString (
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim"
        );
      }
    )
  ];
}
