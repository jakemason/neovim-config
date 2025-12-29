-- ============================================================================
-- LSP + completion
-- Neovim 0.11+ native: vim.lsp.config() + vim.lsp.enable()
-- ============================================================================

-- Diagnostic keymaps (parity)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

-- Mason (installer parity)
require("mason").setup()

-- Completion (parity)
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  if col == 0 then
    return false
  end
  local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
  return text:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.recently_used,
      function(...)
        local ok, ext = pcall(require, "clangd_extensions.cmp_scores")
        if ok then
          return ext(...)
        end
      end,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  window = {
    completion = cmp.config.window.bordered(),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = 50,
      before = function(_, item)
        return item
      end,
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
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
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
  }, {
    { name = "buffer" },
  }),
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<leader>df", vim.lsp.buf.code_action, opts)
  vim.keymap.set({ "n", "v" }, "K", vim.lsp.buf.hover, opts)

  if client:supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end
end

local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    })
  end,
})

local servers = {
  "clangd",
  "intelephense",
  "psalm",
  "pyright",
  "bashls",
  "emmet_ls",
  "jsonls",
  "cssls",
  "html",
  "graphql",
  "gopls",
  "zls",
  "prismals",
  "sqlls",
  "vuels",
  "ts_ls",
  "eslint",
  "ruby_lsp",
  "stylelint_lsp",
  "twiggy_language_server",
  "rust_analyzer",
}

vim.lsp.config("emmet_ls", {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "twig", "html.twig", "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "php" },
})

vim.lsp.config("intelephense", {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    intelephense = {
      stubs = {
        "bcmath","bz2","calendar","Core","curl","date","dba","dom","enchant","fileinfo","filter",
        "ftp","gd","gettext","hash","iconv","imap","intl","json","ldap","libxml","mbstring","mcrypt",
        "mysql","mysqli","password","pcntl","pcre","PDO","pdo_mysql","Phar","readline","recode",
        "Reflection","regex","session","SimpleXML","soap","sockets","sodium","SPL","standard",
        "superglobals","sysvsem","sysvshm","tokenizer","xml","xdebug","xmlreader","xmlwriter",
        "yaml","zip","zlib","wordpress","woocommerce","acf-pro","wordpress-globals","wp-cli",
        "genesis","polylang",
      },
      files = { maxSize = 10000000 },
      environment = {
        includePaths = {
          "E:\\DevApps\\lsp_stubs\\vendor\\php-stubs",
          "E:\\DevApps\\lsp_stubs\\vendor\\php-stubs\\acf-pro-stubs",
        },
      },
    },
  },
})

vim.lsp.config("graphql", {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "graphql-lsp", "server", "-m", "stream" },
  filetypes = { "graphql", "typescriptreact", "javascriptreact" },
})

vim.lsp.config("prismals", {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "/home/devja/.nvm/versions/node/v20.10.0/bin/prisma-language-server", "--stdio" },
})

vim.lsp.config("stylelint_lsp", {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "css", "scss" },
  settings = {
    stylelintplus = {
      autoFixOnSave = true,
    },
  },
})

vim.lsp.config("eslint", {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          filter = function(c)
            return c.name == "prettier"
          end,
        })
      end,
    })
  end,
})

for _, name in ipairs(servers) do
  vim.lsp.config(name, { capabilities = capabilities, on_attach = on_attach })
  pcall(vim.lsp.enable, name)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.prisma",
  callback = function()
    pcall(vim.lsp.buf.format)
  end,
})

pcall(function()
  require("clangd_extensions").setup({
    server = {
      capabilities = capabilities,
      on_attach = on_attach,
      autostart = true,
    },
  })
end)
