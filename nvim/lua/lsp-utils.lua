-- LSP Performance monitoring utilities

local M = {}

-- Function to get LSP client info
function M.lsp_info()
  local clients = vim.lsp.get_active_clients()
  if #clients == 0 then
    print("No active LSP clients")
    return
  end
  
  print("Active LSP clients:")
  for _, client in ipairs(clients) do
    print(string.format("  %s (id: %d) - %s", client.name, client.id, client.config.cmd[1] or "unknown"))
  end
end

-- Function to restart all LSP clients
function M.restart_lsp()
  local clients = vim.lsp.get_active_clients()
  for _, client in ipairs(clients) do
    vim.lsp.stop_client(client.id)
  end
  vim.cmd('LspStart')
  print("LSP clients restarted")
end

-- Function to stop specific LSP client
function M.stop_lsp_client(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in ipairs(clients) do
    if client.name == name then
      vim.lsp.stop_client(client.id)
      print("Stopped LSP client: " .. name)
      return
    end
  end
  print("LSP client not found: " .. name)
end

-- Create user commands
vim.api.nvim_create_user_command("LspInfo", M.lsp_info, {})
vim.api.nvim_create_user_command("LspRestart", M.restart_lsp, {})
vim.api.nvim_create_user_command("LspStop", function(opts)
  M.stop_lsp_client(opts.args)
end, { nargs = 1 })

-- Performance monitoring
function M.check_memory()
  vim.cmd("!ps aux | grep -E '(jdtls|kotlin|ts_ls|lua_ls)' | grep -v grep")
end

vim.api.nvim_create_user_command("LspMemory", M.check_memory, {})

return M
