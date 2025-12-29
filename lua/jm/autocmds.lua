-- ============================================================================
-- Autocommands, user commands, helper functions (parity)
-- ============================================================================

-- Filetype tweaks
vim.api.nvim_create_autocmd("FileType", {
  pattern = "prisma",
  callback = function()
    vim.opt_local.spell = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "todo",
  callback = function()
    vim.opt_local.textwidth = 0
  end,
})

-- Quickfix: dd removes entry (parity)
local function remove_qf_item()
  local curqfidx = vim.fn.line(".") - 1
  local qf = vim.fn.getqflist()
  table.remove(qf, curqfidx + 1)
  vim.fn.setqflist(qf, "r")
  vim.cmd((curqfidx + 1) .. "cfirst")
  vim.cmd("copen")
end

vim.api.nvim_create_user_command("RemoveQFItem", remove_qf_item, {})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "dd", ":RemoveQFItem<CR>", { buffer = true, silent = true })
    local info = vim.fn.getwininfo(vim.fn.win_getid())[1]
    if info and info.loclist ~= 1 then
      vim.cmd("wincmd J")
    end
  end,
})

-- Auto-open/close quickfix + loclist (parity)
vim.api.nvim_create_autocmd("QuickFixCmdPost", { pattern = "[^l]*", command = "nested cwindow" })
vim.api.nvim_create_autocmd("QuickFixCmdPost", { pattern = "l*", command = "nested lwindow" })

-- Neoformat on save (parity)
vim.api.nvim_create_augroup("fmt", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "fmt",
  pattern = "*",
  callback = function()
    pcall(vim.cmd, "silent! undojoin | Neoformat")
  end,
})

-- Alphabetize blocks on save (parity)
local function process_block(start_line, end_line)
  vim.cmd(string.format("%d,%d sort", start_line + 1, end_line - 1))
end

local function faster_alphabetize_selection()
  local start_pattern = "start%-auto%-alphabetize"
  local end_pattern = "end%-auto%-alphabetize"

  local lines = vim.fn.getline(1, "$")
  local in_block = false
  local block_start = 0

  for i, line in ipairs(lines) do
    if line:match(start_pattern) then
      if in_block then
        process_block(block_start, i)
      end
      in_block = true
      block_start = i
    elseif line:match(end_pattern) then
      if in_block then
        process_block(block_start, i)
      end
      in_block = false
    end
  end
end

vim.api.nvim_create_augroup("AlphabetizeOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "AlphabetizeOnSave",
  pattern = "*",
  callback = faster_alphabetize_selection,
})

-- Abbreviations (parity)
vim.cmd([[
iabbrev TODO TODO -- Jake Mason \| (<C-R>=strftime('%x')<CR>)
iabbrev NOTE NOTE -- Jake Mason \| (<C-R>=strftime('%x')<CR>)
iabbrev PERF PERF -- Jake Mason \| (<C-R>=strftime('%x')<CR>)
iabbrev BUG BUG -- Jake Mason \| (<C-R>=strftime('%x')<CR>)
iabbrev FIXME FIXME -- Jake Mason \| (<C-R>=strftime('%x')<CR>)
iabbrev MONITOR MONITOR -- Jake Mason \| (<C-R>=strftime('%x')<CR>)
]])

-- WipeReg (parity)
vim.api.nvim_create_user_command("WipeReg", function()
  for i = 33, 126 do
    pcall(vim.fn.setreg, string.char(i), {})
  end
end, {})

-- Err (parity)
vim.api.nvim_create_user_command("Err", function()
  vim.cmd("cgetfile err.log | cw")
end, {})

-- Duplicate file (parity)
vim.api.nvim_create_user_command("Dup", function(opts)
  local name = opts.args
  if name == "" then
    print("Filename needed")
    return
  end
  local dir = vim.fn.expand("%:h")
  local ext = vim.fn.expand("%:e")
  vim.cmd("saveas " .. dir .. "/" .. name .. "." .. ext)
end, { nargs = 1 })

-- Smart dd (parity)
local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  end
  return "dd"
end
vim.keymap.set("n", "dd", smart_dd, { noremap = true, expr = true })

-- SynStack (parity)
vim.api.nvim_create_user_command("SynStack", function()
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")
  for _, id1 in ipairs(vim.fn.synstack(line, col)) do
    local id2 = vim.fn.synIDtrans(id1)
    local n1 = vim.fn.synIDattr(id1, "name")
    local n2 = vim.fn.synIDattr(id2, "name")
    print(n1 .. " -> " .. n2)
  end
end, {})
vim.keymap.set("n", "<leader>hg", ":SynStack<CR>", { noremap = true, silent = true })

-- TODO highlighting (parity)
vim.cmd([[
augroup vimrc_todo
  au!
  au Syntax * syn match MyTodo /\v<(FIXME|MONITOR|HACK|NOTE|TODO|OPTIMIZE|PERF|STUDY|PERFORMANCE|UPDATE|KILL|IMPORTANT|REZ|BUG)/ containedin=.*Comment,vimCommentTitle,cBlock,cCommentL,Comment
augroup END

highlight! MyTodo guibg='#72638a'
highlight! vimTodo guibg='#72638a'
highlight! cTodo guibg='#72638a'
]])
