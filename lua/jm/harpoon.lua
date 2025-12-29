-- ============================================================================
-- Harpoon (parity)
-- ============================================================================

local ok_mark, mark = pcall(require, "harpoon.mark")
local ok_ui, ui = pcall(require, "harpoon.ui")
if not ok_mark or not ok_ui then
  return
end

local function mark_file()
  vim.print("Marked file")
  mark.add_file()
end

vim.keymap.set("n", "<leader>m", mark_file)
vim.keymap.set("n", "<leader>[", ui.nav_prev)
vim.keymap.set("n", "<leader>]", ui.nav_next)

vim.keymap.set("n", "<leader>m1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>m2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>m3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>m4", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>m5", function() ui.nav_file(5) end)
vim.keymap.set("n", "<leader>m6", function() ui.nav_file(6) end)
