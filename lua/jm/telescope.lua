-- ============================================================================
-- Telescope + keymaps + project extension (parity)
-- ============================================================================

local function safe_require(mod)
  local ok, m = pcall(require, mod)
  if not ok then
    vim.notify(("Failed to require %s: %s"):format(mod, m), vim.log.levels.WARN)
    return nil
  end
  return m
end

local telescope = safe_require("telescope")
local previewers = safe_require("telescope.previewers")
if not telescope or not previewers then
  return
end

-- Ensure telescope-smart-history database directory exists (parity)
local db_dir = vim.fn.expand("~/.local/share/nvim/databases/")
if vim.fn.isdirectory(db_dir) == 0 then
  vim.fn.mkdir(db_dir, "p")
end

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  filepath = vim.fn.expand(filepath)
  local uv = vim.uv or vim.loop
  uv.fs_stat(filepath, function(_, stat)
    if not stat then
      return
    end
    if stat.size > 100000 then
      return
    end
    previewers.buffer_previewer_maker(filepath, bufnr, opts)
  end)
end

telescope.setup({
  defaults = {
    buffer_previewer_maker = new_maker,
    file_ignore_patterns = {
      "node_modules",
      ".cache",
      ".git/",
      ".vs",
      "%.pdb",
      "%.obj",
      "%.ilk",
      "%.ttf",
      "%.otf",
      "%.swp",
      "%.so",
      "%.dll",
      "%.png",
      "%.gif",
      "%.a$",
      "%.lib",
      "%.la",
    },
    mappings = {
      i = {
        ["<C-Down>"] = require("telescope.actions").cycle_history_next,
        ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
      },
    },
    history = {
      path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
      limit = 100,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

pcall(telescope.load_extension, "projects")
pcall(telescope.load_extension, "harpoon")
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "smart_history")

-- Visual selection helper (parity)
function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})
  return (text or ""):gsub("\n", "")
end

local builtin = require("telescope.builtin")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<c-f>", builtin.find_files, opts)
map("n", "<leader>fu", builtin.lsp_references, opts)
map("n", "<leader>fg", builtin.live_grep, opts)
-- map("n", "<leader><leader>g", builtin.live_grep, opts)
map("n", "<leader>ff", builtin.git_files, opts)
map("n", "<leader><leader>f", builtin.git_files, opts)
map("n", "<leader>fb", builtin.buffers, opts)
map("n", "<leader>fh", builtin.help_tags, opts)
map("n", "<leader>fp", function()
  telescope.extensions.projects.projects({})
end, opts)
map("n", "<leader>fm", function()
  telescope.extensions.harpoon.marks({})
end, opts)

map("v", "<leader>f", function()
  local text = vim.getVisualSelection()
  builtin.current_buffer_fuzzy_find({ default_text = text })
end, opts)

map("v", "<leader>g", function()
  local text = vim.getVisualSelection()
  builtin.live_grep({ default_text = text })
end, opts)
