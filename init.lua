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

-- Core editor behavior (options, globals, etc.)
require("jm.options")

-- Core keymaps that should exist regardless of plugin load timing
require("jm.keymaps")

-- Autocommands, user commands, helper functions
require("jm.autocmds")

-- Plugins (lazy.nvim)
require("jm.lazy")
