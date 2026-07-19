-- ============================================================================
-- LSP + completion
-- Neovim 0.13 native: vim.lsp.config() + vim.lsp.enable()
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Floating-window border
-- ----------------------------------------------------------------------------

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

-- ----------------------------------------------------------------------------
-- Diagnostics
-- ----------------------------------------------------------------------------

vim.keymap.set("n", "<leader>e", function()
	vim.diagnostic.open_float({
		border = border,
	})
end, {
	silent = true,
	desc = "Show diagnostic",
})

vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({
		count = -1,
		float = true,
	})
end, {
	silent = true,
	desc = "Previous diagnostic",
})

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({
		count = 1,
		float = true,
	})
end, {
	silent = true,
	desc = "Next diagnostic",
})

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = false,
	float = {
		border = border,
		source = "always",
	},
})

local diagnostic_float_group = vim.api.nvim_create_augroup("JmDiagnosticFloat", { clear = true })

vim.api.nvim_create_autocmd("CursorHold", {
	group = diagnostic_float_group,
	callback = function()
		vim.diagnostic.open_float({
			focusable = false,
			close_events = {
				"BufLeave",
				"CursorMoved",
				"InsertEnter",
				"FocusLost",
			},
			border = border,
			source = "always",
			prefix = " ",
			scope = "cursor",
		})
	end,
})

-- ----------------------------------------------------------------------------
-- Mason
-- ----------------------------------------------------------------------------

require("mason").setup()

-- ----------------------------------------------------------------------------
-- Completion
-- ----------------------------------------------------------------------------

local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local function has_words_before()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local line = cursor[1]
	local col = cursor[2]

	if col == 0 then
		return false
	end

	local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]

	return text ~= nil and text:sub(col, col):match("%s") == nil
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
			mode = "symbol_text",
			maxwidth = 80,

			before = function(entry, item)
				local source_labels = {
					nvim_lsp = "[LSP]",
					luasnip = "[Snippet]",
					nvim_lsp_signature_help = "[Signature]",
					minuet = "[AI]",
					buffer = "[Buffer]",
					path = "[Path]",
					cmdline = "[Command]",
				}

				item.menu = source_labels[entry.source.name] or ("[" .. entry.source.name .. "]")

				return item
			end,
		}),
	},

	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),

		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),

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
		end, {
			"i",
			"s",
		}),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),

	sources = cmp.config.sources({
		{
			name = "nvim_lsp",
			priority = 1000,
		},
		{
			name = "luasnip",
			priority = 900,
		},
		{
			name = "nvim_lsp_signature_help",
			priority = 850,
		},
		{
			name = "minuet",
			priority = 750,
		},
	}, {
		{
			name = "buffer",
			priority = 500,
		},
	}),
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- ----------------------------------------------------------------------------
-- LSP capabilities
-- ----------------------------------------------------------------------------

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- ----------------------------------------------------------------------------
-- LSP attachment
-- ----------------------------------------------------------------------------

-- Disable the legacy vim-clang-format save hook. Formatting is handled by LSP.
vim.g["clang_format#auto_format"] = 0

local lsp_attach_group = vim.api.nvim_create_augroup("JmLspAttach", { clear = true })

local lsp_format_group = vim.api.nvim_create_augroup("JmLspFormat", { clear = true })

local function show_hover()
	vim.lsp.buf.hover({
		border = border,
	})
end

local function show_signature_help()
	vim.lsp.buf.signature_help({
		border = border,
	})
end

local function set_lsp_keymaps(bufnr)
	local opts = {
		noremap = true,
		silent = true,
		buffer = bufnr,
	}

	vim.keymap.set(
		"n",
		"<leader>df",
		vim.lsp.buf.code_action,
		vim.tbl_extend("force", opts, {
			desc = "LSP code action",
		})
	)

	vim.keymap.set(
		{ "n", "v" },
		"K",
		show_hover,
		vim.tbl_extend("force", opts, {
			desc = "LSP hover",
		})
	)

	vim.keymap.set(
		"i",
		"<C-k>",
		show_signature_help,
		vim.tbl_extend("force", opts, {
			desc = "LSP signature help",
		})
	)
end

-- Prefer the formatter associated with each filetype when multiple LSP clients
-- are attached to the same buffer.
local preferred_formatters = {
	c = { "clangd" },
	cpp = { "clangd" },
	objc = { "clangd" },
	objcpp = { "clangd" },
	javascript = { "prettier", "eslint", "ts_ls" },
	javascriptreact = { "prettier", "eslint", "ts_ls" },
	typescript = { "prettier", "eslint", "ts_ls" },
	typescriptreact = { "prettier", "eslint", "ts_ls" },
	css = { "prettier", "stylelint_lsp", "cssls" },
	scss = { "prettier", "stylelint_lsp", "cssls" },
	html = { "prettier", "html" },
	json = { "prettier", "jsonls" },
	jsonc = { "prettier", "jsonls" },
	prisma = { "prismals" },
	python = { "pyright" },
	php = { "intelephense", "psalm" },
	go = { "gopls" },
	rust = { "rust_analyzer" },
	zig = { "zls" },
	ruby = { "ruby_lsp" },
	graphql = { "graphql" },
	sh = { "bashls" },
	sql = { "sqlls" },
}

local function get_format_client(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	local preferred = preferred_formatters[vim.bo[bufnr].filetype] or {}

	local function can_format(client)
		return client:supports_method("textDocument/formatting", bufnr)
	end

	for _, preferred_name in ipairs(preferred) do
		for _, client in ipairs(clients) do
			if client.name == preferred_name and can_format(client) then
				return client
			end
		end
	end

	for _, client in ipairs(clients) do
		if can_format(client) then
			return client
		end
	end

	return nil
end

local function setup_format_on_save(bufnr)
	local existing = vim.api.nvim_get_autocmds({
		group = lsp_format_group,
		event = "BufWritePre",
		buffer = bufnr,
	})

	if #existing > 0 then
		return
	end

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = lsp_format_group,
		buffer = bufnr,
		desc = "Format buffer using its preferred LSP client",
		callback = function(args)
			local client = get_format_client(args.buf)

			if not client then
				return
			end

			vim.lsp.buf.format({
				bufnr = args.buf,
				id = client.id,
				async = false,
				timeout_ms = 3000,
			})
		end,
	})
end

local function on_attach(_, bufnr)
	set_lsp_keymaps(bufnr)
	setup_format_on_save(bufnr)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_attach_group,
	desc = "Configure LSP keymaps and format-on-save",
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client then
			on_attach(client, event.buf)
		end
	end,
})

-- Reconfigure clients that are already attached when this file is re-sourced.
for _, client in ipairs(vim.lsp.get_clients()) do
	for bufnr in pairs(client.attached_buffers) do
		on_attach(client, bufnr)
	end
end

-- ----------------------------------------------------------------------------
-- Shared LSP configuration
-- ----------------------------------------------------------------------------

vim.lsp.config("*", {
	capabilities = capabilities,
})

-- ----------------------------------------------------------------------------
-- Language servers
-- ----------------------------------------------------------------------------

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
	"vue_ls",
	"ts_ls",
	"eslint",
	"ruby_lsp",
	"stylelint_lsp",
	"twiggy_language_server",
	"rust_analyzer",
}

-- ----------------------------------------------------------------------------
-- Emmet
-- ----------------------------------------------------------------------------

vim.lsp.config("emmet_ls", {
	filetypes = {
		"twig",
		"html.twig",
		"html",
		"typescriptreact",
		"javascriptreact",
		"css",
		"sass",
		"scss",
		"less",
		"php",
	},
})

-- ----------------------------------------------------------------------------
-- Intelephense
-- ----------------------------------------------------------------------------

vim.lsp.config("intelephense", {
	settings = {
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
				"polylang",
			},

			files = {
				maxSize = 10000000,
			},

			environment = {
				includePaths = {
					"E:\\DevApps\\lsp_stubs\\vendor\\php-stubs",
					"E:\\DevApps\\lsp_stubs\\vendor\\php-stubs\\acf-pro-stubs",
				},
			},
		},
	},
})

-- ----------------------------------------------------------------------------
-- GraphQL
-- ----------------------------------------------------------------------------

vim.lsp.config("graphql", {
	cmd = {
		"graphql-lsp",
		"server",
		"-m",
		"stream",
	},

	filetypes = {
		"graphql",
		"typescriptreact",
		"javascriptreact",
	},
})

-- ----------------------------------------------------------------------------
-- Prisma
-- ----------------------------------------------------------------------------

vim.lsp.config("prismals", {
	cmd = {
		"/home/devja/.nvm/versions/node/v20.10.0/bin/prisma-language-server",
		"--stdio",
	},
})

-- ----------------------------------------------------------------------------
-- Stylelint
-- ----------------------------------------------------------------------------

vim.lsp.config("stylelint_lsp", {
	filetypes = {
		"css",
		"scss",
	},

	settings = {
		stylelintplus = {
			autoFixOnSave = true,
		},
	},
})

-- ----------------------------------------------------------------------------
-- Enable servers
-- ----------------------------------------------------------------------------

for _, name in ipairs(servers) do
	local ok, err = pcall(vim.lsp.enable, name)

	if not ok then
		vim.notify(string.format("Failed to enable LSP %q: %s", name, err), vim.log.levels.WARN)
	end
end

-- ----------------------------------------------------------------------------
-- clangd_extensions
-- ----------------------------------------------------------------------------

pcall(function()
	require("clangd_extensions").setup({})
end)
