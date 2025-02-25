local api = vim.api

local yankGrp = api.nvim_create_augroup("YankHighligh", { clear = true })

api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})
