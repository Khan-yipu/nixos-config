{ config, pkgs, ... }:

{
  # Add a standalone Neovim launcher using an isolated appname.
  home.packages = [
    (pkgs.writeShellScriptBin "fvim" ''
      export XDG_CONFIG_HOME="$HOME/WorkSpace"
      export NVIM_APPNAME=fvim-fnl
      exec ${pkgs.neovim}/bin/nvim "$@"
    '')
  ];

  # Install hotpot into fvim's own package path (appname-scoped data dir).
  xdg.dataFile."fvim-fnl/site/pack/hotpot/start/hotpot.nvim".source = pkgs.vimPlugins.hotpot-nvim;

  # Keep init.lua in the external repo root so stdpath('config') is fully standard.
  home.file."WorkSpace/fvim-fnl/init.lua".text = ''
    vim.g.mapleader = " "

    local ok_hotpot, hotpot_err = pcall(require, "hotpot")
    if ok_hotpot then
      local ok_api, hotpot_api = pcall(require, "hotpot.api")
      if ok_api then
        local ctx, ctx_err = hotpot_api.context(vim.fn.stdpath("config"))
        if ctx then
          local ok_sync, sync_err = ctx.sync({
            ["force?"] = true,
            ["atomic?"] = true,
            compilerOptions = {
              macroPath = {},
              correlate = true,
              useMetadata = true,
              ["assert-expression?"] = false
            }
          })
          if not ok_sync then
            vim.notify("Hotpot sync failed: " .. tostring(sync_err), vim.log.levels.WARN)
          end
        else
          vim.notify("Hotpot context init failed: " .. tostring(ctx_err), vim.log.levels.WARN)
        end
      else
        vim.notify("Failed to load hotpot.api: " .. tostring(hotpot_api), vim.log.levels.WARN)
      end

      local ok_config, config_err = pcall(require, "config")
      if not ok_config then
        vim.notify("Failed to load Fennel module 'config': " .. tostring(config_err), vim.log.levels.ERROR)
      end
    else
      vim.notify("Failed to load hotpot.nvim: " .. tostring(hotpot_err), vim.log.levels.ERROR)
    end
  '';
}
