-- ============================================================================
-- ToggleTerm + LazyGit terminal integration (parity)
-- ============================================================================

local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  return
end

-- On Mac/WSL: default shell. On Windows-native: force powershell.
if vim.fn.has("macunix") == 1 or vim.fn.has("wsl") == 1 then
  toggleterm.setup()
else
  toggleterm.setup({ shell = "powershell" })
end

-- Terminal-mode escape (parity)
_G.set_terminal_keymaps = function()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
end

-- LazyGit (parity): uses keychain on unix, plain lazygit on windows
local cmd = "eval `keychain --eval --agents ssh id_rsa 2>/dev/null` && lazygit"
if (vim.fn.has("win32") == 1) and (vim.fn.has("unix") == 0) then
  cmd = "lazygit"
end

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = cmd,
  dir = "git_dir",
  direction = "float",
  float_opts = { border = "double" },
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  on_close = function()
    vim.cmd("startinsert!")
  end,
})

function _G._lazygit_toggle()
  lazygit.dir = vim.fn.getcwd()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader><leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
