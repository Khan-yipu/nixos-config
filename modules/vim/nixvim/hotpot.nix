{ pkgs, ... }:

{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    hotpot-nvim
  ];

  programs.nixvim.extraConfigLua = ''
    -- External Fennel repo path (user-managed, not Home Manager managed).
    -- Priority:
    -- 1) $NVIM_FNL_REPO
    -- 2) ~/.local/share/nvim-fnl
    local fnl_repo = vim.env.NVIM_FNL_REPO or (vim.fn.expand("~/.local/share/nvim-fnl"))

    if vim.fn.isdirectory(fnl_repo) == 1 then
      vim.opt.rtp:prepend(fnl_repo)
    end

    -- Enable Hotpot so Neovim can load Fennel modules from runtimepath/fnl.
    local ok_hotpot, hotpot = pcall(require, "hotpot")
    if ok_hotpot then
      hotpot.setup({
        provide_require_fennel = true,
      })
      pcall(require, "cake.config")
    end
  '';
}
