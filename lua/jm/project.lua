-- ============================================================================
-- project.nvim + Obsession session automation (parity)
-- ============================================================================

local function close_session()
  if vim.g.this_obsession then
    pcall(vim.cmd, "silent! Obsess")
  end
end

local function load_session()
  local project_directory = vim.fn.getcwd()
  pcall(vim.cmd, "silent! %bwipeout!")
  pcall(vim.cmd, "cd " .. project_directory)

  if vim.fn.filereadable("Session.vim") ~= 0 then
    vim.cmd("new | setlocal bt=nofile bh=wipe nobl noswapfile nu")
    pcall(vim.cmd, "silent! source Session.vim")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "m", true)
  end
end

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

local ok, project = pcall(require, "project_nvim")
if not ok then
  return
end

project.setup({
  manual_mode = false,
  detection_methods = { "pattern" },
  patterns = { ".git", ".svn" },
  after_project_selection_callback = load_session,
  before_project_selection_callback = close_session,
})
