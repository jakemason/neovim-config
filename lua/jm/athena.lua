local M = {}

function M.run(build_path)
  vim.opt.makeprg = build_path

  vim.notify(
    "Executing build @ " .. build_path .. "...",
    vim.log.levels.INFO,
    { title = "Build" }
  )

  local ok, command_error = pcall(vim.cmd, "silent make")
  local exit_code = vim.v.shell_error

  vim.cmd("redraw!")

  if ok and exit_code == 0 then
    vim.notify(
      "Build completed.",
      vim.log.levels.INFO,
      { title = "Build" }
    )
    return
  end

  local details = {}

  if not ok then
    table.insert(details, tostring(command_error))
  else
    local quickfix_items = vim.fn.getqflist()

    for _, item in ipairs(quickfix_items) do
      local text = vim.trim(item.text or "")

      if text ~= "" then
        local location = ""

        if item.bufnr and item.bufnr > 0 then
          local filename = vim.api.nvim_buf_get_name(item.bufnr)

          if filename ~= "" then
            location = vim.fn.fnamemodify(filename, ":~:.")
          end
        end

        if item.lnum and item.lnum > 0 then
          location = location .. ":" .. item.lnum

          if item.col and item.col > 0 then
            location = location .. ":" .. item.col
          end
        end

        if location ~= "" then
          table.insert(details, location .. ": " .. text)
        else
          table.insert(details, text)
        end

        -- Keep the notification reasonably small.
        if #details >= 5 then
          break
        end
      end
    end
  end

  local message = "Build failed with exit code " .. exit_code .. "."

  if #details > 0 then
    message = message .. "\n\n" .. table.concat(details, "\n")
  else
    message = message .. "\n\nRun :copen to inspect the build output."
  end

  vim.notify(
    message,
    vim.log.levels.ERROR,
    { title = "Build Error" }
  )
end

return M
