{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit
    (pkgs)
    tree-sitter
    lua54Packages
    luajitPackages
    nodePackages_latest
    vimPlugins
    ;
  inherit
    (pkgs.tree-sitter-grammars)
    tree-sitter-lua
    tree-sitter-nix
    tree-sitter-go
    tree-sitter-python
    tree-sitter-bash
    tree-sitter-regex
    tree-sitter-markdown
    tree-sitter-json
    ;
in {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      tree-sitter
      lua54Packages.jsregexp

      nodejs_22
      nodePackages_latest.vscode-json-languageserver
      fzf
      unzip
      lua
      lua-language-server
      lua53Packages.luacheck
      luajitPackages.jsregexp
      lua51Packages.luarocks-nix
      luarocks
      nixd
      alejandra
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
      ripgrep
      imagemagick
      libiconv
    ];
    extraWrapperArgs = [
      "--suffix"
      "LIBRARY_PATH"
      ":"
      "${lib.makeLibraryPath [pkgs.stdenv.cc.cc.lib]}"
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
