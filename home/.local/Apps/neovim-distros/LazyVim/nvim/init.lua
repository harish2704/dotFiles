--[[
  LazyVim configuration migrated from LunarVim
]]

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Core LazyVim distribution (must be first)
  { "LazyVim/LazyVim",                         import = "lazyvim.plugins", version = "*" },

  -- Extras (use :LazyExtras to browse all available extras)
  { import = "lazyvim.plugins.extras.dap.core" },

  -- Import user plugins from lua/plugins/*.lua
  { import = "plugins" },
}, {
  defaults = { lazy = true, version = "*" },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
