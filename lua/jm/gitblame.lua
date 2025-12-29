-- Inline git blame (parity with old init.vim behavior)
vim.g.gitblame_enabled = 1
vim.g.gitblame_date_format = "%b %Y"
vim.g.gitblame_message_template = "<author>, <date> • <summary>"
vim.g.gitblame_highlight_group = "Comment"

-- Optional: keep it inline, not virtual text
vim.g.gitblame_virtual_text = false
