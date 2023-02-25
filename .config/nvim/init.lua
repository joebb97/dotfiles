require("plugins")

-- [[ Keymap / Remap ]]
local opts = { noremap = true, silent = true}
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- INOREMAP
vim.keymap.set('i', '<C-J>', '<ESC><C-W><C-J>', opts)
vim.keymap.set('i', '<C-K>', '<ESC><C-W><C-K>', opts)
vim.keymap.set('i', '<C-L>', '<ESC><C-W><C-L>', opts)
vim.keymap.set('i', '<C-H>', '<ESC><C-W><C-H>', opts)
vim.keymap.set('i', 'hh', '<ESC>', opts)

-- NNOREMAP
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', opts)
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', opts)
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', opts)
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', opts)
-- vim.keymap.set('n', '<space>', 'za', opts)
vim.keymap.set('n', 'j', 'gj', opts)
vim.keymap.set('n', 'k', 'gk', opts)
vim.keymap.set('n', 'gV', '`[v`]', opts)
vim.keymap.set('n', '<C-g>v', ':vsp +term<CR>', opts)
vim.keymap.set('n', '<C-g>%', ':vsp +term<CR>', opts)
vim.keymap.set('n', '<C-g>s', ':sp +term<CR>', opts)
vim.keymap.set('n', '<C-g>"', ':sp +term<CR>', opts)
vim.keymap.set('n', '<C-g>c', ':tabe<CR>:term<CR>', opts)
vim.keymap.set('n', '<C-g>n', 'gt', opts)
vim.keymap.set('n', '<C-g>p', 'gT', opts)
vim.keymap.set('n', '<C-g>h', '<C-W><C-h>', opts)
vim.keymap.set('n', '<C-g>j', '<C-W><C-j>', opts)
vim.keymap.set('n', '<C-g>k', '<C-W><C-k>', opts)
vim.keymap.set('n', '<C-g>l', '<C-W><C-l>', opts)
vim.keymap.set('n', '<C-g><C-H>', '<C-W><C-h>', opts)
vim.keymap.set('n', '<C-g><C-J>', '<C-W><C-j>', opts)
vim.keymap.set('n', '<C-g><C-K>', '<C-W><C-k>', opts)
vim.keymap.set('n', '<C-g><C-L>', '<C-W><C-l>', opts)
vim.keymap.set('n', '<CS-l>', 'gt', opts)
vim.keymap.set('n', '<CS-h>', 'gT', opts)

-- VNOREMAP
vim.keymap.set('v', 'K', ':m .-2<CR>==', opts)
vim.keymap.set('v', 'J', ':m .+1<CR>==', opts)
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- XNOREMAP
vim.keymap.set('x' ,'J', [[:move '>+1<CR>gv-gv]], opts)
vim.keymap.set('x' ,'K', [[:move '<-2<CR>gv-gv]], opts)

-- TNOREMAP
vim.keymap.set('t', '<C-g>v', '<C-\\><C-N>:vsp +term<CR>', opts)
vim.keymap.set('t', '<C-g>%', '<C-\\><C-N>:vsp +term<CR>', opts)
vim.keymap.set('t', '<C-g>s', '<C-\\><C-N>:sp +term<CR>', opts)
vim.keymap.set('t', '<C-g>"', '<C-\\><C-N>:sp +term<CR>', opts)
vim.keymap.set('t', '<C-g>c', '<C-\\><C-N>:tabe<CR>:term<CR>', opts)
vim.keymap.set('t', '<C-g>n', '<C-\\><C-N>gt', opts)
vim.keymap.set('t', '<C-g>p', '<C-\\><C-N>gT', opts)

vim.keymap.set('t', '<C-g>h', '<C-\\><C-N><C-w>h', opts)
vim.keymap.set('t', '<C-g>j', '<C-\\><C-N><C-w>j', opts)
vim.keymap.set('t', '<C-g>k', '<C-\\><C-N><C-w>k', opts)
vim.keymap.set('t', '<C-g>l', '<C-\\><C-N><C-w>l', opts)
vim.keymap.set('t', '<C-g><C-h>', '<C-\\><C-N><C-w>h', opts)
vim.keymap.set('t', '<C-g><C-j>', '<C-\\><C-N><C-w>j', opts)
vim.keymap.set('t', '<C-g><C-k>', '<C-\\><C-N><C-w>k', opts)
vim.keymap.set('t', '<C-g><C-l>', '<C-\\><C-N><C-w>l', opts)

-- LEADER KEY
vim.keymap.set('n', '<leader>st', ':sp +term<CR>', opts)
vim.keymap.set('n', '<leader>sp', ':sp<CR>', opts)
vim.keymap.set('n', '<leader>vt', ':vsp +term<CR>', opts)
vim.keymap.set('n', '<leader>vs', ':vs<CR>', opts)
-- vim.keymap.set('n', '<leader>rnw', ":! rscript -e \"library(\'knitr\');knit2pdf(\'$(ls *.Rnw)\')\"<CR>", opts)
vim.keymap.set('n', '<leader>w', ':w<CR>', opts)
vim.keymap.set('n', '<leader>q', ':q<CR>', opts)
vim.keymap.set('n', '<leader>m', ':make<CR>', opts)
vim.keymap.set('n', '<leader>j', 'Lzt', opts)
vim.keymap.set('n', '<leader>k', 'Hzb', opts)
vim.keymap.set('n', '<leader>z', '<C-w>\\|<C-w>_', opts)
vim.keymap.set('n', '<leader>x', '<C-w>=', opts)
vim.keymap.set('n', '<leader>sa', ':Save<CR>', opts)
vim.keymap.set('n', '<leader>sv', ':Svrc<CR>', opts)
vim.keymap.set('n', '<leader>ev', ':Evrc<CR>', opts)
vim.keymap.set('n', '<leader>eb', ':Ebrc<CR>', opts)
vim.keymap.set('n', '<leader>ef', ':Efc<CR>', opts)
vim.keymap.set('n', '<leader>en', ':Enc<CR>', opts)
vim.keymap.set('n', '<leader>ex', ':qa<CR>', opts)
vim.keymap.set('n', '<leader><space>', ':noh<CR>', opts)
vim.keymap.set('n', '<leader>bl', '$A{<CR>}<ESC>O', opts)
vim.keymap.set('n', '<leader>bs', '$A<CR>{<CR>}<ESC>O', opts)
vim.keymap.set('n', '<leader>nill', 'oif err != nil {<CR>return err<CR>}<ESC>', opts)
vim.keymap.set('n', '<leader>nili', 'oif err != nil {<CR>}<ESC>O', opts)
vim.keymap.set('n', '<leader>nilt', 'oif err != nil {<CR>return nil, err<CR>}<ESC>', opts)
vim.keymap.set('n', '<leader>pl', ':Vex 30<CR>', opts)
vim.keymap.set('n', '<leader>pe', ':Ex<CR>', opts)
vim.keymap.set('n', '<leader>h', ':bp<CR>', opts)
vim.keymap.set('n', '<leader>l', ':bn<CR>', opts)
vim.keymap.set('n', '<leader>cc', ':cclose<CR>', opts)
vim.keymap.set('n', '<leader>cn', ':cn<CR>', opts)
vim.keymap.set('n', '<leader>cp', ':cp<CR>', opts)
vim.keymap.set('n', '<leader>te', ':tabe<CR>', opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>of', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>sl', vim.diagnostic.setloclist)

-- PLUGIN SPECIFIC LEADERS
vim.keymap.set('n', '<leader>gg', ':Gitsigns toggle_signs<CR>', opts)

-- COMMAND
vim.api.nvim_create_user_command('Svrc', ':source $MYVIMRC', {})
vim.api.nvim_create_user_command('Save', ':mksession!', {})
vim.api.nvim_create_user_command('Evrc', ':e $HOME/.vimrc', {})
vim.api.nvim_create_user_command('Ebrc', ':e $HOME/.bashrc', {})
vim.api.nvim_create_user_command('Egcfg', ':e $HOME/.gitconfig', {})
vim.api.nvim_create_user_command('Efc', ':e $HOME/.config/fish/config.fish', {})
vim.api.nvim_create_user_command('Enc', ':e $HOME/.config/nvim/init.lua', {})

-- [[ Options ]]
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

-- [[ Autocmd ]]
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

-- [[ LSP settings. ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)

    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    -- nmap('<leader>vds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    -- nmap('<leader>vws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<leader>sd', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>vwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>vwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>vwl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    rust_analyzer = {
        diagnostics = {
            enable = true,
            disabled = {"unresolved-proc-macro"},
            enableExperimental = true,
        }
    },
    -- tsserver = {},

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
}

-- [[ Completions ]]
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    vim.notify.Err("Couldn't require cmp")
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    vim.notify.Err("Couldn't require luasnip")
    return
end
luasnip.config.setup() -- not sure if needed

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- {"i", "c"} are omitted here, dunno why
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
         -- Accept currently selected item.
         -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({
            select = true,
            -- behavior = cmp.ConfirmBehavior.Replace, -- from kickstart.nvim
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            -- Added in lunar vim tutorial, maybe delete later
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        -- Can also move the 'buffer' and 'path' ones here to always be shown
    }, {
        { name = 'buffer' },
        { name = 'path' }
    }),
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
