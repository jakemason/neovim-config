--
--
--          CONFIG
--
--
local ls = require "luasnip"

ls.config.set_config {
  history = true,
  update_events = 'TextChanged, TextChangedI'
}

local config_directory = vim.fn.stdpath('config')
vim.keymap.set('n', '<leader><leader>s', '<cmd>source ' .. config_directory .. '/after/plugin/luasnip.lua<CR>')

vim.keymap.set({"i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, {silent = true })


--
--
--           SNIPPETS
--
--
local snippet = ls.s
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local c_cpp_snips = {
}

local twig_snips = {
  -- To escape "{" we need to double it up. This gets ugly with twig...
  snippet("dd", fmt ("{{{{ dd({}) }}}}{}", { i(1), i(0) })),

  snippet("plc", fmt(
  "<img src=\"https://unsplash.it/{}/{}\"/>\n{}", {i(1), i(2), i(0)}
  )),

  snippet("for", fmt(
    "{{% for {} in context.{}s %}}\n\t{}\n{{% endfor %}}", {i(1), rep(1), i(0)}
  )),

  snippet("if", fmt(
    "{{% if {} %}}\n\t{}\n{{% endif %}}", {i(1), i(0)}
  )),

  snippet("__", fmt(
  "{{{{ __('{}', '{}') }}}}\n{}", {i(1), i(2), i(0)}
  )),

  snippet("include", fmt(
    "{{% include \"{}.twig\" with {} {{}} %}}{}", {i(1), i(2), i(0)}
  ))
}

local php_snips = {
  snippet("dd", fmt("echo '<pre>';\nvar_dump({});\necho '</pre>'", {i(0)}))
}

ls.add_snippets("html", twig_snips)
ls.add_snippets("twig", twig_snips)
ls.add_snippets("c", c_cpp_snips)
ls.add_snippets("cpp", c_cpp_snips)
ls.add_snippets("php", php_snips)
