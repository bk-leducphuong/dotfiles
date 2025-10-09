local M = {}

function M.setup_microservices()
  -- Terminal 1: Frontend
  vim.cmd("1ToggleTerm direction=horizontal")
  vim.fn.chansend(vim.b.terminal_job_id, "cd frontend && npm run dev\n")
  
  -- Terminal 2: Backend
  vim.cmd("2ToggleTerm direction=horizontal")
  vim.fn.chansend(vim.b.terminal_job_id, "cd backend && npm run dev\n")
  
  -- Terminal 3: Auth Service
  vim.cmd("3ToggleTerm direction=horizontal")
  vim.fn.chansend(vim.b.terminal_job_id, "cd services/auth && npm start\n")
  
  -- Hide all and go back to editor
  vim.cmd("ToggleTermToggleAll")
end

return M
