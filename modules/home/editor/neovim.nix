{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.editor.neovim;
in
{
  options.editor.neovim.enable = mkEnableOption "Enable Neovim";

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraPackages = with pkgs; [
        # Tree-sitter and grammars
        tree-sitter
        tree-sitter-lua
        tree-sitter-nix
        tree-sitter-go
        tree-sitter-python
        tree-sitter-bash
        tree-sitter-regex
        tree-sitter-markdown
        tree-sitter-json

        # LSP servers (Nix-managed, not Mason)
        lua-language-server
        nixd
        nil
        gopls
        rust-analyzer
        basedpyright
        nodePackages_latest.vscode-json-languageserver
        nodePackages_latest.vscode-langservers-extracted # HTML, CSS, JSON
        nodePackages_latest.typescript-language-server
        nodePackages_latest.bash-language-server
        nodePackages_latest.dockerfile-language-server-nodejs
        nodePackages_latest.yaml-language-server
        marksman # Markdown LSP

        # Formatters and linters
        stylua
        nixfmt-rfc-style
        gofumpt
        prettier
        black
        shfmt

        # Development tools
        gcc
        gnumake
        go
        rustc
        cargo
        nodejs_20
        python3

        # Utilities
        fzf
        ripgrep
        fd
        unzip
        git
        curl
        steam-run

        # Lua packages
        lua54Packages.jsregexp
        luajitPackages.jsregexp
      ];

      plugins = with vimPlugins; [
        nvim-treesitter.withAllGrammars
      ];
    };

    # Your LazyVim config
    home.file.".config/nvim".source = builtins.toString (
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/nvim"
    );
  };
}
