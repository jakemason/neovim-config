"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   VIM-PLUG INSTALLS                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For plugins to load correctly
filetype plugin indent on

call plug#begin()

Plug 'nvim-lua/plenary.nvim' " required by a ton of stuff - just dev utils
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kevinhwang91/nvim-bqf'
Plug 'nvim-lualine/lualine.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'vimwiki/vimwiki'
Plug 'rhysd/vim-clang-format'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'kdheepak/lazygit.nvim'

" LSP support, autocompletion via nvim-cmp
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'p00f/clangd_extensions.nvim'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'onsails/lspkind.nvim'

" Telescope, searching projects, fzf for speed, and session management
Plug 'ahmedkhalf/project.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Plug 'rmagatti/auto-session'
" Plug 'rmagatti/session-lens'
Plug 'tpope/vim-obsession'
Plug 'ludovicchabant/vim-gutentags'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'jakemason/ouroboros' 
call plug#end()

let g:ouroboros_debug=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     LSP CONFIG                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Diagnostic keymaps
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

  local cmp = require('cmp')
  local lspkind = require('lspkind')

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  
  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            require("clangd_extensions.cmp_scores"),
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    window = {
       completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol', -- show only symbol annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
  
        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function (entry, vim_item)
          return vim_item
        end
      })
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4), 
      ['<C-Space>'] = cmp.mapping.complete(),
      --["<C-Space>"] = cmp.mapping(cmp.mapping.complete({
      --  reason = cmp.ContextReason.Auto,
      --}), {"i", "c"}),
      ['<C-e>'] = cmp.mapping.abort(),
      --['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      --['<S-Tab>'] = cmp.mapping.select_prev_item(),
      --['<Tab>'] = cmp.mapping.select_next_item(),


      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },

    -- Use Tab and Shift-Tab to browse through the suggestions.
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
  
      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),
    }),

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'vsnip' }, -- For vsnip users.
    }, 
    {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })


  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  require("nvim-lsp-installer").setup {
    automatic_installation = true
  }
  
  local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', '<leader>df', vim.lsp.buf.code_action, bufopts) -- diagnostic fix
    vim.keymap.set({"n", "v"}, "K", vim.lsp.buf.hover, { buffer = 0 }) -- show documentation
  end

  require("clangd_extensions").setup{
    server = { 
        capabilities = capabilities,
        on_attach = on_attach,
        autostart = true,
    },
  }

  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   NEOVIDE CONFIG                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neovide_cursor_animation_length=0.0
let g:neovide_cursor_trail_length=0.10
let g:neovide_remember_window_size=1
let g:neovide_refresh_rate=140


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   SHELL CONFIG                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" !!!DO NOT USE THIS!!! -- unfortunately, switching to powershell here breaks gutentags
" + clangformat :( Essentially, anything that runs terminal commands gets fucked :(

" shell config -- enable use of powershell
"let &shell = has('win32') ? 'powershell' : 'pwsh'
"let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
"let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
"let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
"set shellquote= shellxquote=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   VIM WIKI CONFIG                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua<<EOF
local config_directory = vim.fn.stdpath('config')
vim.g.vimwiki_list = {{ path = config_directory .. '/wiki' }}
EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   GITSIGNS CONFIG                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require('gitsigns').setup();
EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   TELESCOPE CONFIG                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
local previewers = require("telescope.previewers")
local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 100000 then -- make sure we don't freeze trying to preview huge files
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

require("telescope").setup{ 
    defaults = {
        buffer_previewer_maker = new_maker,
        file_ignore_patterns = {
            "node_modules", 
            ".cache",
            ".git\\",
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
            "%.a",
            "%.lib",
            "%.la"
        }
    },
    extensions = {
        fzf
    }
}

-- Session onformation
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
require("project_nvim").setup {}
--require("auto-session").setup {
--    auto_session_enable_last_session = true,
--}

require('telescope').load_extension("projects")
-- require("telescope").load_extension("session-lens")
EOF

" Find files using Telescope command-line sugar.
nnoremap <c-f> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fp <cmd>Telescope projects<cr>
nnoremap <leader>fs <cmd>SearchSession<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  TREESITTER CONFIG                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
}
EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  STATUSLINE CONFIG                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show status bar
set laststatus=2

set statusline+=%#warningmsg#
set statusline+=%*


lua << EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'os.date("%I:%M", os.time())'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   LAZYGIT CONFIG                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" setup mapping to call :LazyGit
nnoremap <silent> <leader>gg :LazyGit<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      VIM CONFIG                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I know this is basically blasphemy in the Vim world, but I can count
" on one hand the number of times a swapfile has saved me a minor amount
" of effort, and I can't count the number of times it's slowed down my
" opening of a file. Sluggishness....begone!
set noswapfile

set spell


" Ignore case when searching for files with ctrlp, or in files themselves
set ignorecase

" Forces word wrapping to break on words, rather than on characters
set linebreak

set cursorline
set nocompatible
set fileformat=unix

" vim hardcodes background color erase even if the terminfo file does
" not contain bce (not to mention that libvte based terminals
" incorrectly contain bce in their terminfo files). 
" This causes incorrect background rendering when using
" a color theme with a background color.
let &t_ut=''

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes


set clipboard^=unnamed,unnamedplus
set showtabline=0
set mouse=a
set syntax=on


" Security
set modelines=0

" turn hybrid line numbers on
set number relativenumber

" Show file stats
set ruler

" Blink cursor on error instead of beeping 
set visualbell

" Encoding
set encoding=utf-8

" White space
set wrap

set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

"Column width
set textwidth=100
set colorcolumn=100 " visualize the column

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allows use of Ctrl-C, Ctrl-V to copy/paste from OS clipboard
vnoremap <C-c> "+y
nnoremap <C-v> "+p

" My preferred shortcut to enter insert mode
nnoremap a i

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search
" Clear last search highlighting when hitting space
map <space> :noh<cr>

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set termguicolors
set t_Co=256

set background=dark
colorscheme everforest

" Custom word highlighting
augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|STUDY|NOTE|UPDATE|TODO|OPTIMIZE|PERFORMANCE|BUG|HARDCODED|KILL|IMPORTANT|REZ)/ containedin=.*Comment.*
augroup END
highlight! MyTodo guibg='#404C54'
highlight! cTodo guibg='#404C54'
" hi def link MyTodo Todo

" Custom command to load our error log file and open cw
:command Err cgetfile err.log | cw

" Position the (global) quickfix window at the very bottom of the window
" (useful for making sure that it appears underneath splits)
"
" NOTE: Using a check here to make sure that window-specific location-lists
" aren't effected, as they use the same `FileType` as quickfix-lists.
autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif

" Set font
set guifont=JetBrainsMono\ NF:h15

" Automatically reload config files when updated
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $MYVIMRC"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    C/C++ CONFIG                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" switch between header and implementation
autocmd! Filetype c,cpp map<buffer> <C-e> :Ouroboros<CR>

" clang setup
let g:clang_format#code_style = 'llvm'
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "c++14",
            \ "BreakBeforeBraces" : "Allman",
            \ "AlignConsecutiveAssignments" : "true",
            \ "AlignTrailingComments" : "true",
            \ "IndentCaseLabels" : "true",
            \ "PointerAlignment" : "true",
            \ "BinPackArguments" : "false",
            \ "ColumnLimit" : 100,
            \ "NamespaceIndentation" : "All"}

autocmd FileType c ClangFormatAutoEnable
autocmd FileType cpp ClangFormatAutoEnable
