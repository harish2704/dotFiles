-- @section plugins
-- Extra plugins migrated from LunarVim's `lvim.plugins` list.
-- Each plugin is defined as a lazy.nvim spec.

return {
  --- @section plugins-editorconfig
  {
    "gpanders/editorconfig.nvim",
    desc = "EditorConfig support (respects .editorconfig files)",
  },

  --- @section plugins-emmet
  {
    "mattn/emmet-vim",
    desc = "Emmet: HTML/CSS Zen coding expansion",
  },

  --- @section plugins-fugitive
  {
    "tpope/vim-fugitive",
    cmd = {
      "G", "Git", "Gdiffsplit", "Gread", "Gwrite",
      "Ggrep", "GMove", "GDelete", "GBrowse",
      "GRemove", "GRename", "Glgrep", "Gedit",
    },
    ft = { "fugitive" },
    desc = "Git integration (tpope)",
  },
  {
    "selimacerbas/live-server.nvim",
    dependencies = {
      "folke/which-key.nvim",
      "nvim-telescope/telescope.nvim", -- recommended for path picker
    },
    init = function()
      -- which-key group label only (best practice)
      local ok, wk = pcall(require, "which-key")
      if ok then wk.add({ { "<leader>l", group = "LiveServer" } }) end
    end,
    opts = {
      default_port = 8000,
      live_reload = { enabled = true, inject_script = true, debounce = 120, css_inject = true },
      directory_listing = { enabled = true, show_hidden = false },
    },
    -- map to user commands (robust lazy-loading)
    keys = {
      { "<leader>ls", "<cmd>LiveServerStart<cr>",      desc = "Start (pick path & port)" },
      { "<leader>lo", "<cmd>LiveServerOpen<cr>",       desc = "Open existing port in browser" },
      { "<leader>lr", "<cmd>LiveServerReload<cr>",     desc = "Force reload (pick port)" },
      { "<leader>lt", "<cmd>LiveServerToggleLive<cr>", desc = "Toggle live-reload (pick port)" },
      { "<leader>li", "<cmd>LiveServerStatus<cr>",     desc = "Show server status" },
      { "<leader>lS", "<cmd>LiveServerStop<cr>",       desc = "Stop one (pick port)" },
      { "<leader>lA", "<cmd>LiveServerStopAll<cr>",    desc = "Stop all" },
    },
    config = function(_, opts)
      require("live_server").setup(opts)
    end,
  },

  --- @section plugins-markdown-preview
  {
    "harish2704/markdown-preview.nvim",
    dependencies = { "selimacerbas/live-server.nvim" },
    ft = 'markdown',
    config = function()
      require("markdown_preview").setup({
        -- all optional; sane defaults shown
        instance_mode = "takeover", -- "takeover" (one tab) or "multi" (tab per instance)
        port = 0,                   -- 0 = auto (8421 for takeover, OS-assigned for multi)
        open_browser = true,
        default_theme = "light",    -- "dark" or "light"; initial preview theme
        debounce_ms = 300,
        mermaid_elk = true,
      })
    end,
  },
  -- {
  --   {
  --     "iamcco/markdown-preview.nvim",
  --     ft = 'markdown',
  --     build = function()
  --       require("lazy").load({ plugins = { "markdown-preview.nvim" } })
  --       vim.fn["mkdp#util#install"]()
  --       local app_dir = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app"
  --       vim.fn.system(
  --         "cd "
  --         .. app_dir
  --         .. " && bun install mermaid@latest && cp node_modules/mermaid/dist/mermaid.min.js _static/mermaid.min.js"
  --       )
  --     end,
  --   },
  -- },

  -- --- @section plugins-bracey
  {
    "turbio/bracey.vim",
    cmd = { "Bracey", "BracyStop", "BraceyReload", "BraceyEval" },
    build = "npm install --prefix server",
    desc = "Live HTML/CSS/JS editor preview",
  },

  --- @section plugins-gnupg
  {
    "jamessan/vim-gnupg",
    desc = "Transparent editing of GnuPG encrypted files",
  },

  --- @section plugins-vim-snippets
  {
    "honza/vim-snippets",
    event = "InsertEnter",
    config = function()
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
    desc = "SnipMate snippet collection (honza)",
  },

  --- @section plugins-tabular
  {
    "godlygeek/tabular",
    desc = "Text alignment and formatting",
  },

  --- @section plugins-nrrwrgn
  { "chrisbra/NrrwRgn", desc = "Narrow region: edit a selection in a separate buffer" },

  --- @section plugins-nvim-surround
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
    desc = "Surround text objects (parentheses, quotes, tags, etc.)",
  },

  --- @section plugins-auto-session
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        -- Only restore/save sessions manually, not automatically
        auto_session_create_enabled = false,
      })
    end,
    desc = "Session management (manual mode)",
  },
}
