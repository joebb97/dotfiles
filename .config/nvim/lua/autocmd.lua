-- No line numbers on term
vim.api.nvim_create_autocmd('TermOpen', {
    command = 'setlocal nonumber norelativenumber'
})

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerSync',
    group = packer_group,
    pattern = 'plugins.lua',
})

-- This seems pointless but if you want it it's here
-- local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
-- vim.api.nvim_create_autocmd('TextYankPost', {
--     callback = function()
--         vim.highlight.on_yank()
--     end,
--     group = highlight_group,
--     pattern = '*',
-- })
