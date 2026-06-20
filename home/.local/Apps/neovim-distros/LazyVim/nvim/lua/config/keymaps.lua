-- @section keymaps
-- Custom keymaps migrated from LunarVim config.
-- LazyVim already defines many keymaps (e.g. <C-s> for save, <S-h/l> for buffer prev/next,
-- <leader>bd for delete buffer). Only keymaps that add to or differ from LazyVim defaults
-- are listed here. Grouped by function with @section markers.

local map = vim.keymap.set

--- @section keymaps-buffers
-- Meta+number: Jump to specific buffer (via BufferLine)
-- LazyVim provides <leader>bj for BufferLinePick (interactive pick).
-- These direct-access keys are preserved from your LunarVim config.
for i = 1, 9 do
  map("n", "<M-" .. i .. ">", function()
    vim.cmd("BufferLineGoToBuffer " .. i)
  end, { desc = "Go to buffer " .. i })
end

--- @section keymaps-picker
-- <C-p>: Quick file find (Snacks picker replaces your Telescope "fd" picker)
map("n", "<C-p>", function()
  LazyVim.pick("files")()
end, { desc = "Find Files" })

--- @section keymaps-external
-- Launch external tools from Neovim
map("n", "<Leader><Leader>t", ":!konsole&<CR>", { desc = "Open Konsole terminal" })
map("n", "<Leader><Leader>g", ":!git gui &<CR>", { desc = "Open Git GUI" })

--- @section keymaps-file
-- File-level operations
map("n", "<M-r>", ":e!<CR>", { desc = "Reload current file (discard changes)" })
map("n", "<M-q>", function()
  Snacks.bufdelete()
end, { desc = "Delete current buffer (preserves window layout)" })
map("n", "<M-Q>", ":bd!<CR>", { desc = "Force delete buffer and close window" })

--- @section keymaps-visual
-- Visual mode operations
map("v", "<C-h>", '"fy:%s#<C-r>f#', { desc = "Replace all occurrences of selected text" })
map("v", "<C-f>", '"fy/<C-r>f', { desc = "Search for selected word" })

--- @section keymaps-insert
-- Insert mode helpers
map("i", "<C-CR>", "<ESC>A;", { desc = "Append semicolon at end of line" })
map("i", "<C-E>", "<plug>(emmet-expand-abbr)", { desc = "Expand Emmet abbreviation" })

--- @section keymaps-window
-- Window navigation with Alt+arrows (preserved from LunarVim)
-- LazyVim defaults have <C-h/j/k/l> for window nav.
-- These Alt+arrow mappings give you an alternative.
map("n", "<M-Up>", "<C-W>k", { desc = "Move to window above" })
map("n", "<M-Down>", "<C-W>j", { desc = "Move to window below" })
map("n", "<M-Right>", "<C-W>l", { desc = "Move to window right" })
map("n", "<M-Left>", "<C-W>h", { desc = "Move to window left" })

--- @section keymaps-terminal
-- Terminal mode keymaps for window navigation and tab switching
map("t", "<C-PageUp>", "<C-\\><C-N><C-PageUp>", { desc = "Terminal: Previous tab" })
map("t", "<C-PageDown>", "<C-\\><C-N><C-PageDown>", { desc = "Terminal: Next tab" })
map("t", "<M-Up>", "<C-\\><C-N><C-W>k", { desc = "Terminal: Window up" })
map("t", "<M-Down>", "<C-\\><C-N><C-W>j", { desc = "Terminal: Window down" })
map("t", "<M-Right>", "<C-\\><C-N><C-W>l", { desc = "Terminal: Window right" })
map("t", "<M-Left>", "<C-\\><C-N><C-W>h", { desc = "Terminal: Window left" })

--- @section keymaps-buffer-switch
-- Buffer switching keys preserved from LunarVim.
-- NOTE: <C-j> and <C-k> conflict with LazyVim's default window navigation
-- (<C-j>=window down, <C-k>=window up). Since you use <M-Arrows> for windows,
-- these override <C-j/k> to buffer navigation instead.
map("n", "<C-PageUp>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "<C-PageDown>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<C-S-PageUp>", ":BufferLineMovePrev<CR>", { desc = "Move buffer left" })
map("n", "<C-S-PageDown>", ":BufferLineMoveNext<CR>", { desc = "Move buffer right" })
map("n", "<C-j>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "<C-k>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<C-S-j>", ":BufferLineMovePrev<CR>", { desc = "Move buffer left" })
map("n", "<C-S-k>", ":BufferLineMoveNext<CR>", { desc = "Move buffer right" })

--- @section keymaps-tab
map("n", "<C-S-T>", ":tabedit<CR>", { desc = "Open new tab" })

--- @section keymaps-dap
-- Quick DAP access keys (dap.core extra provides <leader>d prefix mappings)
-- These F-keys provide direct access to the most common debugging actions.
map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "DAP: Continue / Start debugging" })
map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "DAP: Step over" })
map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "DAP: Step into" })
map("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "DAP: Step out" })
