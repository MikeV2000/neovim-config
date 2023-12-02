local M = {}

M.dap = {
  n = {
    ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Debug: Toggtle Breakpoint" },
    ["<leader>dB"] = { "<cmd> DapSetBreakpoint <CR>", "Debug: Set Breakpoint" },
    ["<F5>"] = { "<cmd> DapContinue <CR>", "Debug: Start/Continue" },
    ["<F1>"] = { "<cmd> DapStepInto <CR>", "Debug: Step Into" },
    ["<F2>"] = { "<cmd> DapStepOver <CR>", "Debug: Step Over" },
    ["<F3>"] = { "<cmd> DapStepOut <CR>", "Debug: Step Out" },
    ["<F7>"] = { "<cmd> DapUIToggle <CR>", "Debug: See last session result" },
  },
}

M.jdtls = {
  n = {
    ["<leader>dr"] = {
      function()
        require("jdtls").test_nearest_method()
      end,
    },
  },
}

M.vimtex = {
  n = {
    ["<leader>ll"] = { "<cmd> VimtexCompile <CR>", "Vimtex Compile" },
  },
}

return M
