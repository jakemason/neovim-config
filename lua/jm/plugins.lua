-- ============================================================================
-- Plugin list (lazy.nvim)
-- Notes:
-- - No fake “jm-* loader” repos. Everything is real.
-- - We keep plugin parity with your original init.vim.
-- ============================================================================

return {
  -- Utilities
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Visuals / UI
  { "ryanoasis/vim-devicons", lazy = true },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.o.termguicolors = true
      vim.o.background = "dark"
      vim.cmd.colorscheme("kanagawa")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "ryanoasis/vim-devicons" },
    config = function()
      require("jm.lualine")
    end,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require("gitsigns").setup()
    end,
  },
  { "f-person/git-blame.nvim", lazy = true },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("jm.treesitter")
    end,
  },
  { "nvim-treesitter/playground", lazy = true },

  -- Better quickfix
  { "kevinhwang91/nvim-bqf", ft = "qf" },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false,
    config = function()
      require("jm.toggleterm")
    end,
  },

  -- Numb
  {
    "nacro90/numb.nvim",
    lazy = false,
    config = function()
      require("numb").setup()
    end,
  },

  -- File explorer (parity)
  { "preservim/nerdtree", lazy = true, cmd = { "NERDTree", "NERDTreeFind", "NERDTreeToggle" } },
  { "tiagofumo/vim-nerdtree-syntax-highlight", lazy = true },

  -- Commenting
  { "tpope/vim-commentary", lazy = false },
  { "preservim/nerdcommenter", lazy = true },

  -- Motion
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  -- Buffer surf (parity)
  { "ton/vim-bufsurf", lazy = false },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    lazy = false,
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Telescope + extensions + project sessions
  { "kkharji/sqlite.lua", lazy = true },
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "jakemason/project.nvim",
      "tpope/vim-obsession",
      "ThePrimeagen/harpoon",
    },
    config = function()
      require("jm.telescope")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    lazy = true,
  },
  { "nvim-telescope/telescope-smart-history.nvim", lazy = true },

  -- Project.nvim (your fork) + Obsession sessions (parity)
  {
    "jakemason/project.nvim",
    lazy = false,
    dependencies = { "tpope/vim-obsession" },
    config = function()
      require("jm.project")
    end,
  },
  { "tpope/vim-obsession", lazy = false },

  -- Harpoon
  {
    "ThePrimeagen/harpoon",
    lazy = false,
    config = function()
      require("jm.harpoon")
    end,
  },

  -- Tags
  { "ludovicchabant/vim-gutentags", lazy = false },

  -- C/C++ tooling
  { "jackguo380/vim-lsp-cxx-highlight", lazy = true, ft = { "c", "cpp" } },
  { "rhysd/vim-clang-format", lazy = true, ft = { "c", "cpp" } },
  { "jakemason/ouroboros.nvim", lazy = false },

  -- Language syntax
  { "ziglang/zig.vim", ft = "zig" },
  { "prisma/vim-prisma", ft = "prisma" },
  { "jparise/vim-graphql", ft = { "graphql", "gql" } },
  { "tikhomirov/vim-glsl", ft = { "glsl", "vert", "frag" } },
  { "JulesWang/css.vim", ft = { "css" } },
  { "cakebaker/scss-syntax.vim", ft = { "scss", "sass" } },

  -- Rails / PHP
  { "tpope/vim-rails", ft = { "ruby", "eruby" } },
  { "arnaud-lb/vim-php-namespace", ft = "php" },
  { "stephpy/vim-php-cs-fixer", ft = "php" },

  -- Misc
  { "tpope/vim-unimpaired", lazy = false },
  { "tpope/vim-abolish", lazy = false },
  { "alvan/vim-closetag", ft = { "html", "xhtml", "phtml", "twig" } },

  -- Formatting
  { "sbdchd/neoformat", lazy = false },
  {
    "prettier/vim-prettier",
    build = "yarn install --frozen-lockfile --production",
    ft = { "html.twig", "twig", "javascript", "typescript", "css", "less", "scss", "json", "graphql", "markdown", "vue", "svelte", "yaml", "html" },
  },

  -- TODO lists
  { "aserebryakov/vim-todo-lists", ft = "todo" },

  -- Copilot + Doge
  { "github/copilot.vim", lazy = true },
  { "kkoomen/vim-doge", build = ":call doge#install()", lazy = true },

  -- vim-test
  { "vim-test/vim-test", lazy = false },

  -- DAP
  { "mfussenegger/nvim-dap", lazy = false },
  { "nvim-neotest/nvim-nio", lazy = false },
  {
    "rcarriga/nvim-dap-ui",
    lazy = false,
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("jm.dap")
    end,
  },
  { "mxsdev/nvim-dap-vscode-js", lazy = true },

  -- LSP + completion
  { "williamboman/mason.nvim", lazy = false },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require("jm.lsp")
    end,
  },
  { "hrsh7th/nvim-cmp", lazy = false },
  { "hrsh7th/cmp-nvim-lsp", lazy = false },
  { "hrsh7th/cmp-buffer", lazy = false },
  { "hrsh7th/cmp-path", lazy = false },
  { "hrsh7th/cmp-nvim-lsp-signature-help", lazy = false },
  { "hrsh7th/cmp-cmdline", lazy = false },
  { "L3MON4D3/LuaSnip", lazy = false },
  { "saadparwaiz1/cmp_luasnip", lazy = false },
  { "onsails/lspkind.nvim", lazy = false },
  { "p00f/clangd_extensions.nvim", lazy = true },

  -- Rust tools (kept for parity)
  { "simrat39/rust-tools.nvim", lazy = true },
}
