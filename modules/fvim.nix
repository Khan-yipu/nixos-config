{ config, pkgs, ... }:

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

  # Use external Fennel repo as standard fvim config source (~/.config/fvim/fnl).
  xdg.configFile."fvim/fnl".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/WorkSpace/fvim-fnl/fnl";

  # Minimal init for a from-scratch hotpot/fennel setup.
  xdg.configFile."fvim/init.lua".text = ''
    vim.g.mapleader = " "

    local ok_hotpot, hotpot_err = pcall(require, "hotpot")
    if ok_hotpot then
      local fnl_init = vim.fn.stdpath("config") .. "/fnl/config/init.fnl"
      if vim.fn.filereadable(fnl_init) == 1 then
        local ok_config, config_err = pcall(vim.cmd, "source " .. vim.fn.fnameescape(fnl_init))
        if not ok_config then
          vim.notify("Failed to source Fennel file '" .. fnl_init .. "': " .. tostring(config_err), vim.log.levels.ERROR)
        end
      else
        vim.notify("Fennel config file not found: " .. fnl_init, vim.log.levels.WARN)
      end
    else
      vim.notify("Failed to load hotpot.nvim: " .. tostring(hotpot_err), vim.log.levels.ERROR)
    end
  '';
}
