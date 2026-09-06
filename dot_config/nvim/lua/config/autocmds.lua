-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Ensure undercurl is applied after colorscheme loads
-- colors from palette in https://github.com/maxmx03/solarized.nvim/blob/main/lua/solarized/palette/solarized-light.lua
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd.highlight("DiagnosticUnderlineError guisp=#DC322F gui=undercurl")
    vim.cmd.highlight("DiagnosticUnderlineWarn guisp=#B58900 gui=undercurl")
    vim.cmd.highlight("DiagnosticUnderlineInfo guisp=#268BD2 gui=undercurl")
    vim.cmd.highlight("DiagnosticUnderlineHint guisp=#268BD2 gui=undercurl")
    vim.cmd.highlight("SpellBad guisp=#B58900 gui=undercurl")
    vim.cmd.highlight("SpellCap guisp=#268BD2 gui=undercurl")
    vim.cmd.highlight("SpellLocal guisp=#B58900 gui=undercurl")
    vim.cmd.highlight("SpellRare guisp=#2AA198 gui=undercurl")
  end,
})
