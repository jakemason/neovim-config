local M = {}

function M.run(build_path)
  vim.opt.makeprg = build_path
  vim.notify("Executing build @ " .. build_path .. "...", vim.log.levels.INFO)

  -- silent make, preserve old behavior
  pcall(vim.cmd, "silent make")
  vim.cmd("redraw!")
end

return M
