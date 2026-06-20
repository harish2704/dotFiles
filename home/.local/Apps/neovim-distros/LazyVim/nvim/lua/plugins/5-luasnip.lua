-- @section luasnip-dart
-- LuaSnip: Extend dart filetype with flutter snippets (migrated from LunarVim)
-- When editing .dart files, this adds flutter snippet sources so that
-- Flutter-specific completions (like `stless`, `stful`) are available.

return {
  {
    "L3MON4D3/LuaSnip",
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        once = true,
        callback = function()
          local ok, luasnip = pcall(require, "luasnip")
          if ok then
            luasnip.filetype_extend("dart", { "flutter" })
          end
        end,
      })
    end,
    desc = "Add Flutter snippets to Dart buffers",
  },
}
