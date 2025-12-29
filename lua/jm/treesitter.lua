-- ============================================================================
-- Treesitter (parity)
-- ============================================================================

local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

configs.setup({
  playground = {
    enable = true,
    updatetime = 25,
    persist_queries = false,
  },
  highlight = {
    enable = true,
    disable = function(_, buf)
      local max_filesize = 50 * 1024
      local ok2, stats = pcall((vim.uv or vim.loop).fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok2 and stats and stats.size > max_filesize then
        return true
      end
      return false
    end,
    additional_vim_regex_highlighting = true,
  },
})
