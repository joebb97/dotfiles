local options = {
    autoindent = true,
    autowrite = true,
    backup = false,
    backspace = 'indent,eol,start',
    clipboard = 'unnamedplus',
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    cursorline = true,
    expandtab = true,
    foldenable = true,
    foldlevelstart = 10,
    foldmethod = 'indent',
    hlsearch = false,
    incsearch = true,
    laststatus = 2,
    lazyredraw = true,
    linebreak = true,
    list = false,
    mouse = 'a',
    number = true,
    numberwidth = 2,
    relativenumber = true,
    -- scrolloff = 8,
    shiftwidth = 4,
    showcmd = true,
    showmatch = true,
    -- sidescrolloff = 8 -- when wrap is false, horiz version of scrolloff
    smartindent = true,
    softtabstop = 4,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 4,
    termguicolors = true,
    ttimeoutlen = 50,
    updatetime = 50,
    -- undofile = true, -- enables undoing things after closing vim
    wildmenu = true,
    wrap = true,
}
if vim.fn.has('nvim-0.5') then
    options.signcolumn = "number"
else
    options.signcolumn = "auto"
end

if vim.fn.exists("+colorcolumn") then
    options.colorcolumn = "100"
end

for k,v in pairs(options) do
    vim.opt[k] = v
end
vim.opt.path:append("**")
vim.opt.shortmess:append("c")
-- vim.opt.listchars = {eol = '↲', tab = '▸ ', trail = '·'}

vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
vim.g.netrw_banner = 0
-- from https://github.com/LunarVim/Neovim-from-scratch/blob/02-keymaps/lua/user/options.lua
-- vim.cmd "set whichwrap+=<,>,[,],h,l"
-- vim.cmd [[set iskeyword+=-]]
-- vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
