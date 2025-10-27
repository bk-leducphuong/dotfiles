-- TypeScript LSP Health Check
-- Run with :checkhealth typescript-custom

local M = {}

M.check = function()
  vim.health.start("TypeScript LSP Memory Optimization")
  
  -- Check if ts_ls is configured
  local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
  if lspconfig_ok then
    vim.health.ok("nvim-lspconfig is installed")
  else
    vim.health.error("nvim-lspconfig is not installed")
    return
  end
  
  -- Check if TypeScript server is running
  local clients = vim.lsp.get_active_clients()
  local ts_client = nil
  for _, client in ipairs(clients) do
    if client.name == "ts_ls" or client.name == "tsserver" then
      ts_client = client
      break
    end
  end
  
  if ts_client then
    vim.health.ok("TypeScript LSP is running (client: " .. ts_client.name .. ")")
    
    -- Check memory settings
    if ts_client.config.init_options and ts_client.config.init_options.maxTsServerMemory then
      local mem = ts_client.config.init_options.maxTsServerMemory
      vim.health.ok("Memory limit configured: " .. mem .. "MB")
      
      if mem < 3072 then
        vim.health.warn("Memory limit is low (" .. mem .. "MB). Consider increasing to 4096MB for large projects")
      end
    else
      vim.health.warn("No memory limit configured. TypeScript server may use unlimited RAM")
      vim.health.info("Add 'maxTsServerMemory' to init_options in LSP config")
    end
    
    -- Check inlay hints
    if ts_client.config.init_options and ts_client.config.init_options.preferences then
      local prefs = ts_client.config.init_options.preferences
      if prefs.includeInlayParameterNameHints == "none" then
        vim.health.ok("Inlay hints disabled (saves memory)")
      else
        vim.health.warn("Inlay hints enabled. This uses extra memory")
        vim.health.info("Set includeInlayParameterNameHints to 'none' to save memory")
      end
    end
  else
    vim.health.info("TypeScript LSP is not currently running")
    vim.health.info("Open a TypeScript file to start the server")
  end
  
  -- Check for project tsconfig
  local cwd = vim.fn.getcwd()
  local tsconfig_path = cwd .. "/tsconfig.json"
  
  if vim.fn.filereadable(tsconfig_path) == 1 then
    vim.health.ok("tsconfig.json found in project root")
    
    -- Check for service-specific configs
    local service_configs = vim.fn.glob(cwd .. "/tsconfig.*.json", false, true)
    if #service_configs > 0 then
      vim.health.ok("Found " .. #service_configs .. " service-specific tsconfig files")
      vim.health.info("Use :TsConfigSwitch to switch between configs")
    else
      vim.health.info("No service-specific configs found")
      vim.health.info("Run ./scripts/generate-service-tsconfigs.sh to create them")
    end
  else
    vim.health.warn("No tsconfig.json in current directory")
  end
  
  -- Check for helper commands
  if vim.fn.exists(":TsConfigSwitch") == 2 then
    vim.health.ok("TsConfigSwitch command available")
  else
    vim.health.warn("TsConfigSwitch command not found")
    vim.health.info("Check if typescript-service-switcher.lua is loaded")
  end
  
  if vim.fn.exists(":TsConfigAuto") == 2 then
    vim.health.ok("TsConfigAuto command available")
  else
    vim.health.warn("TsConfigAuto command not found")
  end
  
  -- Check TypeScript version
  local ts_version = vim.fn.system("npx tsc --version 2>/dev/null")
  if vim.v.shell_error == 0 then
    vim.health.ok("TypeScript version: " .. vim.trim(ts_version))
  else
    vim.health.warn("Could not detect TypeScript version")
  end
  
  -- Memory usage recommendations
  vim.health.start("Memory Optimization Recommendations")
  
  local current_config = vim.g.typescript_tsconfig or "tsconfig.json (default)"
  vim.health.info("Current config: " .. current_config)
  
  if current_config == "tsconfig.json (default)" then
    vim.health.info("Using default config - good for general work")
    vim.health.info("For lower memory usage on specific services:")
    vim.health.info("  1. Run ./scripts/generate-service-tsconfigs.sh")
    vim.health.info("  2. Use <leader>ta to auto-switch")
  end
  
  -- Check system memory
  local total_mem = vim.fn.system("free -m | awk 'NR==2{print $2}'")
  if vim.v.shell_error == 0 then
    total_mem = tonumber(vim.trim(total_mem))
    if total_mem then
      vim.health.info("System total RAM: " .. total_mem .. "MB")
      if total_mem < 8192 then
        vim.health.warn("System has less than 8GB RAM")
        vim.health.info("Consider using service-specific configs to reduce memory usage")
      end
    end
  end
end

return M
