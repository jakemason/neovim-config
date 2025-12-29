-- ============================================================================
-- DAP + DAP UI (parity)
-- ============================================================================

local dap = require("dap")
local dapui = require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Start debugging" })
vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Step over" })
vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Step into" })
vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Step out" })
vim.keymap.set("n", "<Leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })

dapui.setup()

pcall(function()
  require("dap-vscode-js").setup({
    debugger_path = (os.getenv("HOME") or "") .. "/debuggers/vscode-js-debug/",
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
  })

  for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
      {
        name = "Launch Yarn",
        type = "pwa-node",
        request = "launch",
        cwd = "${workspaceFolder}",
        runtimeExecutable = "yarn",
        args = { "run", "dev" },
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
        outFiles = { "${workspaceFolder}/dist/**/*.js" },
        skipFiles = { "${workspaceFolder}/node_modules/**/*.js", "<node_internals>/**" },
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
  end
end)
