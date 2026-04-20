{ pkgs, ... }:

{
  # Dedicated external Fennel repo path for fvim only.
  home.sessionVariables = {
    FVIM_FNL_REPO = "$HOME/WorkSpace/fvim-fnl";
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

    local fnl_repo = vim.env.FVIM_FNL_REPO or vim.fn.expand("~/WorkSpace/fvim-fnl")
    if vim.fn.isdirectory(fnl_repo) == 1 then
      vim.opt.rtp:prepend(fnl_repo)
    else
      vim.notify("FVIM_FNL_REPO not found: " .. fnl_repo, vim.log.levels.WARN)
    end

    local ok_hotpot, hotpot_err = pcall(require, "hotpot")
    if ok_hotpot then
      local ok_config, config_err = pcall(require, "config")
      if not ok_config then
        vim.notify("Failed to load Fennel module 'config': " .. tostring(config_err), vim.log.levels.ERROR)
      end
    else
      vim.notify("Failed to load hotpot.nvim: " .. tostring(hotpot_err), vim.log.levels.ERROR)
    end
  '';
}
