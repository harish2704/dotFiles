--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode['<C-p>'] = ":Telescope find_files<CR>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
-- lvim.colorscheme = "lunar"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false


lvim.builtin.lualine.sections.lualine_b = { 'branch', '%f' }


-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

lvim.builtin.luasnip = {
  sources = {
    friendly_snippets = false,
  },
}

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

lvim.lsp.null_ls.setup.timeout_ms = 20000

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    extra_args = { "--print-width", "100" },
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
}
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- Flutter snippets enable
local luasnip = require("luasnip")
luasnip.filetype_extend("dart", { "flutter" })



-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
-- lvim.plugins = {
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

local actions = require("telescope.actions")
lvim.builtin.telescope.pickers.find_files.mappings = {
  i = {
    ['<C-t>'] = actions.smart_send_to_qflist + actions.open_qflist,
  }
}

vim.cmd([[
command! -nargs=+ Gr :silent execute 'grep! -nr "<args>" | copen'
" Raw version of Gr command.
command! -nargs=* Grc grep -nr <args>

" Add file header to current buffer. Depends on https://github.com/harish2704/file-header
command! Header :execute "0r!file-header '%'"

" Open Terminal in split window
command! Termw :execute '!konsole -e bash-session &'
command! Term :execute 'sp | term'

command! EditSnippet :execute 'lua require("luasnip.loaders").edit_snippet_files()'

" Cd to current file's directory
command! Cwd :execute 'cd %:p:h'

" Cd to current file's directory, but limit to current tab
command! Tcd :execute ':tcd %:p:h'

" Reload current buffer
command! Reload :execute "bufdo execute 'checktime . bufnr('%')'"

" Delete current file and close buffer
command! Rm :execute '!rm %' | bd

" Copy current file path to unnamedplus register
command! CopyFilename :let @+=@%

" Open vscode in on current line
command! Code :execute "!code ./ -g %:". ( line('.')+1 )

" For Open a terminal in current directory
nmap <Leader><Leader>t :!xdg-terminal&<CR>
" Open git-gui in current pwd
nmap <Leader><Leader>g :!git gui &<CR>

" <Alt-R> -> Reload current file
nmap <M-r> :e!<CR>

" Alt-q Delete current buffer ( Close file )
nmap <M-q> :BufferKill<CR>

" <Ctrl-Shift-q> force Close buffer
nmap <M-Q> :bd!<CR>

" Select a word and press Ctrl-h to replace all its occurance, even if the word is having special chars
vmap <C-h> "fy:%s#<C-r>f#
" Copy current word to 'f' register, search for that word
vmap <C-f> "fy/<C-r>f

" Ctrl-Enter in insert mode will append ';' to the line and insert a new line
imap <C-CR> <ESC>A;

" Alt + Arrows to Moving cursor to different windows {{{
nmap <M-Up> <C-W>k
nmap <M-Down> <C-W>j
nmap <M-Right> <C-W>l
nmap <M-Left> <C-W>h
" }}}

" For terminal mod {{{
tmap   <C-PageUp>   <C-\><C-n><C-PageUp>
tmap   <C-PageDown> <C-\><C-n><C-PageDown>
tmap   <M-Up>       <C-\><C-n><C-W>k
tmap   <M-Down>     <C-\><C-n><C-W>j
tmap   <M-Right>    <C-\><C-n><C-W>l
tmap   <M-Left>     <C-\><C-n><C-W>h
" }}}

set grepprg=ag\ --nogroup\ --nocolor

nmap <C-/> :Gr <C-R><C-W>

" Ctrl-Shift-T -> Open new tab
nmap <C-S-T> :tabedit<CR>

" Ctrl-S to save file {{{
nmap <C-s> :w<CR>
vmap <C-s> <Esc><c-s>gv
imap <C-s> <Esc><c-s>
nmap <C-PageUp> :BufferLineCyclePrev<CR>
nmap <C-PageDown> :BufferLineCycleNext<CR>
nmap <C-S-PageUp> :BufferLineMovePrev<CR>
nmap <C-S-PageDown> :BufferLineMoveNext<CR>

let g:user_emmet_mode='inv'
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue,jsx,php,javascriptreact EmmetInstall
nmap <C-G> :execute 'Telescope live_grep default_text=' . expand('<cword>')<cr>
]])
-- imap <C-E> <plug>(emmet-expand-abbr)
vim.keymap.set('i', '<C-E>', '<plug>(emmet-expand-abbr)')

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
lvim.builtin.dap.active = true
lvim.builtin.which_key.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 20000 }
  end,
  "Format",
}

local dap = require('dap')
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = {
    '/home/harish/tmp/nvim-configs/lunarvim/share/nvim/mason/packages/php-debug-adapter/extension/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003
  }
}

lvim.plugins = {
  {
    "gpanders/editorconfig.nvim",
  },
  { 'mattn/emmet-vim' },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "turbio/bracey.vim",
    cmd = { "Bracey", "BracyStop", "BraceyReload", "BraceyEval" },
    build = "npm install --prefix server",
    lazy = true,
  },
  {
    "jamessan/vim-gnupg",
    -- lazy = true,
  },
  {
    "honza/vim-snippets",
    lazy = true,
    event = "InsertEnter",
    config = function()
      -- TODO: Implement - custom snippets should go to user's directory. See below
      -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#edit_snippets
      -- require("luasnip.loaders.from_snipmate").lazy_load {
      --   paths = get_runtime_dir() ..  "/site/pack/lazy/opt/vim-snippets/snippets"
      -- }
    end,
    dependencies = {
      "LuaSnip",
    },
  },
  {
    "godlygeek/tabular"
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    'rmagatti/auto-session',
    -- cmd = { 'SaveSession', 'RestoreSession', 'RestoreSessionFromFile', 'DeleteSession', 'Autosession', },
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_create_enabled = false,
      }
    end
  }
}
