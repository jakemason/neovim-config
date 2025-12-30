-- ============================================================================
-- Neovim config (lazy.nvim) - modernized from your init.vim
-- Target: Neovim v0.12.0-dev
-- Parity: preserve prior behavior, mappings, and workflows.
-- ============================================================================

-- IMPORTANT: When  in doubt, make sure to run these two commands before anything else:
-- :Lazy sync
-- :TSUpdate all

-- Your original init.vim relied on default <leader> (backslash).
-- Set it explicitly so behavior is stable everywhere.
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader><leader>b", function()
  require("jm.athena").run([[E:\Athena\utils\compile_commands\build_editor_debug.cmd]])
end, { silent = true })

-- Windows-only: configure sqlite.lua native library with diagnostics
if vim.fn.has("win32") == 1 and vim.fn.has("wsl") == 0 then
  local sqlite_dll = [[D:\Tools\sqlite\sqlite3.dll]]

  if vim.fn.filereadable(sqlite_dll) == 1 then
    vim.g.sqlite_clib_path = sqlite_dll
  else
    -- Defer notification so it doesn't interrupt startup
    vim.schedule(function()
      vim.notify(
        ("sqlite3.dll not found at:\n%s\n\nTelescope smart_history will be disabled."):format(sqlite_dll),
        vim.log.levels.WARN,
        { title = "sqlite.lua (Windows)" }
      )
    end)
  end
end

-- Core editor behavior (options, globals, etc.)
require("jm.options")

-- Core keymaps that should exist regardless of plugin load timing
require("jm.keymaps")

-- Autocommands, user commands, helper functions
require("jm.autocmds")

-- Plugins (lazy.nvim)
require("jm.lazy")
