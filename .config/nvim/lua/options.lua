local options = {
    autowrite = true,
    autoindent = true,
    backup = false,
    backspace = 'indent,eol,start',
    clipboard = 'unnamedplus',
    cursorline = true,
    expandtab = true,
    foldenable = true,
    foldlevelstart = 10,
    foldmethod = 'indent',
    incsearch = true,
    laststatus = 2,
    lazyredraw = true,
    linebreak = true,
    list = false,
    mouse = 'a',
    number = true,
    relativenumber = true,
    shiftwidth = 4,
    showcmd = true,
    showmatch = true,
    smartindent = true,
    softtabstop = 4,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 4,
    ttimeoutlen = 50,
    updatetime = 50,
    wildmenu = true,
    wrap = true,
}
if vim.fn.has('nvim-0.5') then
    options.signcolumn = "number"
else
    options.signcolumn = "auto"
end

for k,v in pairs(options) do
    vim.opt[k] = v
end
vim.opt.path:append("**")
vim.opt.shortmess:append("c")
-- vim.opt.listchars = {eol = '↲', tab = '▸ ', trail = '·'}
