-- @section dap
-- DAP (Debug Adapter Protocol) configuration.
-- Core DAP support comes from the `lazyvim.plugins.extras.dap.core` extra
-- (imported in init.lua), which provides nvim-dap, nvim-dap-ui, and
-- <leader>d keybindings.
--
-- This file adds:
-- 1. F-key shortcuts for common debug actions
-- 2. PHP debug adapter configuration (migrated from LunarVim)

return {
  {
    "mfussenegger/nvim-dap",
    -- @section dap-keymaps
    -- F-key mappings for quick DAP access.
    -- The dap.core extra already provides <leader>d{letter} bindings;
    -- these F-keys are additional shortcuts preserved from your LunarVim config.
    keys = {
      { "<F5>", function()
        require("dap").continue()
      end, desc = "DAP: Continue / Start" },
      { "<F10>", function()
        require("dap").step_over()
      end, desc = "DAP: Step Over" },
      { "<F11>", function()
        require("dap").step_into()
      end, desc = "DAP: Step Into" },
      { "<F12>", function()
        require("dap").step_out()
      end, desc = "DAP: Step Out" },
    },
    -- @section dap-php
    -- PHP debug adapter setup (migrated from LunarVim)
    -- Uses php-debug-adapter installed via Mason.
    -- The adapter listens on port 9003 (Xdebug default).
    init = function()
      LazyVim.on_load("nvim-dap", function()
        local dap = require("dap")
        dap.adapters.php = {
          type = "executable",
          command = "node",
          args = {
            vim.fn.stdpath("data")
              .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js",
          },
        }
        dap.configurations.php = {
          {
            type = "php",
            request = "launch",
            name = "Listen for Xdebug",
            port = 9003,
          },
        }
      end)
    end,
  },
}
