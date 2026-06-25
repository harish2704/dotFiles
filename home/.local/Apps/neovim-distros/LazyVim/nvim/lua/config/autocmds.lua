-- @section commands
-- Custom user commands migrated from LunarVim's config.lua vim.cmd block

--- @section commands-grep
-- Gr: Search with grep and show results in quickfix list
vim.api.nvim_create_user_command("Gr", function(input)
	vim.cmd("silent execute 'grep! " .. input.args .. " | copen'")
end, { nargs = "+", desc = "Grep and open quickfix list" })

-- Grc: Raw grep command (no quickfix auto-open)
vim.api.nvim_create_user_command("Grc", function(input)
	vim.cmd("grep " .. input.args)
end, { nargs = "*", desc = "Run grep without quickfix" })

--- @section commands-file
-- Header: Add file header via external script
vim.api.nvim_create_user_command("Header", function()
	vim.cmd("0r!file-header '%'")
end, { desc = "Add file header from external file-header script" })

-- Termw: Open konsole terminal emulator
vim.api.nvim_create_user_command("Termw", function()
	vim.cmd("!konsole -e bash-session &")
end, { desc = "Open konsole terminal" })

-- Term: Open embedded terminal in a horizontal split
vim.api.nvim_create_user_command("Term", function()
	vim.cmd("sp | term")
end, { desc = "Open terminal in split window" })

-- EditSnippet: Open LuaSnip snippet files for editing
vim.api.nvim_create_user_command("EditSnippet", function()
	require("luasnip.loaders").edit_snippet_files()
end, { desc = "Edit LuaSnip snippet files" })

-- Cwd: Change working directory to current file's directory
vim.api.nvim_create_user_command("Cwd", function()
	vim.cmd("cd %:p:h")
end, { desc = "Change directory to current file" })

-- Tcd: Change tab-local working directory to current file's directory
vim.api.nvim_create_user_command("Tcd", function()
	vim.cmd(":tcd %:p:h")
end, { desc = "Change tab directory to current file" })

-- Reload: Reload all buffers from disk
vim.api.nvim_create_user_command("Reload", function()
	vim.cmd("bufdo execute 'checktime . bufnr('%')'")
end, { desc = "Reload all buffers" })

-- Rm: Delete current file from disk and close buffer
vim.api.nvim_create_user_command("Rm", function()
	vim.cmd("!rm % | bd")
end, { desc = "Delete file and close buffer" })

-- CopyFilename: Copy current file path to system clipboard
vim.api.nvim_create_user_command("CopyFilename", function()
	vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = "Copy file path to clipboard" })

-- Code: Open current file in VS Code at current line
vim.api.nvim_create_user_command("Code", function()
	vim.cmd("!code ./ -g %:" .. (vim.fn.line(".") + 1))
end, { desc = "Open in VS Code at current line" })

-- <C-G>: Live grep word under cursor via Snacks picker
vim.keymap.set("n", "<C-G>", function()
	LazyVim.pick("live_grep", { default_text = vim.fn.expand("<cword>") })()
end, { desc = "Snacks grep word under cursor" })

-- @section autocmds-filetype
-- Caddyfile: Set filetype for Caddyfile (any path, any name containing "Caddyfile")
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*Caddyfile",
	callback = function()
		vim.bo.filetype = "caddy"
	end,
	desc = "Detect Caddyfile filetype",
})

-- @section autocmds-emmet
-- Emmet: Enable Emmet for web development filetypes (migrated from LunarVim)
-- Disabled by default for all filetypes; enabled only for these specific filetypes.
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "html", "css", "vue", "jsx", "php", "javascriptreact" },
--   callback = function()
--     vim.cmd("EmmetInstall")
--   end,
--   desc = "Enable Emmet for web filetypes",
-- })

-- @section config-grepprg
-- Set grep program to `ag` (preserved from LunarVim)
-- LazyVim defaults to `rg --vimgrep`. This overrides it.
vim.opt.grepprg = "ag --vimgrep"
