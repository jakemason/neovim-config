" Neovim plugin installation, powered by vim-plug
call plug#begin()

Plug 'ray-x/lsp_signature.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'NLKNguyen/papercolor-theme'
Plug 'kevinhwang91/nvim-bqf'
Plug 'ahmedkhalf/project.nvim'
Plug 'vimwiki/vimwiki'
Plug 'rhysd/vim-clang-format'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' , { 'commit' : '3f45d64e9c47ad9eef273ddab65790a84cced30b' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

call plug#end()

"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath

let g:neovide_cursor_animation_length=0.0
let g:neovide_cursor_trail_length=0.10
" let g:neovide_fullscreen=1
let g:neovide_remember_window_size=1
let g:neovide_refresh_rate=140

set clipboard^=unnamed,unnamedplus

set mouse=a
"nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
"inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
"vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>

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

" TELESCOPE CONFIG
lua << EOF
local previewers = require("telescope.previewers")

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 100000 then
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
            "%.swp",
            "%.so",
            "%.dll",
            "%.png",
            "%.a",
            "%.la"
        }
    },
    extensions = {
        fzf
    }
}

require("project_nvim").setup {}
EOF

" Find files using Telescope command-line sugar.
nnoremap <c-f> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fp <cmd>Telescope projects<cr>


" PROJECT NVIM CONFIG
lua << EOF
EOF


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

lua << EOF
  require('telescope').load_extension('projects')
EOF

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <C-k> :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

set visualbell
" Turn on syntax highlighting
syntax on


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

set statusline+=%#warningmsg#
set statusline+=%*

" For plugins to load correctly
" filetype plugin indent on

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
set textwidth=120
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

" Always show status bar
set laststatus=2

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

colorscheme everforest
set background=dark

" Custom word highlighting
augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|STUDY|NOTE|UPDATE|TODO|OPTIMIZE|PERFORMANCE|BUG|HARDCODED|KILL|IMPORTANT|REZ)/ containedin=.*Comment.*
augroup END
hi def link MyTodo Todo


" Custom command to load our error log file and open cw
:command Err cgetfile err.log | cw


" Position the (global) quickfix window at the very bottom of the window
" (useful for making sure that it appears underneath splits)
"
" NOTE: Using a check here to make sure that window-specific location-lists
" aren't effected, as they use the same `FileType` as quickfix-lists.
autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif

" Clear last search highlighting when hitting space
map <space> :noh<cr>

" Set font
set guifont=JetBrainsMono\ NF:h15

" Automatically reload config files when updated
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $MYVIMRC"


" *******************************************************************
"                         START C / C++ CONFIG       
" *******************************************************************

" TODO: Unfortunately, this often just doesn't work for some reason? 
 map <C-e> :CocCommand clangd.switchSourceHeader<CR>
" clang setup
let g:clang_format#code_style = 'llvm'
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Allman",
            \ "AlignConsecutiveAssignments" : "true",
            \ "AlignTrailingComments" : "true",
            \ "IndentCaseLabels" : "true",
            \ "PointerAlignment" : "true",
            \ "BinPackArguments" : "false",
            \ "ColumnLimit" : 120,
            \ "NamespaceIndentation" : "All"}

autocmd FileType c ClangFormatAutoEnable
autocmd FileType cpp ClangFormatAutoEnable

" *******************************************************************
"                         END C / C++ CONFIG       
" *******************************************************************

