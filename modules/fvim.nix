{ pkgs, ... }:

{
  # Dedicated external Fennel repo path for fvim only.
  home.sessionVariables = {
    FVIM_FNL_REPO = "$HOME/.local/share/fvim-fnl";
  };

  # Add a standalone Neovim launcher using an isolated appname.
  home.packages = [
    (pkgs.writeShellScriptBin "fvim" ''
      export NVIM_APPNAME=fvim
      exec ${pkgs.neovim}/bin/nvim "$@"
    '')
  ];

  # Install hotpot into fvim's own package path.
  xdg.dataFile."fvim/site/pack/hotpot/start/hotpot.nvim".source = pkgs.vimPlugins.hotpot-nvim;

  # Minimal init for a from-scratch hotpot/fennel setup.
  xdg.configFile."fvim/init.lua".text = ''
    vim.g.mapleader = " "

    local fnl_repo = vim.env.FVIM_FNL_REPO or vim.fn.expand("~/.local/share/fvim-fnl")
    if vim.fn.isdirectory(fnl_repo) == 1 then
      vim.opt.rtp:prepend(fnl_repo)
    end

    local ok_hotpot, hotpot = pcall(require, "hotpot")
    if ok_hotpot then
      hotpot.setup({
        provide_require_fennel = true,
      })
      pcall(require, "cake.config")
    end
  '';
}
