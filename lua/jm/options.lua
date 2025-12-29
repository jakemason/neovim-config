-- ============================================================================
-- Options / globals / Vimscript compatibility settings
-- ============================================================================

local opt = vim.opt

-- Speed / UX
vim.o.updatetime = 250 -- parity: CursorHold + diagnostics feel snappy
opt.swapfile = false
opt.hidden = true
opt.ttyfast = true

-- Spell (parity)
opt.spell = true

-- Searching
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

-- Clipboard
opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.ruler = true

-- Wrapping / formatting
opt.wrap = true
opt.linebreak = true
opt.textwidth = 100
opt.formatoptions = "tcqrn1"

-- Indentation (parity: 2 spaces)
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.shiftround = false

-- Display
opt.cursorline = true
opt.signcolumn = "yes"
opt.mouse = "a"
opt.laststatus = 2
opt.showtabline = 0
opt.showmode = true
opt.showcmd = true
opt.visualbell = true
opt.belloff = "all"

-- Encoding
opt.encoding = "utf-8"
opt.fileformat = "unix"

-- netrw parity
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = "noma nomod nu nowrap ro nobl"

-- Tag matching parity
vim.cmd("runtime! macros/matchit.vim")

-- Kanagawa terminal palette (parity for LazyGit / ToggleTerm)
vim.g.terminal_color_0  = "#000000"
vim.g.terminal_color_8  = "#808080"
vim.g.terminal_color_1  = "#c34043"
vim.g.terminal_color_9  = "#e82424"
vim.g.terminal_color_2  = "#98bb6c"
vim.g.terminal_color_10 = "#98bb6c"
vim.g.terminal_color_3  = "#dca561"
vim.g.terminal_color_11 = "#e6c384"
vim.g.terminal_color_4  = "#658593"
vim.g.terminal_color_12 = "#7fb4ca"
vim.g.terminal_color_5  = "#938aa9"
vim.g.terminal_color_13 = "#957fb8"
vim.g.terminal_color_6  = "#7aa89f"
vim.g.terminal_color_14 = "#7e9cd8"
vim.g.terminal_color_7  = "#c0c0c0"
vim.g.terminal_color_15 = "#f2f2f2"

-- Closetag parity
vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.twig"

-- todo-lists parity
vim.g.VimTodoListsDatesEnabled = 1
vim.g.VimTodoListsDatesFormat = "%d %b, %Y"

-- git blame parity
vim.g.gitblame_date_format = "%b %Y"

-- Gutentags exclude parity
vim.g.gutentags_ctags_exclude = {
  ".git", ".svn", ".hg", "bundle", "min", "vendor",
  "*.min.*", "*.min", "*.map", "*.swp", "*.bak", "*.pyc",
  "*.class", "*.sln", "*.Master", "*.csproj", "user",
  "*.cache", "*.dll", "*.pdb", "tags", "cscope.*", "*.tar.*",
}

-- NERDTree parity
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeNodeDelimiter = "\u{00a0}"
vim.g.NERDTreeFileExtensionHighlightFullName = 1
vim.g.NERDTreeExactMatchHighlightFullName = 1
vim.g.NERDTreePatternMatchHighlightFullName = 1
vim.g.NERDTreeWinSize = 25

-- Hexokinase parity
vim.g.Hexokinase_highlighters = { "virtual" }

-- clang-format parity
vim.g["clang_format#detect_style_file"] = 1

-- Neovide parity
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.0
  vim.g.neovide_cursor_trail_length = 0.10
  vim.g.neovide_remember_window_size = 1
  vim.g.neovide_refresh_rate = 140
end
