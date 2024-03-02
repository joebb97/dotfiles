-- [[ Keymap / Remap ]]
local function configure_keymaps()
    local opts = { noremap = true, silent = true }
    vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', opts)
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ' '

    -- Use these if using nvim-tree
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.keymap.set('i', 'jj', '<ESC>', opts)

    -- NNOREMAP
    vim.keymap.set('n', '<C-s>', ':w<CR>', opts)
    vim.keymap.set('n', 'gV', '`[v`]', opts)
    vim.keymap.set({ 'v', 'n' }, 'gh', '0', opts)
    vim.keymap.set({ 'v', 'n' }, 'gl', '$', opts)
    vim.keymap.set({ 'v', 'n' }, 'gs', '^', opts)
    vim.keymap.set('n', ',', 'za', opts)
    vim.keymap.set('n', '<C-h>', ':bp<CR>', opts)
    vim.keymap.set('n', '<C-l>', ':bn<CR>', opts)
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
    vim.keymap.set('n', 'q:', '<Nop>', opts)
    vim.keymap.set('n', '<C-g>t', ':ToggleTerm<CR>', opts)
    vim.keymap.set('n', '<C-g><C-t>', ':ToggleTerm<CR>', opts)

    -- VNOREMAP
    vim.keymap.set('v', 'K', ':m .-2<CR>==', opts)
    vim.keymap.set('v', 'J', ':m .+1<CR>==', opts)
    vim.keymap.set('v', '<', '<gv', opts)
    vim.keymap.set('v', '>', '>gv', opts)

    -- XNOREMAP
    vim.keymap.set('x', 'J', [[:move '>+1<CR>gv-gv]], opts)
    vim.keymap.set('x', 'K', [[:move '<-2<CR>gv-gv]], opts)

    -- TNOREMAP
    vim.keymap.set('t', '<C-g>v', '<C-\\><C-N>:vsp +term<CR>', opts)
    vim.keymap.set('t', '<C-g>%', '<C-\\><C-N>:vsp +term<CR>', opts)
    vim.keymap.set('t', '<C-g>s', '<C-\\><C-N>:sp +term<CR>', opts)
    vim.keymap.set('t', '<C-g>"', '<C-\\><C-N>:sp +term<CR>', opts)
    vim.keymap.set('t', '<C-g>c', '<C-\\><C-N>:tabe<CR>:term<CR>', opts)
    vim.keymap.set('t', '<C-g>n', '<C-\\><C-N>gt', opts)
    vim.keymap.set('t', '<C-g>p', '<C-\\><C-N>gT', opts)
    vim.keymap.set('t', '<C-g>t', '<C-\\><C-N>:ToggleTerm<CR>', opts)
    vim.keymap.set('t', '<C-g><C-t>', '<C-\\><C-N>:ToggleTerm<CR>', opts)

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
    vim.keymap.set('n', '<leader>w', ':w<CR>', opts)
    vim.keymap.set('n', '<leader>q', ':q<CR>', opts)
    vim.keymap.set('n', '<leader>m', ':make<CR>', opts)
    vim.keymap.set('n', '<leader>z', '<C-w>\\|<C-w>_', opts)
    vim.keymap.set('n', '<leader>x', '<C-w>=', opts)
    vim.keymap.set('n', '<leader>sa', ':Save<CR>', opts)
    vim.keymap.set('n', '<leader>sv', ':Svrc<CR>', opts)
    vim.keymap.set('n', '<leader>ev', ':Evrc<CR>', opts)
    vim.keymap.set('n', '<leader>eb', ':Ebrc<CR>', opts)
    vim.keymap.set('n', '<leader>ef', ':Efc<CR>', opts)
    vim.keymap.set('n', '<leader>en', ':Enc<CR>', opts)
    vim.keymap.set('n', '<leader>ex', ':qa<CR>', opts)
    vim.keymap.set('n', '<leader>,', ':noh<CR>', opts)
    vim.keymap.set('n', '<leader>bl', '$A{<CR>}<ESC>O', opts)
    vim.keymap.set('n', '<leader>bs', '$A<CR>{<CR>}<ESC>O', opts)
    vim.keymap.set('n', '<leader>nill', 'oif err != nil {<CR>return err<CR>}<ESC>', opts)
    vim.keymap.set('n', '<leader>nili', 'oif err != nil {<CR>}<ESC>O', opts)
    vim.keymap.set('n', '<leader>nilt', 'oif err != nil {<CR>return nil, err<CR>}<ESC>', opts)
    vim.keymap.set('n', '<leader>cc', ':cclose<CR>', opts)
    vim.keymap.set('n', '<leader>co', ':copen<CR>', opts)
    vim.keymap.set('n', '<C-Right>', ':cn<CR>', opts)
    vim.keymap.set('n', '<C-Left>', ':cp<CR>', opts)
    vim.keymap.set('n', '<leader>te', ':tabe<CR>', opts)

    -- PLUGIN SPECIFIC LEADERS
    vim.keymap.set('n', '<leader>gg', ':Gitsigns toggle_signs<CR>', opts)
    vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', opts)
    vim.keymap.set('n', '<leader>so', ':SymbolsOutline<CR>', opts)
    vim.keymap.set('n', '<leader>nt', ':NvimTreeToggle<CR>', opts)
    vim.keymap.set('n', '<leader>nf', ':NvimTreeFindFile<CR>', opts)
    vim.keymap.set('n', '<leader>tt', ':ToggleTerm direction=float<CR>', opts)
    vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal<CR>', opts)
    vim.keymap.set('n', '<leader>ta', ':ToggleTerm direction=tab<CR>', opts)
    vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical<CR>', opts)

    -- COMMAND
    vim.api.nvim_create_user_command('Svrc', ':source $MYVIMRC', {})
    vim.api.nvim_create_user_command('Save', ':mksession!', {})
    vim.api.nvim_create_user_command('Evrc', ':e $HOME/.vimrc', {})
    vim.api.nvim_create_user_command('Ebrc', ':e $HOME/.bashrc', {})
    vim.api.nvim_create_user_command('Egcfg', ':e $HOME/.gitconfig', {})
    vim.api.nvim_create_user_command('Efc', ':e $HOME/.config/fish/config.fish', {})
    vim.api.nvim_create_user_command('Enc', ':e $HOME/.config/nvim/init.lua', {})
end

-- [[ Options ]]
local function configure_options()
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
        scrolloff = 0,
        shiftwidth = 4,
        showcmd = true,
        showmatch = true,
        -- sidescrolloff = 8 -- when wrap is false, horiz version of scrolloff
        smartindent = true,
        signcolumn = 'yes',
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

    if vim.fn.exists("+colorcolumn") == 1 then
        options.colorcolumn = "100"
    end

    for k, v in pairs(options) do
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

    local colorscheme = 'dracula'
    local special_schemes = {
        -- style can be default, atlantis, andromeda, shusia, maia
        -- no scheme_background or sys_background for sonokai
        sonokai = { style = 'default' },
        -- style can be default, aura and neon
        -- no scheme_background for edge, but has sys_background
        edge = { style = 'neon' },
        -- no style for everforest
        -- scheme_background can be hard, medium, soft
        -- sys_background can be light or dark
        everforest = { scheme_background = 'hard', sys_background = 'dark' },
        -- style can be default, mix, or original
        -- scheme_background and sys_background are same as everforest
        ['gruvbox-material'] = {
            style = 'original',
            scheme_background = 'hard',
            sys_background = 'dark'
        }
    }
    if special_schemes[colorscheme] ~= nil then
        local prefix = colorscheme:gsub("-", "_")
        vim.g[prefix .. '_diagnostic_virtual_text'] = 'colored'
        vim.g[prefix .. '_diagnostic_text_highlight'] = 1
        vim.g[prefix .. '_diagnostic_line_highlight'] = 1
        vim.g[prefix .. '_better_performance'] = 1
        vim.g[prefix .. '_transparent_background'] = 0
        local style = special_schemes[colorscheme].style
        local scheme_background = special_schemes[colorscheme].scheme_background
        local sys_background = special_schemes[colorscheme].sys_background
        if style ~= nil then
            vim.g[prefix .. '_style'] = style
        end
        if scheme_background ~= nil then
            vim.g[prefix .. '_background'] = scheme_background
        end
        if sys_background ~= nil then
            vim.opt['background'] = sys_background
        end
    end
    vim.cmd("colorscheme " .. colorscheme)
    vim.cmd [[setlocal spell spelllang=en_us]]
    vim.cmd [[ set nospell ]]
end

-- [[ Autocmd ]]
local function configure_autocmds()
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

    local salt_group = vim.api.nvim_create_augroup('Salt', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        command = 'set syntax=yaml',
        group = salt_group,
        pattern = '*.sls'
    })
end

-- [[ LSP settings. ]]
local function configure_lsp()
    -- Diagnostic keymaps
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>of', vim.diagnostic.open_float)
    vim.keymap.set('n', '<leader>sl', vim.diagnostic.setloclist)
    vim.keymap.set('n', '<leader>sq', vim.diagnostic.setqflist)

    --  This function gets run when an LSP connects to a particular buffer.
    local function on_attach(client, bufnr)
        -- vim.notify(client, bufnr)
        -- local bname = vim.api.nvim_buf_get_name(bufnr)
        -- local is_cargo_git = bname:find(".cargo/git") ~= nil
        -- local is_cargo_reg = bname:find(".cargo/registry") ~= nil
        -- vim.notify(bname, is_cargo_git, is_cargo_reg, is_cargo_git or is_cargo_reg)
        -- if is_cargo_reg or is_cargo_git then
        --     print("detaching cargo thingy")
        --     -- vim.lsp.buf_detach_client(bufnr, client)
        --     return
        -- end
        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end

            vim.keymap.set({ 'n', 'v' }, keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>dw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<leader>sk', vim.lsp.buf.signature_help, 'Signature Documentation')

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
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format()
                end,
            })
        end
        require('lsp-inlayhints').on_attach(client, bufnr)
    end

    local servers = {
        clangd = {},
        rust_analyzer = {
            ["rust-analyzer"] = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                -- diagnostics = {
                --     enable = true,
                --     disabled = { "unresolved-proc-macro" },
                --     experimental = {
                --         enable = true
                --     }
                -- },
                -- cargo = {
                -- -- sometimes causes build scripts to fail, but might be useful ?
                -- features = "all"
                -- },
                check = {
                    command = "clippy"
                },
                procMacro = {
                    enable = true
                },
                files = {
                    excludeDirs = { "~/.cargo/git" },
                }
            },
        },
        gopls = {
            gopls = {
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
            }
        },
        pyright = {},
        -- tsserver = {},
        -- TODO: Make this install linters, and also use linters, null-ls.nvim???
        lua_ls = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
                hint = {
                    enable = true
                }
            },
        },
    }

    require('neodev').setup({
        library = { plugins = { 'nvim-dap-ui' }, types = true }
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    require('mason').setup()

    local mason_lspconfig = require 'mason-lspconfig'
    local lspconfig = require 'lspconfig'

    mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
        function(server_name)
            lspconfig[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
            }
        end,
    }
end

-- [[ Completions ]]
local function configure_completion()
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
            ['<C-s>'] = cmp.mapping.complete(),
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
                    -- elseif luasnip.expand_or_jumpable() then
                    --     luasnip.expand_or_jump()
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
                    -- elseif luasnip.jumpable(-1) then
                    --     luasnip.jump(-1)
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
        enabled = function()
            local in_prompt = vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt'
            if in_prompt then -- this will disable cmp in the Telescope window (taken from the default config)
                return false
            end
            local context = require("cmp.config.context")
            return not (context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
        end
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
end

-- [[ Configure Telescope ]]
local function configure_telescope()
    -- See `:help telescope` and `:help telescope.setup()`
    local actions = require "telescope.actions"
    require('telescope').setup {
        defaults = {
            mappings = {
                i = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                    ['<C-f>'] = actions.preview_scrolling_down,
                    ['<C-b>'] = actions.preview_scrolling_up,
                    ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    ["<C-q>"] = actions.send_to_qflist,
                    ["<C-l>"] = actions.delete_buffer
                },
                n = {
                    ['q'] = actions.close,
                    ['C-c'] = actions.close,
                    ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    ["<C-u>"] = actions.results_scrolling_up,
                    ["<C-d>"] = actions.results_scrolling_down,
                    ['<C-f>'] = actions.preview_scrolling_down,
                    ['<C-b>'] = actions.preview_scrolling_up,
                    ["<C-q>"] = actions.send_to_qflist,
                    ["<C-l>"] = actions.delete_buffer
                }
            },
            file_ignore_patterns = { "^vendor/" }
        },
    }

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'file_browser')
    local builtin = require('telescope.builtin')
    local themes = require('telescope.themes')

    -- See `:help telescope.builtin`
    vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    vim.keymap.set('n', '<leader>bu', function() builtin.buffers({ sort_lastused = true }) end,
        { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(themes.get_dropdown {
            -- winblend = 10,
            previewer = false,
        })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
end

local function configure_treesitter()
    require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },
        auto_install = false,
        autopairs = { enable = true },
        highlight = { enable = true },
        indent = { enable = true, disable = { 'python' } },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<A-o>',
                node_incremental = '<A-o>',
                scope_incremental = '<A-a>',
                node_decremental = '<A-i>',
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ['aa'] = '@parameter.outer',
                    ['ia'] = '@parameter.inner',
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ['<leader>a'] = '@parameter.inner',
                },
                swap_previous = {
                    ['<leader>A'] = '@parameter.inner',
                },
            },
        },
    }
end

configure_keymaps()
require("plugins")
configure_options()
configure_autocmds()
configure_lsp()
configure_completion()
configure_telescope()
configure_treesitter()

-- Followed a mixture of:
-- https://github.com/nvim-lua/kickstart.nvim/tree/master
-- https://github.com/LunarVim/Neovim-from-scratch
