-- @section vim-options
-- Override LazyVim default vim options to match your previous LunarVim config.
-- LazyVim defaults already include: shiftwidth=2, tabstop=2, number=true, list=true,
-- relativenumber=true.

-- Relativenumber: Your LunarVim config explicitly disabled it.
-- LazyVim defaults to true; this overrides it back to false.
vim.opt.relativenumber = false

-- Grepprg: Your LunarVim config used `ag --vimgrep`.
-- LazyVim defaults to `rg --vimgrep`. Uncomment below to switch to `ag`:
-- vim.opt.grepprg = "ag --vimgrep"
