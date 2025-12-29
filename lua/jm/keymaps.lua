-- ============================================================================
-- Keymaps (parity)
-- ============================================================================

local map = vim.keymap.set

-- vim-test parity
map("n", "<leader>rt", ":TestNearest<CR>", { silent = true })
map("n", "<leader>rT", ":TestFile<CR>", { silent = true })
map("n", "<leader>ra", ":TestSuite<CR>", { silent = true })
map("n", "<leader>rl", ":TestLast<CR>", { silent = true })
map("n", "<leader>rg", ":TestVisit<CR>", { silent = true })

-- bufsurf parity
map("n", "=", "<Plug>(buf-surf-forward)", { silent = true })
map("n", "-", "<Plug>(buf-surf-back)", { silent = true })

-- ToggleTerm parity
map("n", "<leader>t", ":ToggleTerm direction=float<CR>", { silent = true })

-- Clear search highlighting parity
map("n", "<space>", ":noh<CR>", { silent = true })

-- Move by display lines parity
map("n", "j", "gj", { noremap = true })
map("n", "k", "gk", { noremap = true })

-- Clipboard parity
map("v", "<C-c>", '"+y', { noremap = true })
map("n", "<C-v>", '"+p', { noremap = true })

-- Quick edit init.lua parity (was $MYVIMRC)
map("n", "<leader><leader>e", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end, { noremap = true, silent = true })

-- Commentary parity
map("n", "<leader>/", ":Commentary<CR>", { noremap = true, silent = true })
map("v", "<leader>/", ":Commentary<CR>", { noremap = true, silent = true })

-- Open current dir in Windows explorer parity
map("n", "<leader>o", ":silent !explorer.exe .<CR>", { noremap = true, silent = true })

-- NERDTree parity
map("n", "<leader><leader>x", ":NERDTreeFind %<CR>", { noremap = true, silent = true })

-- Toggle listchars parity
map("n", "<leader>l", ":set list!<CR>", { noremap = true, silent = true })

-- Ouroboros parity
map("n", "<C-e>", ":Ouroboros<CR>", { noremap = true, silent = true })

-- Visual-mode replace helper parity
map("v", "<C-r>", [["hy:%s#<C-r>h##g<left><left>]], { noremap = true })

-- Copilot parity (Ctrl + / accept)
vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap("i", "<C-_>", 'copilot#Accept("<CR>")', { expr = true, silent = true, noremap = true })
