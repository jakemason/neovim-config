" Neovim plugin installation, powered by vim-plug
call plug#begin()

Plug 'ray-x/lsp_signature.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'NLKNguyen/papercolor-theme'
Plug 'kevinhwang91/nvim-bqf'
Plug 'nvim-lualine/lualine.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'ahmedkhalf/project.nvim'
Plug 'vimwiki/vimwiki'
Plug 'rhysd/vim-clang-format'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'nvim-lua/plenary.nvim'
Plug 'kdheepak/lazygit.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'jakemason/ouroboros' 

call plug#end()

"let g:gutentags_trace = 1
let g:ouroboros_debug=0
let g:neovide_cursor_animation_length=0.0
let g:neovide_cursor_trail_length=0.10
let g:neovide_remember_window_size=1
let g:neovide_refresh_rate=140
set clipboard^=unnamed,unnamedplus

set showtabline=0
" set completeopt=menu,preview
set mouse=a
" shell config -- enable use of powershell
" DO NOT USE THIS -- unfortunately, switching to powershell here breaks gutentags + clangformat
" Essentially, anything that runs terminal commands gets fucked :(
"let &shell = has('win32') ? 'powershell' : 'pwsh'
"let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
"let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
"let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
"set shellquote= shellxquote=


function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Tab key allows us to skip to the next parameter in an autocomplete
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

let bufferline = get(g:, 'bufferline', {})
let bufferline.icons = "buffer_number_with_icon"

lua << EOF
require('gitsigns').setup();
EOF


" TELESCOPE CONFIG
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

require("project_nvim").setup {}
require('telescope').load_extension('projects')
EOF

" Find files using Telescope command-line sugar.
nnoremap <c-f> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fp <cmd>Telescope projects<cr>

" TREESITTER CONFIG
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

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>
nnoremap <silent> <C-k> :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)



" setup mapping to call :LazyGit
nnoremap <silent> <leader>gg :LazyGit<CR>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

set visualbell
" Turn on syntax highlighting
syntax on

" Allows use of Ctrl-C, Ctrl-V to copy/paste from OS clipboard
vnoremap <C-c> "+y
nnoremap <C-v> "+p

set re=1

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
" Helps force plugins to load correctly when it is turned back on below
" filetype off

" vim hardcodes background color erase even if the terminfo file does
" not contain bce (not to mention that libvte based terminals
" incorrectly contain bce in their terminfo files). 
" This causes incorrect background rendering when using
" a color theme with a background color.
let &t_ut=''

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               START STATUSLINE CONFIG               "
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
"                 END STATUSLINE CONFIG               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""



" For plugins to load correctly
filetype plugin indent on

" Security
set modelines=0

" Show absolute line numbers
" set number

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
set textwidth=100
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

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

" *******************************************************************
"                         START C / C++ CONFIG       
" *******************************************************************

" switch between header and implementation
autocmd! Filetype c,cpp map<buffer> <C-e> :Ouroboros<CR>
" map <C-e> :Ouroboros<CR>
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

" *******************************************************************
"                         END C / C++ CONFIG       
" *******************************************************************

