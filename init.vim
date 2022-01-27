" Neovim plugin installation, powered by vim-plug
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'NLKNguyen/papercolor-theme'

call plug#end()

"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath

set clipboard^=unnamed,unnamedplus

set mouse=a
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


lua <<EOF
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
nnoremap <silent> K :call <SID>show_documentation()<CR>
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


"" ORIGINAL VIMRC FOLLOWS:

set visualbell
" Turn on syntax highlighting
" syntax on

map <C-e> :CocCommand clangd.switchSourceHeader<CR>

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
filetype off

" Load pathogen plugins
execute pathogen#infect()

" vim hardcodes background color erase even if the terminfo file does
" not contain bce (not to mention that libvte based terminals
" incorrectly contain bce in their terminfo files). 
" This causes incorrect background rendering when using
" a color theme with a background color.
let &t_ut=''

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

set statusline+=%#warningmsg#
set statusline+=%*

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

" Status bar
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

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

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
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment
" let g:gruvbox_guisp_fallback="bg"
colorscheme sitruuna
"let g:airline_theme='gruvbox'

"let g:materialmonokai_italic=1
"let g:materialmonokai_subtle_spell=1
set background=light

" CTRLP FuzzyFinder ignore list
set wildignore+=*/EASTL/*
set wildignore+=*.o
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
" remap CTRLP FuzzyFind command
let g:ctrlp_map = '<c-f>'
" file and directory types to ignore in CTRLP find results
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|vs)$',
  \ 'file': '\v\.(exe|so|dll|pdb|lib|ilk|exp|obj|lastbuildstate|vcxproj|vcxproj.filters|sln|o|cmake|tlog|a|la)$',
  \ }

" We get this weird 'black line' display bug..let's see if this fixes it
au BufEnter * :set background=light

" How many lines should be searched for context
let g:hasksyn_indent_search_backward = 100
 
" Should we try to de-indent after a return
let g:hasksyn_dedent_after_return = 1
 
" Should we try to de-indent after a catchall case in a case .. of
let g:hasksyn_dedent_after_catchall_case = 1

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

" vimgrep shortcut search for the athena project
command -nargs=1 F vimgrep /<args>/g G:/athena/game/**/*.cpp G:/athena/platform/**/*.cpp G:/athena/game/**/*.hpp G:/athena/platform/**/*.hpp | copen

" Binds Ctrl-R to open the word under the cursor for replacement
nnoremap <c-o> :%s/\<<C-r><C-w>\>//g<Left><Left>

function ProjectReplace(term)
    execute "vimgrep /". a:term ."/g game/**/*.cpp platform/**/*.cpp game/**/*.hpp platform/**/*.hpp | copen"
    call feedkeys(":cdo %s/\\<".a:term."\\>/")
endfunction

nnoremap <c-p> :call ProjectReplace("<C-r><C-w>")<CR>


" Clear last search highlighting when hitting space
map <space> :noh<cr>
" For some reason I have to do "syntax on" after RainbowParentheses to get them
" to apply. Really need to investigate why this is needed.
" BUG: If I uncomment this below, my custom FIXME, BUG, NOTE highlighting stops
" working :/
" autocmd BufWritePost,BufWrite,VimEnter,BufReadPre,BufWinEnter,FocusGained,WinEnter * RainbowParentheses
" autocmd BufWritePost,BufWrite,VimEnter,BufReadPre,BufWinEnter,FocusGained,WinEnter * syntax on


" Automatically wipe a buffer when we leave it. While this is pretty hardcore,
" I think it'll be worth it in the end. For example, this prevents CtrlP from
" filling buffer list with every open file which brings vim's speed to a crawl.
" autocmd BufLeave * :bw

