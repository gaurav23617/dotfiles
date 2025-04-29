{...}: {
  home-manager.sharedModules = [
    (_: {
      programs.neovim.enable = true;
      home.file.".config/nvim" = {
        source = builtins.fetchGit {
          url = "https://github.com/gaurav23617/nvim.git";
	        rev = "066d33d8c48918cacbcc4b1aa5cb7ce75179ae77";
        };
        recursive = false;
      };
    })
  ];
}
