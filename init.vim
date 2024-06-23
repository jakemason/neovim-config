""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   VIM-PLUG INSTALLS                 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For plugins to load correctly
filetype plugin indent on

call plug#begin()

if(!has('win32'))
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " show css/scss colors in editor
endif

Plug 'nvim-lua/plenary.nvim' " required by a ton of stuff - just dev utils
Plug 'jackguo380/vim-lsp-cxx-highlight' " better cxx highlights
Plug 'ryanoasis/vim-devicons' " provides some nice dev icons for various other plugins
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kevinhwang91/nvim-bqf' " Better quickfix window
Plug 'nvim-lualine/lualine.nvim' " Status line
Plug 'lewis6991/gitsigns.nvim' " Git signs in the gutter
Plug 'rhysd/vim-clang-format' " clang-format support
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'ziglang/zig.vim' " Syntax highlighting for Zig
" an amazing in-editor git interface - seriously, first time that I've ever preferred
" something over just doing everything via the command line myself.
Plug 'kdheepak/lazygit.nvim'
Plug 'akinsho/toggleterm.nvim' " Open a terminal in a floating window
Plug 'nacro90/numb.nvim' " Preview where you'd go when entering :{number} such as :120
Plug 'ThePrimeagen/harpoon'
Plug 'prisma/vim-prisma' " Syntax highlighting for Prisma
Plug 'jparise/vim-graphql' " Syntax highlighting for GraphQL
Plug 'f-person/git-blame.nvim' " Git blame in the gutter
" Used for automatic documentation generation
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'github/copilot.vim' " GitHub Copilot, really just for better autocompletion
Plug 'vim-test/vim-test' " Run tests from within vim via :TestFile, etc

Plug 'rktjmp/lush.nvim'


nmap <silent> <leader>rt :TestNearest<CR>
nmap <silent> <leader>rT :TestFile<CR>
nmap <silent> <leader>ra :TestSuite<CR>
nmap <silent> <leader>rl :TestLast<CR>
nmap <silent> <leader>rg :TestVisit<CR>


Plug 'kkharji/sqlite.lua'
Plug 'nvim-telescope/telescope-smart-history.nvim'
" Check if the directory exists and create it if it doesn't
" This is REQUIRED to exist in telescope-smart-history
if !isdirectory($HOME . '/.local/share/nvim/databases/')
  call mkdir($HOME . '/.local/share/nvim/databases/', 'p')
endif
if(has('win32'))
  let g:sqlite_clib_path = "E:\/Tools\/sqlite\/sqlite3.dll"
endif

" Allows me to use - / + to move "back and forth" through recent buffers
" as one would in a web browser. I find this is the easiest way to flick
" through recent buffers when digging into multiple files when trying to
" track down a bug. I probably should be better with using marks, but this
" works for me.
Plug 'ton/vim-bufsurf'
nmap = <Plug>(buf-surf-forward)
nmap - <Plug>(buf-surf-back)

" LSP support, autocompletion via nvim-cmp'
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' } " LSP installer
Plug 'williamboman/mason-lspconfig.nvim' " LSP config for Mason
Plug 'neovim/nvim-lspconfig' " LSP config for various languages
Plug 'hrsh7th/nvim-cmp' " Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp' " LSP support for nvim-cmp
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-cmdline'
Plug 'p00f/clangd_extensions.nvim' " Provides extra functionality for clangd
Plug 'onsails/lspkind.nvim' " Pictograms for LSP completion items
" Luasnip and cmp support for it
Plug 'L3MON4D3/LuaSnip' " Snippets support in Neovim
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'preservim/nerdtree' " File explorer
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Syntax highlighting for NERDTree

Plug 'windwp/nvim-autopairs' 

Plug 'rebelot/kanagawa.nvim' " Colorscheme
Plug 'preservim/nerdcommenter' " Easily comment out blocks of code at a time

Plug 'arnaud-lb/vim-php-namespace' " Allows quick importing of 'use' statements in PHP

Plug 'tpope/vim-rails' " Rails support

Plug 'tpope/vim-unimpaired' " Critical for easily moving between quickfix entries ]q, [q and more, etc 

" For quick commenting out of lines
Plug 'tpope/vim-commentary'

" Allows respecting case during search / replace
Plug 'tpope/vim-abolish'

Plug 'tikhomirov/vim-glsl' " GLSL syntax highlighting

" automatically change matching tag in html
Plug 'AndrewRadev/tagalong.vim'

" jump to where you want to go quickly
Plug 'ggandor/leap.nvim'

" close html tags automatically
Plug 'alvan/vim-closetag' " This bugs me so much during C/C++ work

" PHP formatting
Plug 'stephpy/vim-php-cs-fixer'

Plug 'sbdchd/neoformat'

" Prettier formatting
" Requires some global npm installs:
" npm install -g prettier
" npm install -g prettier-plugin-twig-melody
Plug 'prettier/vim-prettier', {
   \ 'do': 'yarn install --frozen-lockfile --production',
   \ 'for': ['html.twig', 'twig', 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

" Syntax support for css/scss
Plug 'JulesWang/css.vim' 
Plug 'cakebaker/scss-syntax.vim'

" Telescope, searching projects, fzf for speed, and session management
Plug 'jakemason/project.nvim'
" NOTE -- Jake Mason | (~2023): Plug 'ahmedkhalf/project.nvim' " No longer maintained it seems, so my fork is better

" Telescope, searching projects, fzf for speed, and session management
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'tpope/vim-obsession'
Plug 'ludovicchabant/vim-gutentags'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'jakemason/ouroboros.nvim'

" colorscheme experiments
Plug 'arcticicestudio/nord-vim'
Plug 'cranberry-clockworks/coal.nvim'
Plug 'lurst/austere.vim'
Plug 'fxn/vim-monochrome'
Plug 'n1ghtmare/noirblaze-vim'
Plug 'widatama/vim-phoenix'



Plug 'simrat39/rust-tools.nvim'
call plug#end()

let test#strategy = "toggleterm"
let test#custom_runners = {'Yarn': ['Yarn']}

let g:Hexokinase_highlighters= ['virtual']
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
      \'*.min,'
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


lua<<EOF


require('numb').setup()

-- On Mac we use whatever the default shell is, on Windows we need to specify powershell
if (vim.fn.has('macunix') == 1 or vim.fn.has('wsl') == 1) then
  require("toggleterm").setup()
else 
  require("toggleterm").setup{ shell = 'powershell' }
end

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd('autocmd! TermOpen term://*toggleterm* lua set_terminal_keymaps()')

EOF

map <leader>t :ToggleTerm direction=float<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  NEOFORMAT CONFIG                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup fmt
  autocmd!
  autocmd BufWritePre * silent! undojoin | Neoformat
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     LEAP CONFIG                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('leap').add_default_mappings()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  COPILOT CONFIG                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua vim.g.copilot_assume_mapped = true
"lua vim.api.nvim_set_keymap('i', '<C-/>', 'copilot#Accept("<CR>")', {expr=true, silent=true})
lua vim.api.nvim_set_keymap('i', '<C-CR>', 'copilot#Accept("<CR>")', {expr=true, silent=true})

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
"                   HARPOON CONFIG                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua<<EOF
  local mark = require("harpoon.mark")
  local ui = require("harpoon.ui")

  local function mark_file()
    vim.print("Marked file")
    mark.add_file() 
  end

  vim.keymap.set("n", "<leader>m",mark_file)
  -- vim.keymap.set("n", "<leader>fm", ui.toggle_quick_menu) -- using Telescope instead
  vim.keymap.set("n", "<leader>[", ui.nav_prev)
  vim.keymap.set("n", "<leader>]", ui.nav_next)
  vim.keymap.set("n", "<leader>]", ui.nav_next)

  vim.keymap.set("n", "<leader>m1", function() ui.nav_file(1) end)
  vim.keymap.set("n", "<leader>m2", function() ui.nav_file(2) end)
  vim.keymap.set("n", "<leader>m3", function() ui.nav_file(3) end)
  vim.keymap.set("n", "<leader>m4", function() ui.nav_file(4) end)
  vim.keymap.set("n", "<leader>m5", function() ui.nav_file(5) end)
  vim.keymap.set("n", "<leader>m6", function() ui.nav_file(6) end)
EOF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    LUASNIP CONFIG                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" See after/plugin/luasnip

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     LSP CONFIG                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=menu,menuone,noselect

lua<<EOF
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

  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
  })

  vim.o.updatetime = 250
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })

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

  require("mason").setup();
  require("mason-lspconfig").setup()
  -- replaced by mason.nvim
  -- require("nvim-lsp-installer").setup {
  --  automatic_installation = true
  -- }
  
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
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
    end

  end


  -- This enables borders for the LSP Info windows and alike
  require('lspconfig.ui.windows').default_options.border = 'rounded'


  local lspconfig = require('lspconfig')

  local servers = {
    "clangd",
    "intelephense",
    "psalm",
  	"pyright",
--    "lua_ls",
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
--    "tsserver",
    "prismals",
    "sqlls",
--    "solargraph",
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

  require'lspconfig'.ruby_lsp.setup{
  		on_attach = on_attach,
  	  capabilities = capabilities,
      settings = lsp_settings,
      handlers = handlers
  }

  require("lspconfig").stylelint_lsp.setup({
    filetypes = { "css", "scss" },
    root_dir = require"lspconfig".util.root_pattern("package.json", ".git"),
    settings = {
      stylelintplus = {
        autoFixOnSave = true
        -- see available options in stylelint-lsp documentation
      },
    },
    on_attach = on_attach
  })

  require'lspconfig'.rust_analyzer.setup{}
  
  require'lspconfig'.graphql.setup{
    cmd = { "graphql-lsp", "server", "-m", "stream" },
    filetypes = { "graphql", "typescriptreact", "javascriptreact" },
    root_dir = require'lspconfig'.util.root_pattern('.git', '.graphqlrc*', '.graphql.config.*', 'graphql.config.*');
  }


  require'lspconfig'.twiggy_language_server.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        twiggy = {
            -- before 0.8.0:
            -- phpBinConsoleCommand = 'php bin/console',
            framework = 'symfony',
            phpExecutable = '/usr/bin/php',
            symfonyConsolePath = 'bin/console',
        },
    },
}

  local home = os.getenv("HOME") or os.getenv("USERPROFILE")
  -- require('lspconfig').solargraph.setup { 
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  --   cmd = { home .. "/.rbenv/shims/solargraph", 'stdio' },
  -- }

  local function organize_imports()
    local params = {
      command = "_typescript.organizeImports",
      -- arguments = {vim.api.nvim_buf_get_name(0)},
      arguments = {vim.fn.expand("%:p")},
      title = ""
    }
    vim.lsp.buf.execute_command(params)
  end

  require('lspconfig').tsserver.setup({
  		on_attach = on_attach,
  	capabilities = capabilities,
    init_options = { 
      preferences = { 
        importModuleSpecifierPreference = 'relative', 
        importModuleSpecifierEnding = 'auto', 
      },  
    },

    commands = {
     OrganizeImports = {
       organize_imports,
       description = "Organize Imports"
     }
    }
  })
  -- TODO -- Jake Mason | (12/06/23) 
  -- I want to be running this, but Joe requested that I make sure eslint does it first
  -- so that everyone has the same functionality.
  vim.cmd [[autocmd BufWritePre *.ts silent! :OrganizeImports]]
  vim.cmd [[autocmd BufWritePre *.tsx silent! :OrganizeImports]]

  -- Prisma format on save
  vim.cmd [[autocmd BufWritePre *.prisma silent! lua vim.lsp.buf.format()]]


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
lua<<EOF

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
"                   GITSIGNS CONFIG                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua<<EOF
require('gitsigns').setup();
EOF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   TELESCOPE CONFIG                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua<<EOF
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
        },
        mappings = {
            i = {
              ["<C-Down>"] = require('telescope.actions').cycle_history_next,
              ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
            },
        },
        history = {
          path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
          limit = 100,
        }
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      }
    }
}

local function closeSession()
 -- if we're currently tracking in an active project, we want to pause that
 -- by calling Obsess before we open the next project. If we don't project #2
 -- will track the session in project #1's Session.vim file
 if vim.g.this_obsession then
  vim.cmd('silent! Obsess')
 end
end

local function loadSession()
 -- store the project directory we just switched into because our bwipeout call
 -- below will change it again and we need to switch to it after the clear out
 project_directory = vim.fn.getcwd(); 
 -- need to wipeout all open buffers or Telescope lingers on the last project
 -- vim.cmd('silent! bufdo! bwipeout') 
 vim.cmd('silent! %bwipeout!') 
 vim.cmd('cd ' .. project_directory)
 if(vim.fn.filereadable('Session.vim') ~= 0) then
   -- start a new scratch file just to stop nvim from throwing a floating
   -- window error if we attempt to source without having a non-floating 
   -- buffer open
   vim.cmd('new | setlocal bt=nofile bh=wipe nobl noswapfile nu')
   
   -- source our Session.vim file and ignore the error about closing the
   -- scratch file above so abruptly
   vim.cmd('silent! source Session.vim')

   -- escapes from Insert mode, which the source call above will leave us in by default
   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>',true,false,true),'m',true)
  end
end

-- Session information
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
require("project_nvim").setup { 
  detection_methods = { "pattern" },
  patterns = { ".git", ".svn" },  -- only register versioning roots as projects
  after_project_selection_callback = loadSession,
  before_project_selection_callback = closeSession
}

require('telescope').load_extension("projects")
require("telescope").load_extension('harpoon')
require("telescope").load_extension('fzf')
require('telescope').load_extension('smart_history')



function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

local keymap = vim.keymap.set
local tb = require('telescope.builtin')
local opts = { noremap = true, silent = true }

keymap('v', '<leader>f', function()
	local text = vim.getVisualSelection()
	tb.current_buffer_fuzzy_find({ default_text = text })
end, opts)

keymap('v', '<leader>g', function()
	local text = vim.getVisualSelection()
	tb.live_grep({ default_text = text })
end, opts)

EOF

" Find files using Telescope command-line sugar.
" nnoremap <c-f> <cmd>Telescope find_files<cr>
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <c-f>      <cmd>Telescope find_files<cr>
nnoremap <leader>fu <cmd>Telescope lsp_references<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader><leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader><leader>f <cmd>Telescope git_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fp <cmd>Telescope projects<cr>
nnoremap <leader>fm <cmd>Telescope harpoon marks<cr>




"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  TREESITTER CONFIG                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua<<EOF

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 50 * 1024 -- 50 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
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

let g:gitblame_date_format = '%b %Y'

" Always show status bar
set laststatus=2

set statusline+=%#warningmsg#
set statusline+=%*
lua<<EOF
local git_blame = require('gitblame')
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
    lualine_c = {
      {
        'filename',
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
      -- {
      --  git_blame.get_current_blame_text, 
      --  cond = git_blame.is_blame_text_available
      -- }
    },
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
" nnoremap <silent> <leader>gg :LazyGit<CR>
" nnoremap <silent> <leader><leader>g :LazyGit<CR>


lua<<EOF

local cmd = "eval `keychain --eval --agents ssh id_rsa 2>/dev/null` && lazygit"

-- We just run regular lazygit on windows, no need to look for an agent
if ((vim.fn.has('win32') == 1) and (vim.fn.has('unix') == 0)) then
 cmd = "lazygit"
end 

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  -- This slows down the startup time considerably for lazygit, but trying to do this on
  -- the "on_create" hook instead unfortunately doesn't seem to work
  cmd = cmd,
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
  lazygit.dir = vim.fn.getcwd()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader><leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
--vim.api.nvim_set_keymap("n", "<leader><leader>g", "<cmd>TermExec cmd='lazygit' go_back=0 direction='float'<CR>", {noremap = true, silent = true})

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

" Forces word wrapping to break on words, rather than on character
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
au BufRead,BufNewFile *.prisma set filetype=prisma | syntax off


" Security
set modelines=0

" turn hybrid line numbers on
set number relativenumber
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

if has('macunix')
 nnoremap <D-w> <C-w>
 nnoremap <D-q> <C-q>
 nnoremap <D-r> <C-r>
 nnoremap <D-]> <C-]>
endif

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

iabbrev TODO TODO -- Jake Mason \| (<C-R>=strftime('%x')<C-M>)
iabbrev NOTE NOTE -- Jake Mason \| (<C-R>=strftime('%x')<C-M>)
iabbrev PERF PERF -- Jake Mason \| (<C-R>=strftime('%x')<C-M>)
iabbrev BUG BUG -- Jake Mason \| (<C-R>=strftime('%x')<C-M>)
iabbrev FIXME FIXME -- Jake Mason \| (<C-R>=strftime('%x')<C-M>)
iabbrev MONITOR MONITOR -- Jake Mason \| (<C-R>=strftime('%x')<C-M>)
" Quickly source Session.vim in cwd
" map <leader>s :source Session.vim<CR>

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off

function! BuildProject(build_path)
  let path_string = a:build_path
  execute "set makeprg=" . path_string
  echom "Executing build @ " . path_string ."..."
  silent! execute 'make'
  echom ""
  redraw!
endfunction
map <leader><leader>b :call BuildProject('C:\athena\utils\compile_commands\build_editor_debug.cmd')<CR>

" Toggle tabs and EOL
map <leader>l :set list!<CR>

" quick command for editing init.vim
map <leader><leader>e :e $MYVIMRC<CR>

" <leader> / to comment selection - requires tpope/commentary
map <leader>/ :Commentary<CR> 

" Open current directory in OS
map <leader>o :silent !explorer.exe .<CR>


let NERDTreeShowHidden=1
" Toggle NERDTree, and open it at the current buffers folder to start
map <leader><leader>x :NERDTreeFind %<CR>
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
autocmd FileType nerdtree syntax enable

if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" Color scheme (terminal)
set termguicolors
set t_Co=256

set background=dark
colorscheme phoenix
"let g:phoenix_invert_match_paren = 1
"PhoenixPurple
"hi Identifier                 guifg=#d1afdd guibg=NONE    gui=NONE      ctermfg=246
colorscheme kanagawa
" colorscheme nord 


" Infinite & persistent undo
" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'

if stridx(&runtimepath, expand(vimDir)) == -1
  " vimDir is not on runtimepath, add it
  let &runtimepath.=','.vimDir
endif

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif


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
    au Syntax * syn match MyTodo /\v<(FIXME|MONITOR|HACK|NOTE|TODO|OPTIMIZE|PERF|STUDY|PERFORMANCE|UPDATE|KILL|IMPORTANT|REZ|BUG)/ containedin=.*Comment,vimCommentTitle,cBlock,cCommentL,Comment
augroup END
" Testing: 
" TODO FIXME OPTIMIZE STUDY NOTE
highlight! MyTodo guibg='#72638a'
highlight! vimTodo guibg='#72638a'
highlight! cTodo guibg='#72638a'

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

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

" The DPI settings on the new MacBook means that 14 is too small, so we bump it up to 17
" specifically on OSX
if has('macunix')
 let s:fontsize = 17
endif

function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
"  let command = 'set guifont=JetBrainsMono\ NF:h' . s:fontsize
  let command = 'set guifont=BerkeleyMono\ Nerd\ Font\ Mono:h' . s:fontsize
  :execute command
  echom "Font Size Now:" . s:fontsize
endfunction
silent! call AdjustFontSize(0) " set the font as desired on load with the default fontsize

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a

" Visual Mode <C-r> does a search and replace of everything under the cursor
vnoremap <C-r> "hy:%s#<C-r>h##g<left><left>

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

lua<<EOF

function faster_alphabetize_selection()
  local start_pattern = "start%-auto%-alphabetize"
  local end_pattern = "end%-auto%-alphabetize"

  local lines = vim.fn.getline(1, '$')
  local in_block = false
  local block_start = 0

  for i, line in ipairs(lines) do
      if string.match(line, start_pattern) then
          if in_block then
            -- If we were already in a block, process it
            process_block(block_start, i)
          end
          in_block = true
          block_start = i
      elseif string.match(line, end_pattern) then
          if in_block then
            process_block(block_start, i)
          end
          in_block = false
      end
  end
end

function process_block(start, end_line)
  vim.cmd(':' .. (start + 1) .. ',' .. (end_line - 1) .. ' sort')
end

EOF

" Create an autocommand to trigger the alphabetization on save
augroup AlphabetizeOnSave
 autocmd!
 autocmd BufWritePre * :lua faster_alphabetize_selection()
augroup END

function! OopsAllBoxes()
  let command = 'set guifont=OopsAllBoxes'
  :execute command
  set nospell
endfunction
