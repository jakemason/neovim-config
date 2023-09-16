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

vim.keymap.set({"i", "s" }, "<c-enter>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, {silent = true })

-- THIS DOES NOT WORK AND MAKES LIFE MISERABLE :(
-- vim.keymap.set({"i", "s" }, "<enter>", function()
--     if ls.expand_or_jumpable() then
--       ls.expand_or_jump()
--     else
--       -- if we can't expand, we just feed the regular ol' <enter> sequence to do a newline
--       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<enter>", true, false, true), "n", false)
--     end
-- end, {silent = true })

vim.keymap.set({"i", "s" }, "<s-enter>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, {silent = true })
--
--
--           GRAMMAR
--
--
local snippet = ls.s
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
-- only difference is it uses "< >" as delimiters instead of "{ }"
-- this is very useful in any language where "{ }" are common symbols, such as within .twig
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local postfix = require("luasnip.extras.postfix").postfix
local lambda = require("luasnip.extras").l
local f = ls.function_node

--
--
--           FUNCTIONS
--
--

-- Not meant to be comprehensible, just usable
local function camelToSnake(s)
  return s:gsub('%f[^%l]%u','_%1'):gsub('%f[^%a]%d','_%1'):gsub('%f[^%d]%a','_%1'):gsub('(%u)(%u%l)','%1_%2'):lower()
end

-- convert "this_is_an_example" to "This Is An Example"
local function snakeToPlainUppercased(s)
  return s:gsub('_', ' '):gsub('(%l)(%w*)', function(a,b) return string.upper(a)..b end)
end

local uc = function(insert_node_id)
  return f(function(args) return string.upper(camelToSnake(args[1][1])) end, insert_node_id)
end

local snakeTitleNode = function(insert_node_id)
  return f(function(args)
    return snakeToPlainUppercased(args[1][1]) end,
  insert_node_id)
end



--
--
--           SNIPPETS
--
--

------------------------------------
---------------- JS ----------------
------------------------------------
local js_snips = {
  postfix(".log", { lambda("console.log(" .. lambda.POSTFIX_MATCH .. ");")}),
  postfix(".err", { lambda("console.error(" .. lambda.POSTFIX_MATCH .. "); // eslint-disable-line no-console")}),
}

------------------------------------
------------ (S)CSS ----------------
------------------------------------
local css_snips = {
  snippet("!", fmt("!important;{}", { i(0) })),
  snippet("df", fmta("@include down-from(<>){<>};<>", { i(1), i(2), i(0) })),
  snippet("uf", fmta("@include up-from(<>){<>};<>", { i(1), i(2), i(0) })),
}

------------------------------------
--------------- ZIG ----------------
------------------------------------
local zig_snips = {
  snippet("print", fmt("std.debug.print(\"{}\\n\", .{{{}}});{}", { i(1), i(2), i(0) })),
  postfix(".print", { lambda("std.debug.print(\"{any}\\n\", .{" .. lambda.POSTFIX_MATCH .. "});")}),
  postfix(".log",   { lambda("std.debug.print(\"{any}\\n\", .{" .. lambda.POSTFIX_MATCH .. "});")}),
}

------------------------------------
-------------- C/C++ ---------------
------------------------------------
local c_cpp_snips = {
  snippet("cl", fmta([[ 
    #ifndef <>_HPP
    #define <>_HPP

    class <>
    {
      public:
        <>
    };

    #endif
    ]]
    , { uc(1), uc(1), i(1), i(0) })

    ),
}

------------------------------------
-------------- TWIG ----------------
------------------------------------
local twig_snips = {
  snippet("dd", fmta ("{{ dd(<>) }}<>", { i(1), i(0) })),

  snippet("plc", fmt(
  "<img src=\"https://unsplash.it/{}/{}\"/>\n{}", {i(1), i(2), i(0)}
  )),

  snippet("for", fmta(
    "{% for <> in context.<>s %}\n\t<>\n{% endfor %}", {i(1), rep(1), i(0)}
  )),

  snippet("if", fmta(
    "{% if <> %}\n\t<>\n{% endif %}", {i(1), i(0)}
  )),

  snippet("__", fmta(
  "{{ __('<>', '<>') }}\n<>", {i(1), i(2), i(0)}
  )),

  snippet("{", fmta(
  "{{ <> }}<>", {i(1), i(0)}
  )),

  snippet("{c", fmta(
  "{{ context.<> }}<>", {i(1), i(0)}
  )),

  snippet("include", fmta(
    "{% include \"<>.twig\" with <> {} %}<>", {i(1), i(2), i(0)}
  ))
}

------------------------------------
--------------- PHP ----------------
------------------------------------
local php_snips = {
  snippet("dd", fmt("echo '<pre>';\nvar_dump({});\necho '</pre>';", {i(0)})),

  snippet("ddd", fmt("echo '<pre>';\nvar_dump({});\necho '</pre>';die();", {i(0)})),

  snippet("dds", fmt("echo '<pre style=\"display: none !important;\">';\nvar_dump({});\necho '</pre>';", {i(0)})),

  snippet("for", fmt("for({} = 0; {} < sizeof({}); {}++) {{ \n {}\n}}\n{}",  {i(1), rep(1), i(2), rep(1), i(3), i(0)})),

  snippet("field", fmt(
  [[
  [
      'key'          => self::KEY . '_{}',
      'label'        => __('{}', TEXT_DOMAIN),
      'type'         => '{}',
      'name'         => '{}',
      'instructions' => __('{}', TEXT_DOMAIN),
      'wrapper'      => ['width' => {} ],
  ], {}
  ]]
  , {i(1), snakeTitleNode(1), i(2), rep(1), i(3), i(4), i(0)})),

  snippet("rep", fmt(
  [[
  [
      'key'          => self::KEY . '_{}',
      'label'        => __('{}', TEXT_DOMAIN),
      'type'         => 'repeater',
      'name'         => '{}',
      'instructions' => __('{}', TEXT_DOMAIN),
      'button_label' => __('{}', TEXT_DOMAIN),
      'wrapper'      => ['width' => {} ],
      'sub_fields' => [
        {}
      ],
  ],
  ]]
  , {i(1), snakeTitleNode(1), rep(1), i(2), i(3), i(4), i(0)}))
}

------------------------------------
--------------- ALL ----------------
------------------------------------
local all_snips = {
  -- This one is rendered obsolete by the iabbrev command I'm using instead
  -- snippet("TODO", fmt("TODO (Jake Mason - {})", {os.date("%x")})),
}

local opts = {}
opts['override_priority'] = 1001; -- default is 1000 and we always want our custom ones first
-- ls.add_snippets("all", all_snips, opts)
ls.add_snippets("css", css_snips, opts)
ls.add_snippets("scss", css_snips, opts)
ls.add_snippets("html", twig_snips, opts)
ls.add_snippets("twig", twig_snips, opts)
ls.add_snippets("c", c_cpp_snips, opts)
ls.add_snippets("cpp", c_cpp_snips, opts)
ls.add_snippets("php", php_snips, opts)
ls.add_snippets("javascript", js_snips, opts)
ls.add_snippets("zig", zig_snips, opts)
