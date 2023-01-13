"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   VIM-PLUG INSTALLS                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For plugins to load correctly
filetype plugin indent on

call plug#begin()

Plug 'nvim-lua/plenary.nvim' " required by a ton of stuff - just dev utils
Plug 'jackguo380/vim-lsp-cxx-highlight' " better cxx highlights
Plug 'kyazdani42/nvim-web-devicons' " provides some nice dev icons for various other plugins
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kevinhwang91/nvim-bqf'
Plug 'nvim-lualine/lualine.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'vimwiki/vimwiki', {'branch': 'dev' } " the master branch hasn't been updated since 2020...
Plug 'rhysd/vim-clang-format'
Plug 'Shougo/vimproc.vim', {'do' : 'make'} 
Plug 'ziglang/zig.vim'
" an amazing in-editor git interface - seriously, first time that I've ever preferred
" something over just doing everything via the command line myself.
Plug 'kdheepak/lazygit.nvim'

Plug 'akinsho/toggleterm.nvim'

" LSP support, autocompletion via nvim-cmp
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'p00f/clangd_extensions.nvim'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'onsails/lspkind.nvim'
" Luasnip and cmp support for it
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'windwp/nvim-autopairs'

" Colorscheme
Plug 'rebelot/kanagawa.nvim'
" Easily comment out blocks of code at a time
Plug 'preservim/nerdcommenter'

" Allows quick importing of "use" statements in PHP
Plug 'arnaud-lb/vim-php-namespace'

" Critical for easily moving between quickfix entries ]q, [q and more, etc 
Plug 'tpope/vim-unimpaired'

" For quick commenting out of lines
Plug 'tpope/vim-commentary'

" Allows respecting case during search / replace
Plug 'tpope/vim-abolish'

Plug 'tikhomirov/vim-glsl'

" automatically change matching tag in html
Plug 'AndrewRadev/tagalong.vim'

" jump to where you want to go quickly
Plug 'ggandor/leap.nvim'

" close html tags automatically
Plug 'alvan/vim-closetag' " This bugs me so much during C/C++ work

" PHP formatting
Plug 'stephpy/vim-php-cs-fixer'

" Prettier formatting
" Requires some global npm installs:
" npm install -g prettier
" npm install -g prettier-plugin-twig-melody
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

" Syntax support for css/scss
Plug 'JulesWang/css.vim' 
Plug 'cakebaker/scss-syntax.vim'

" Telescope, searching projects, fzf for speed, and session management
Plug 'jakemason/project.nvim'
" Plug 'ahmedkhalf/project.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Plug 'rmagatti/auto-session'
" Plug 'rmagatti/session-lens'
Plug 'tpope/vim-obsession'
Plug 'ludovicchabant/vim-gutentags'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'jakemason/ouroboros.nvim'

" colorscheme experiments
Plug 'arcticicestudio/nord-vim'
Plug 'cranberry-clockworks/coal.nvim'

Plug 'simrat39/rust-tools.nvim'
call plug#end()

let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.twig'

let g:gutentags_ctags_exclude = [
      \'.git',
      \'.svn',
      \'.hg',
      \'bundle',
      \'min',
      \'vendor',
      \'*.min.*,'
      \'*.map',
      \'*.swp',
      \'*.bak',
      \'*.pyc',
      \'*.class',
      \'*.sln',
      \'*.Master',
      \'*.csproj',
      \'user',
      \'*.cache',
      \'*.dll',
      \'*.pdb',
      \'tags',
      \'cscope.*,'
      \'*.tar.*,']


lua << EOF

require("toggleterm").setup{ shell = 'powershell'}

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

EOF

map <leader>t :ToggleTerm direction=float<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  PRETTIER CONFIG                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:prettier#autoformat = 1 " format on save

" autosave even on files that don't start with @format
let g:prettier#autoformat_require_pragma = 0 

command! -nargs=1 Silent
\   execute 'silent !' . <q-args>
\ | execute 'redraw!'

" So .twig doesn't do autosaving through vim very well. It can be done,
" but every time you run it the cursor position is reset. I tried doing
" some sort of getpos / setpos sequence but something with the fact that
" the file/buffer reloads breaks that sequence. Thus, I just manually save
" these via this command.
"
" TODO: Maybe it's worth running this on something like BufLeave rather than
" on write?
map <leader><leader>p :silent! %!prettier --stdin-filepath %<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     LEAP CONFIG                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('leap').add_default_mappings()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     PHP CONFIG                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua<<EOF
  local config_directory = vim.fn.stdpath('config')
  vim.g.php_cs_fixer_config_file = config_directory .. '.php-cs-fixer.dist.php'
EOF

autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()

let g:php_namespace_sort_after_insert = 1
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    LUASNIP CONFIG                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" See after/plugin/luasnip

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
  local luasnip = require('luasnip')
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
        luasnip.lsp_expand(args.body)
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


      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },

      -- Use Tab and Shift-Tab to browse through the suggestions.
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),

    sources = cmp.config.sources({
      -- This order matters! Higher-up sources appear higher in the completion suggestions
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
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
  -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  require("nvim-lsp-installer").setup {
    automatic_installation = true
  }
  
  local border = {
    {"╭", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╮", "FloatBorder"},
    {"│", "FloatBorder"},
    {"╯", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╰", "FloatBorder"},
    {"│", "FloatBorder"},
  }

  local handlers =  {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
  }

  local on_attach = function(client, bufnr)

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', '<leader>df', vim.lsp.buf.code_action, bufopts) -- diagnostic fix
    vim.keymap.set({"n", "v"}, "K", vim.lsp.buf.hover, { buffer = 0 }) -- show documentation
    -- autoformat any buffer running an LSP
    -- vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
  end


  -- This enables borders for the LSP Info windows and alike
  require('lspconfig.ui.windows').default_options.border = 'rounded'


  local lspconfig = require('lspconfig')

  local servers = {
    "intelephense",
    "psalm",
  	"tsserver",
  	"pyright",
    "sumneko_lua",
  	"eslint",
  	"bashls",
    "emmet_ls",
--  	"yamlls",
  	"jsonls",
  	"cssls",
  	"html",
  	"graphql",
    "gopls",
    "zls",
    "tsserver",
    "vuels",
--  	"tailwindcss",
--    "vimls"
  }

  local server_configs = {
    emmet_ls = {
      filetypes = { 'twig', 'html.twig', 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'php' },
    },
    intelephense = {
      intelephense = {
        stubs = { 
          "bcmath",
          "bz2",
          "calendar",
          "Core",
          "curl",
          "date",
          "dba",
          "dom",
          "enchant",
          "fileinfo",
          "filter",
          "ftp",
          "gd",
          "gettext",
          "hash",
          "iconv",
          "imap",
          "intl",
          "json",
          "ldap",
          "libxml",
          "mbstring",
          "mcrypt",
          "mysql",
          "mysqli",
          "password",
          "pcntl",
          "pcre",
          "PDO",
          "pdo_mysql",
          "Phar",
          "readline",
          "recode",
          "Reflection",
          "regex",
          "session",
          "SimpleXML",
          "soap",
          "sockets",
          "sodium",
          "SPL",
          "standard",
          "superglobals",
          "sysvsem",
          "sysvshm",
          "tokenizer",
          "xml",
          "xdebug",
          "xmlreader",
          "xmlwriter",
          "yaml",
          "zip",
          "zlib",
          "wordpress",
          "woocommerce",
          "acf-pro",
          "wordpress-globals",
          "wp-cli",
          "genesis",
          "polylang"
        },
        files = {maxSize = 10000000 },
        environment = {
          -- WordPress' older style makes it incompatible with LSP configs. These stubs fix that.
          -- First, you need to install them somewhere:
          -- composer require php-stubs/wordpress-globals php-stubs/wordpress-stubs php-stubs/woocommerce-stubs php-stubs/acf-pro-stubs wpsyntex/polylang-stubs php-stubs/genesis-stubs php-stubs/wp-cli-stubs
          -- Then, include the path to them:
          includePaths = { 
            "E:\\DevApps\\lsp_stubs\\vendor\\php-stubs",
            "E:\\DevApps\\lsp_stubs\\vendor\\php-stubs\\acf-pro-stubs"
          }
        },
      }
    }
  }

  for _, lsp in pairs(servers) do
    local lsp_settings = {}
    if(server_configs[lsp] ~= {}) then
      lsp_settings = server_configs[lsp]
    end
  	lspconfig[lsp].setup({
  		on_attach = on_attach,
  		capabilities = capabilities,
      settings = lsp_settings,
      handlers = handlers
  	})
  end

  require'lspconfig'.rust_analyzer.setup{}

  -- clangd is called by the below which follows a separate format
  -- than the servers above.
  require("clangd_extensions").setup{
    server = { 
        capabilities = capabilities,
        on_attach = on_attach,
        autostart = true,
    },
  }

  lspconfig.emmet_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { 'twig', 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss',
      'less', 'php' },
  })


  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                RUST TOOLS CONFIG                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   NEOVIDE CONFIG                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists("g:neovide") 
  let g:neovide_cursor_animation_length=0.0
  let g:neovide_cursor_trail_length=0.10
  let g:neovide_remember_window_size=1
  let g:neovide_refresh_rate=140
endif


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
            "%.la"
        }
    },
    extensions = {
        fzf
    }
}

local function loadSession()
 if(vim.fn.filereadable('Session.vim') ~= 0) then
   -- start a new scratch file just to stop nvim from throwing a floating
   -- window error if we attempt to source without having a non-floating 
   -- buffer open
   vim.cmd('new | setlocal bt=nofile bh=wipe nobl noswapfile nu')
   
   -- source our Session.vim file and ignore the error about closing the
   -- scratch file above so abruptly
   vim.cmd('silent! source Session.vim')

   -- escapes from Insert mode which the source above will leave us in by default
   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>',true,false,true),'m',true)
  end
end

-- Session information
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
require("project_nvim").setup { 
  detection_methods = { "pattern" },
  patterns = { ".git", ".svn" },  -- only register versioning roots as projects
  custom_callback = loadSession
}

require('telescope').load_extension("projects")
EOF

" Find files using Telescope command-line sugar.
" nnoremap <c-f> <cmd>Telescope find_files<cr>
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <c-f>      <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader><leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader><leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fp <cmd>Telescope projects<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  TREESITTER CONFIG                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,

    -- For some reason the TS highlighting conflicts with the everforest theme
    disable = { "scss", "css" },


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
" rendered obsolete from ToggleTerm
" nnoremap <silent> <leader>gg :LazyGit<CR>
" nnoremap <silent> <leader><leader>g :LazyGit<CR>

lua<<EOF
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader><leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 AUTOPAIRS CONFIG                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
-- require("nvim-autopairs").setup {}
EOF


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

" use 'tree' view in netrw by default
let g:netrw_liststyle = 3
" disable the instructions banner in netrw
let g:netrw_banner = 0

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
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

"Column width
set textwidth=100
" set colorcolumn=100 " visualize the column

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

" Allow hidden buffers - important for terminals you show/hide amongst others
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
" Clear last search highlighting when hitting space 
map <space> :noh<cr>

" Quickly source Session.vim in cwd
" map <leader>s :source Session.vim<CR>

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off

" Toggle tabs and EOL
map <leader>l :set list!<CR>

" quick command for editing init.vim
map <leader><leader>e :e $MYVIMRC<CR>

" <leader> / to comment selection - requires tpope/commentary
map <leader>/ :Commentary<CR> 

" Open current directory in OS
map <leader>o :silent !explorer.exe .<CR>

" Color scheme (terminal)
set termguicolors
set t_Co=256

set background=dark
" colorscheme kanagawa
colorscheme nord 

" Set Terminal Colors
" These terminal colors are important with anything that
" uses the terminal colors by default such as LazyGit

"""""""""""" KANAGAWA LAZY GIT THEME
" Black
let g:terminal_color_0  = '#000000' " Normal
let g:terminal_color_8  = '#808080' " Bright
" Red
let g:terminal_color_1  = '#c34043' " Normal
let g:terminal_color_9  = '#e82424' " Bright
" Green
let g:terminal_color_2  = '#98bb6c' " Normal
let g:terminal_color_10 = '#98bb6c' " Bright
" Yellow
let g:terminal_color_3  = '#dca561' " Normal
let g:terminal_color_11 = '#e6c384' " Bright
" Blue
let g:terminal_color_4  = '#658593' " Normal
let g:terminal_color_12 = '#7fb4ca' " Bright
" Purple
let g:terminal_color_5  = '#938aa9' " Normal
let g:terminal_color_13 = '#957fb8' " Bright
" Cyan
let g:terminal_color_6  = '#7aa89f' " Normal
let g:terminal_color_14 = '#7e9cd8' " Bright
" White
let g:terminal_color_7  = '#c0c0c0' " Normal
let g:terminal_color_15 = '#f2f2f2' " Bright

" Custom word highlighting
augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|HACK|NOTE|TODO|OPTIMIZE|PERF|STUDY|PERFORMANCE|UPDATE|KILL|IMPORTANT|REZ|BUG)/ containedin=.*Comment,vimCommentTitle,cBlock,cCommentL,Comment
augroup END
" Testing: 
" TODO FIXME OPTIMIZE STUDY NOTE
highlight! MyTodo guibg='#e6c384'
highlight! vimTodo guibg='#e6c384'
highlight! cTodo guibg='#e6c384'


" Calling WipeReg removes clears and removes all saved registers
command! WipeReg for i in range(33,126) | silent! call setreg(nr2char(i), []) | endfor

" Custom command to load our error log file and open cw
:command Err cgetfile err.log | cw

" Allows quickly cloning a file to the same directory under a specific name
function DuplicateFileToSameDirectory( ... )
  if a:0 != 1
    echo "Filename needed"
    return
  endif
execute 'saveas ' . expand('%:h') . '\' . a:1 . '.' . expand('%:e')
endfunction
:command! -nargs=1 Dup :call DuplicateFileToSameDirectory(<f-args>)

" Position the (global) quickfix window at the very bottom of the window
" (useful for making sure that it appears underneath splits)
"
" NOTE: Using a check here to make sure that window-specific location-lists
" aren't effected, as they use the same `FileType` as quickfix-lists.
autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif

" Set font
let s:fontsize = 13
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  let command = 'set guifont=JetBrainsMono\ NF:h' . s:fontsize
  :execute command
  echom "Font Size Now:" . s:fontsize
endfunction
silent! call AdjustFontSize(0) " set the font as desired on load with the default fontsize

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a

" Visual Mode <C-r> does a search and replace of everything under the cursor
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>

" Hides the command bar while not in use -- praise be to Neovim
"set cmdheight=0 " bleh, currently can't see macro recording state with this at 0 :(

" Automatically reload config files when updated
autocmd! BufWritePost $MYVIMRC nested source $MYVIMRC | echom "Reloaded $MYVIMRC"

" Print out the highlight groups underneath the cursor
function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction
map <leader>hg :call SynStack()<CR>

lua<<EOF

-- This changes the "delete line" shortcut "dd" so that it will not copy
-- deleted blank lines into your paste register, instead if the line is empty
-- it gets thrown into the black hole register.
--
-- This is very helpful because you often yank a line and want to eat the blank
-- as well, but still want to be able to paste the original line elsewhere
function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return "\"_dd"
  else
    return "dd"
  end
end

vim.keymap.set( "n", "dd", smart_dd, { noremap = true, expr = true } );
EOF

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    C/C++ CONFIG                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" switch between header and implementation
" autocmd! Filetype c,cpp map<buffer> <C-e> :Ouroboros<CR>
noremap <C-e> :Ouroboros<CR>

" clang setup

" look for a .clang-format file in the project root and use that 
let g:clang_format#detect_style_file = 1

autocmd FileType c ClangFormatAutoEnable
autocmd FileType cpp ClangFormatAutoEnable
