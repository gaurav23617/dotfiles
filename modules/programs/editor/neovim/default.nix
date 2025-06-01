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
            lua
            luajitPackages.jsregexp
            luajitPackages.lua-lsp
            nixd
            nil
            go
            gcc
            gnumake
            unzip
            gopls
            gofumpt
            stylua
            rustc
            cargo
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
