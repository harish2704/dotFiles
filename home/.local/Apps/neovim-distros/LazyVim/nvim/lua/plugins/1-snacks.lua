-- @section snacks-picker
-- Snacks picker configuration preserved from LunarVim's Telescope settings.
-- LazyVim defaults to Snacks picker (no extra import needed since the
-- defaults system auto-enables it when Telescope/Fzf extras aren't imported).

-- Telescope's `file_ignore_patterns` handled differently in Snacks:
-- Snacks picker uses `fd`/`rg` which respect .gitignore by default.
-- Hidden files are shown, and VCS-ignored files are excluded.
-- Your original ignore patterns are listed below for reference; you can
-- adjust the find command or add global gitignore entries as needed.

return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          sources = {
            files = {
              -- Show hidden files by default (dotfiles)
              hidden = true,
            },
          },
        },
      })
    end,
  },
}
