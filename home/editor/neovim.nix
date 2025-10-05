{ config, pkgs, lib, homeDirectory ? config.home.homeDirectory, ... }:
let
  inherit (pkgs)
    tree-sitter lua54Packages luajitPackages nodePackages_latest vimPlugins;
  inherit (pkgs.tree-sitter-grammars)
    tree-sitter-lua tree-sitter-nix tree-sitter-go tree-sitter-python
    tree-sitter-bash tree-sitter-regex tree-sitter-markdown tree-sitter-json;
in {
  programs.neovim = {
    enable = true;

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

      nodejs_22
      nodePackages_latest.vscode-json-languageserver
      fzf
      unzip
      lua
      lua-language-server
      luajitPackages.jsregexp
      luajitPackages.luarocks
      nixd
      gnumake
      go
      gcc
      phpPackages.composer
      biome
      python313
      python313Packages.pip
      uv
      gopls
      gofumpt
      stylua
      cargo
      wordnet
      rustc
      basedpyright
      nixfmt-rfc-style
      ripgrep
      imagemagick
    ];

    plugins =
      [ vimPlugins.nvim-treesitter.withAllGrammars vimPlugins.nvim-treesitter ];
  };

  home.file.".config/nvim".source = builtins.toString
    (config.lib.file.mkOutOfStoreSymlink
      "${homeDirectory}/dotfiles/config/nvim");
}
