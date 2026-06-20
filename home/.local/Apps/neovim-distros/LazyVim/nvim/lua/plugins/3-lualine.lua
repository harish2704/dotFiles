-- @section lualine
-- Lualine statusline customization (migrated from LunarVim).
-- Your LunarVim config set lualine_b to show both branch name and current file.
-- This extends the default LazyVim lualine_b (which shows just "branch") to
-- also show the full file path (%f).

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Extend the default lualine_b section to show branch + file path
      -- (preserved from LunarVim: lvim.builtin.lualine.sections.lualine_b = { 'branch', '%f' })
      opts.sections = opts.sections or {}
      opts.sections.lualine_b = { "branch", "%f" }
      return opts
    end,
  },
}
