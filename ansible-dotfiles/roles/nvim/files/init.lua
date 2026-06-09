local function install_plugins()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)
    local plugins = {
        {
            "dracula/vim",
            name = "dracula",
            priority = 1000,
            init = function()
                -- vim.cmd.colorscheme("dracula")
            end,
        },
        {
            "p00f/alabaster.nvim",
            priority = 1000,
            init = function()
                vim.g.alabaster_dim_comments = true
                vim.cmd.colorscheme("alabaster")
            end,
        },
        { "tpope/vim-commentary" },
        { "tpope/vim-abolish" },
        { "tpope/vim-fugitive" }, -- :Git commands
        { "tpope/vim-rhubarb" }, -- github related commands
        { "tpope/vim-surround" }, -- dealing with quotes and parens
        { "tpope/vim-sleuth" }, -- detect tabs and shiftwidth
        -- {
        --     "folke/which-key.nvim",
        --     event = "VimEnter",
        --     opts = {
        --         presets = {
        --             operators = false,
        --         },
        --     },
        -- },
        {
            "folke/todo-comments.nvim",
            event = "VimEnter",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = { signs = false },
        },
        { "chentoast/marks.nvim", opts = {} },
        {
            "lewis6991/gitsigns.nvim",
            opts = {
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
            },
        },
        { "folke/zen-mode.nvim", opts = {} },
        {
            "nvim-telescope/telescope.nvim",
            event = "VimEnter",
            version = "*",
            dependencies = {
                "nvim-lua/plenary.nvim",
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    build = "make",
                    cond = function()
                        return vim.fn.executable("make") == 1
                    end,
                },
                "nvim-telescope/telescope-ui-select.nvim",
                "nvim-tree/nvim-web-devicons",
            },
            config = configure_telescope,
        },
        -- { "windwp/nvim-autopairs", opts = { break_undo = false } },
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                { "j-hui/fidget.nvim", opts = {} },
                { "folke/neodev.nvim", opts = {} },
                -- { "lvimuser/lsp-inlayhints.nvim", opts = {} },
                { "SmiteshP/nvim-navic", opts = {} },
            },
            config = configure_lsp,
            -- default priority is 50
            -- this needs to load before mason-nvim-dap, because it runs require('mason').setup()
            -- so set it to something higher than 50
            priority = 53,
        },
        {
            "utilyre/barbecue.nvim",
            name = "barbecue",
            version = "*",
            dependencies = {
                "SmiteshP/nvim-navic",
                "nvim-tree/nvim-web-devicons", -- optional dependency
            },
            opts = {
                -- configurations go here
            },
        },
        {
            "mfussenegger/nvim-lint",
            dependencies = {
                "williamboman/mason.nvim",
                "rshkarin/mason-nvim-lint",
            },
            event = { "BufReadPre", "BufNewFile" },
            config = configure_lint,
        },
        {
            "mfussenegger/nvim-dap",
            dependencies = {
                -- Creates a beautiful debugger UI
                "rcarriga/nvim-dap-ui",

                -- Required dependency for nvim-dap-ui
                "nvim-neotest/nvim-nio",

                -- Installs the debug adapters for you
                "williamboman/mason.nvim",
                "jay-babu/mason-nvim-dap.nvim",

                -- Add your own debuggers here
                "leoluz/nvim-dap-go",
            },
            config = configure_dap,
        },
        {
            "stevearc/conform.nvim",
            opts = {
                notify_on_error = true,
                -- format_on_save = nil,
                format_on_save = function(bufnr)
                    -- Disable "format_on_save lsp_fallback" for languages that don't
                    -- have a well standardized coding style. You can add additional
                    -- languages here or re-enable it for the disabled ones.
                    local disable_filetypes = { c = true, cpp = true }
                    return {
                        timeout_ms = 500,
                        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                    }
                end,
                formatters_by_ft = {
                    lua = { "stylua" },
                    -- Conform can also run multiple formatters sequentially
                    -- python = { "isort", "black" },
                    --
                    -- You can use a sub-list to tell conform to run *until* a formatter
                    -- is found.
                    -- javascript = { { "prettierd", "prettier" } },
                    json = { "prettier" },
                    rust = { "rustfmt" },
                },
                formatters = {
                    rustfmt = {
                        options = {
                            -- nightly = true,
                        },
                    },
                },
            },
            init = function()
                vim.api.nvim_create_user_command("Format", function(args)
                    local range = nil
                    if args.count ~= -1 then
                        local end_line =
                            vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                        range = {
                            start = { args.line1, 0 },
                            ["end"] = { args.line2, end_line:len() },
                        }
                    end
                    require("conform").format({ async = true, lsp_fallback = true, range = range })
                end, { range = true })
                vim.keymap.set("n", "<leader>f", function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end)
            end,
        },
        {
            "saghen/blink.cmp",
            dependencies = { "rafamadriz/friendly-snippets" },
            version = "1.*",
            opts = {
                keymap = {
                    preset = "enter",
                    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                    ["<C-e>"] = { "hide", "fallback" },
                    ["<C-y>"] = { "select_and_accept", "fallback" },
                    ["<CR>"] = {
                        function(cmp)
                            return cmp.accept() or cmp.accept({ index = 1 })
                        end,
                        "fallback",
                    },
                    ["<C-s>"] = { "show", "fallback" },

                    ["<Up>"] = { "select_prev", "fallback" },
                    ["<Down>"] = { "select_next", "fallback" },
                    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
                    ["<C-n>"] = { "select_next", "fallback_to_mappings" },

                    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                    ["<C-f>"] = { "scroll_documentation_down", "fallback" },

                    ["<Tab>"] = { "select_next", "fallback" },
                    ["<S-Tab>"] = { "select_prev", "fallback" },
                    ["<C-l>"] = { "snippet_forward", "fallback" },
                    ["<C-h>"] = { "snippet_backward", "fallback" },

                    ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
                },

                appearance = {
                    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                    -- Adjusts spacing to ensure icons are aligned
                    nerd_font_variant = "mono",
                },

                -- (Default) Only show the documentation popup when manually triggered
                completion = { documentation = { auto_show = false } },

                snippets = { preset = "luasnip" },

                -- Default list of enabled providers defined so that you can extend it
                -- elsewhere in your config, without redefining it, due to `opts_extend`
                sources = {
                    default = { "lsp", "snippets", "buffer", "path" },
                },

                cmdline = {
                    keymap = { preset = "cmdline" },
                    sources = function()
                        local cmdtype = vim.fn.getcmdtype()
                        if cmdtype == "/" or cmdtype == "?" then
                            return { "buffer" }
                        end
                        if cmdtype == ":" then
                            return { "path", "cmdline" }
                        end
                        return {}
                    end,
                },

                enabled = function()
                    local function in_comment()
                        local ok, captures = pcall(vim.treesitter.get_captures_at_cursor, 0)
                        if ok and type(captures) == "table" then
                            for _, capture in ipairs(captures) do
                                if type(capture) == "string" and capture:match("comment") then
                                    return true
                                end
                            end
                        end

                        local group = vim.fn.synIDattr(
                            vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1),
                            "name"
                        ) or ""
                        return group == "Comment" or group:match("Comment$") ~= nil
                    end

                    return vim.bo.buftype ~= "prompt" and not in_comment()
                end,

                -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
                -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
                -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
                --
                -- See the fuzzy documentation for more information
                fuzzy = {
                    implementation = "prefer_rust_with_warning",
                    -- sorts = {
                    --     function(a, b)
                    --         if vim.bo.filetype ~= "rust" then
                    --             return
                    --         end

                    --         local kind = vim.lsp.protocol.CompletionItemKind
                    --         local priority = {
                    --             [kind.Struct] = 1,
                    --             [kind.Value] = 2,
                    --         }

                    --         local a_priority = priority[a.kind]
                    --         local b_priority = priority[b.kind]

                    --         if a_priority ~= b_priority then
                    --             return (a_priority or 99) < (b_priority or 99)
                    --         end
                    --     end,
                    --     "score",
                    --     "sort_text",
                    --     "label",
                    -- },
                },
            },
            opts_extend = { "sources.default" },
        },
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = (function()
                -- Build Step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows.
                if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                    return
                end
                return "make install_jsregexp"
            end)(),
            dependencies = {
                {
                    "rafamadriz/friendly-snippets",
                    config = function()
                        require("luasnip.loaders.from_vscode").lazy_load()
                    end,
                },
            },
        },
        -- {
        --     "hrsh7th/nvim-cmp",
        --     -- event = "InsertEnter",
        --     dependencies = {
        --         {
        --             "L3MON4D3/LuaSnip",
        --             version = "v2.*",
        --             build = (function()
        --                 -- Build Step is needed for regex support in snippets.
        --                 -- This step is not supported in many windows environments.
        --                 -- Remove the below condition to re-enable on windows.
        --                 if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
        --                     return
        --                 end
        --                 return "make install_jsregexp"
        --             end)(),
        --             dependencies = {
        --                 {
        --                     "rafamadriz/friendly-snippets",
        --                     config = function()
        --                         require("luasnip.loaders.from_vscode").lazy_load()
        --                     end,
        --                 },
        --             },
        --         },
        --         "saadparwaiz1/cmp_luasnip",
        --         "hrsh7th/cmp-nvim-lsp",
        --         "hrsh7th/cmp-path",
        --         "hrsh7th/cmp-buffer",
        --         "hrsh7th/cmp-cmdline",
        --     },
        --     config = configure_nvim_cmp,
        -- },
        {
            "nvim-treesitter/nvim-treesitter",
            lazy = false,
            build = ":TSUpdate",
            config = configure_treesitter,
        },
        -- Trying out devcontainer solutions
        {
            "https://codeberg.org/esensar/nvim-dev-container",
            dependencies = "nvim-treesitter/nvim-treesitter",
            opts = {},
        },
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            config = configure_treesitter_textobjects,
        },
        {
            "jedrzejboczar/devcontainers.nvim",
            dependencies = {
                "miversen33/netman.nvim", -- optional to browse files in docker container
            },
            opts = {},
        },
        -- disabled for vim deprecated warning
        -- {
        --     "simrat39/symbols-outline.nvim",
        --     opts = {
        --         width = 15,
        --         position = "top",
        --     },
        -- },
        {
            "nvim-tree/nvim-tree.lua",
            dependencies = {
                "nvim-tree/nvim-web-devicons",
            },
            opts = {
                view = { relativenumber = true },
                filters = {
                    dotfiles = false,
                },
            },
        },
        { "khaveesh/vim-fish-syntax" },
        {
            "akinsho/toggleterm.nvim",
            version = "*",
            config = true,
        },
        { "mbbill/undotree" },
        { "hashivim/vim-terraform" },
        {
            "mg979/vim-visual-multi",
            branch = "master",
            config = function()
                vim.g.VM_theme = "neon"
            end,
        },
        -- {
        --     "m4xshen/hardtime.nvim",
        --     dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        --     opts = {
        --         disable_mouse = false,
        --     },
        -- },
    }
    require("lazy").setup(plugins)
end

local function configure_keymaps()
    local opts = { noremap = true, silent = true }
    vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", opts)
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    -- Use these if using nvim-tree
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.keymap.set("i", "jj", "<ESC>", opts)

    -- NNOREMAP
    vim.keymap.set("n", "<C-s>", ":w<CR>", opts)
    vim.keymap.set("n", "gV", "`[v`]", opts)
    vim.keymap.set({ "v", "n" }, "gh", "0", opts)
    vim.keymap.set({ "v", "n" }, "gl", "$", opts)
    vim.keymap.set({ "v", "n" }, "gs", "^", opts)
    vim.keymap.set("n", ",", "za", opts)
    vim.keymap.set("n", "<C-h>", ":bp<CR>", opts)
    vim.keymap.set("n", "<C-l>", ":bn<CR>", opts)
    vim.keymap.set("n", "<C-g>v", ":vsp +term<CR>", opts)
    vim.keymap.set("n", "<C-g>%", ":vsp +term<CR>", opts)
    vim.keymap.set("n", "<C-g>s", ":sp +term<CR>", opts)
    vim.keymap.set("n", '<C-g>"', ":sp +term<CR>", opts)
    vim.keymap.set("n", "<C-g>c", ":tabe<CR>:term<CR>", opts)
    vim.keymap.set("n", "<C-g>n", "gt", opts)
    vim.keymap.set("n", "<C-g>p", "gT", opts)
    vim.keymap.set("n", "<C-g>h", "<C-W><C-h>", opts)
    vim.keymap.set("n", "<C-g>j", "<C-W><C-j>", opts)
    vim.keymap.set("n", "<C-g>k", "<C-W><C-k>", opts)
    vim.keymap.set("n", "<C-g>l", "<C-W><C-l>", opts)
    vim.keymap.set("n", "<C-g><C-H>", "<C-W><C-h>", opts)
    vim.keymap.set("n", "<C-g><C-J>", "<C-W><C-j>", opts)
    vim.keymap.set("n", "<C-g><C-K>", "<C-W><C-k>", opts)
    vim.keymap.set("n", "<C-g><C-L>", "<C-W><C-l>", opts)
    vim.keymap.set("n", "<CS-l>", "gt", opts)
    vim.keymap.set("n", "<CS-h>", "gT", opts)
    vim.keymap.set("n", "q:", "<Nop>", opts)
    vim.keymap.set("n", "<C-g>t", ":ToggleTerm direction=float<CR>", opts)
    vim.keymap.set("n", "<C-g><C-t>", ":ToggleTerm direction=float<CR>", opts)

    -- vim.keymap.set({ "n", "i" }, "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>")
    -- vim.keymap.set("n", "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>")
    -- vim.keymap.set({ "n", "i" }, "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>")
    -- vim.keymap.set("n", "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>")
    -- vim.keymap.set("n", "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>")
    -- vim.keymap.set({ "n", "x" }, "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>")
    -- vim.keymap.set({ "n", "x" }, "<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>")
    -- vim.keymap.set({ "n", "x" }, "<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>")
    -- vim.keymap.set("n", "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>")
    -- vim.keymap.set({ "n", "x" }, "<Leader>l", "<Cmd>MultipleCursorsLockToggle<CR>")

    vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float)
    vim.keymap.set("n", "<leader>sl", vim.diagnostic.setloclist)
    vim.keymap.set("n", "<leader>sq", function()
        vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
    end)

    vim.diagnostic.config({
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = { min = vim.diagnostic.severity.WARN } },

        -- Can switch between these as you prefer
        -- virtual_text = true, -- Text shows up at the end of the line
        -- virtual_lines = false, -- Text shows up underneath the line, with virtual lines

        -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
        jump = {
            on_jump = function(_, bufnr)
                vim.diagnostic.open_float({
                    bufnr = bufnr,
                    scope = "cursor",
                    focus = false,
                })
            end,
        },
    })

    -- VNOREMAP
    vim.keymap.set("v", "K", ":m .-2<CR>==", opts)
    vim.keymap.set("v", "J", ":m .+1<CR>==", opts)
    vim.keymap.set("v", "<", "<gv", opts)
    vim.keymap.set("v", ">", ">gv", opts)

    -- XNOREMAP
    -- vim.keymap.set("x", "J", [[:move '>+1<CR>gv-gv]], opts)
    -- vim.keymap.set("x", "K", [[:move '<-2<CR>gv-gv]], opts)

    -- TNOREMAP
    vim.keymap.set("t", "<C-g>v", "<C-\\><C-N>:vsp +term<CR>", opts)
    vim.keymap.set("t", "<C-g>%", "<C-\\><C-N>:vsp +term<CR>", opts)
    vim.keymap.set("t", "<C-g>s", "<C-\\><C-N>:sp +term<CR>", opts)
    vim.keymap.set("t", '<C-g>"', "<C-\\><C-N>:sp +term<CR>", opts)
    vim.keymap.set("t", "<C-g>c", "<C-\\><C-N>:tabe<CR>:term<CR>", opts)
    vim.keymap.set("t", "<C-g>n", "<C-\\><C-N>gt", opts)
    vim.keymap.set("t", "<C-g>p", "<C-\\><C-N>gT", opts)
    vim.keymap.set("t", "<C-g>t", "<C-\\><C-N>:ToggleTerm<CR>", opts)
    vim.keymap.set("t", "<C-g><C-t>", "<C-\\><C-N>:ToggleTerm<CR>", opts)
    vim.keymap.set("t", "<C-g>h", "<C-\\><C-N><C-w>h", opts)
    vim.keymap.set("t", "<C-g>j", "<C-\\><C-N><C-w>j", opts)
    vim.keymap.set("t", "<C-g>k", "<C-\\><C-N><C-w>k", opts)
    vim.keymap.set("t", "<C-g>l", "<C-\\><C-N><C-w>l", opts)
    vim.keymap.set("t", "<C-g><C-h>", "<C-\\><C-N><C-w>h", opts)
    vim.keymap.set("t", "<C-g><C-j>", "<C-\\><C-N><C-w>j", opts)
    vim.keymap.set("t", "<C-g><C-k>", "<C-\\><C-N><C-w>k", opts)
    vim.keymap.set("t", "<C-g><C-l>", "<C-\\><C-N><C-w>l", opts)

    -- LEADER KEY
    vim.keymap.set("n", "<leader>st", ":sp +term<CR>", opts)
    vim.keymap.set("n", "<leader>sp", ":sp<CR>", opts)
    vim.keymap.set("n", "<leader>vt", ":vsp +term<CR>", opts)
    vim.keymap.set("n", "<leader>vs", ":vs<CR>", opts)
    vim.keymap.set("n", "<leader>w", ":w<CR>", opts)
    vim.keymap.set("n", "<leader>q", ":q<CR>", opts)
    vim.keymap.set("n", "<leader>m", ":make<CR>", opts)
    vim.keymap.set("n", "<leader>z", "<C-w><Bar><C-w>_", opts)
    vim.keymap.set("n", "<leader>x", "<C-w>=", opts)
    vim.keymap.set("n", "<leader>sa", ":Save<CR>", opts)
    vim.keymap.set("n", "<leader>sv", ":Svrc<CR>", opts)
    vim.keymap.set("n", "<leader>ev", ":Evrc<CR>", opts)
    vim.keymap.set("n", "<leader>eb", ":Ebrc<CR>", opts)
    vim.keymap.set("n", "<leader>ef", ":Efc<CR>", opts)
    vim.keymap.set("n", "<leader>en", ":Enc<CR>", opts)
    vim.keymap.set("n", "<leader>ex", ":qa<CR>", opts)
    vim.keymap.set("n", "<leader>,", ":noh<CR>", opts)
    vim.keymap.set("n", "<leader>bl", "$A{<CR>}<ESC>O", opts)
    vim.keymap.set("n", "<leader>bs", "$A<CR>{<CR>}<ESC>O", opts)
    vim.keymap.set("n", "<leader>nill", "oif err != nil {<CR>return err<CR>}<ESC>", opts)
    vim.keymap.set("n", "<leader>nili", "oif err != nil {<CR>}<ESC>O", opts)
    vim.keymap.set("n", "<leader>nilt", "oif err != nil {<CR>return nil, err<CR>}<ESC>", opts)
    vim.keymap.set("n", "<leader>cc", ":cclose<CR>", opts)
    vim.keymap.set("n", "<leader>co", ":copen<CR>", opts)
    vim.keymap.set("n", "<C-Right>", ":cn<CR>", opts)
    vim.keymap.set("n", "<C-Left>", ":cp<CR>", opts)
    vim.keymap.set("n", "<leader>te", ":tabe<CR>", opts)

    -- PLUGIN SPECIFIC LEADERS
    vim.keymap.set("n", "<leader>gg", ":Gitsigns toggle_signs<CR>", opts)

    -- Thanks Claude Opus 4.5
    local function git_blame_smart()
        local ignore_file = vim.fn.findfile(".git-blame-ignore-revs", ".;")
        if ignore_file ~= "" then
            vim.cmd("Git blame --ignore-revs-file=.git-blame-ignore-revs")
        else
            vim.cmd("Git blame")
        end
    end
    vim.keymap.set("n", "<leader>gb", git_blame_smart, { desc = "Git blame (smart)" })
    vim.keymap.set("n", "<leader>so", ":SymbolsOutline<CR>", opts)
    vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>", opts)
    vim.keymap.set("n", "<leader>nf", ":NvimTreeFindFile<CR>", opts)
    vim.keymap.set("n", "<leader>tt", ":ToggleTerm direction=float<CR>", opts)
    vim.keymap.set("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", opts)
    vim.keymap.set("n", "<leader>ta", ":ToggleTerm direction=tab<CR>", opts)
    vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", opts)

    -- COMMAND
    vim.api.nvim_create_user_command("Svrc", ":source $MYVIMRC", {})
    vim.api.nvim_create_user_command("Save", ":mksession!", {})
    vim.api.nvim_create_user_command("Evrc", ":e $HOME/.vimrc", {})
    vim.api.nvim_create_user_command("Ebrc", ":e $HOME/.bashrc", {})
    vim.api.nvim_create_user_command("Egcfg", ":e $HOME/.gitconfig", {})
    vim.api.nvim_create_user_command("Efc", ":e $HOME/.config/fish/config.fish", {})
    vim.api.nvim_create_user_command("Enc", ":e $HOME/.config/nvim/init.lua", {})
end

local function configure_options()
    local options = {
        autoindent = true,
        autowrite = true,
        backup = false,
        backspace = "indent,eol,start",
        clipboard = "unnamedplus",
        -- completeopt = { "menuone", "noselect" }, -- mostly just for cmp
        cursorline = true,
        expandtab = true,
        foldenable = true,
        foldlevelstart = 100,
        foldmethod = "indent",
        hlsearch = false,
        incsearch = true,
        laststatus = 2,
        lazyredraw = true,
        linebreak = true,
        list = false,
        mouse = "a",
        number = true,
        numberwidth = 2,
        relativenumber = true,
        scrolloff = 0,
        shiftwidth = 4,
        showcmd = true,
        showmatch = true,
        -- sidescrolloff = 8 -- when wrap is false, horiz version of scrolloff
        -- smartindent = true,
        signcolumn = "yes",
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

    -- disable netrw
    -- vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
    -- vim.g.netrw_banner = 0

    vim.cmd([[setlocal spell spelllang=en_us]])
    vim.cmd([[ set nospell ]])
end

-- [[ Autocmd ]]
local function configure_autocmds()
    -- No line numbers on term
    vim.api.nvim_create_autocmd("TermOpen", { command = "setlocal nonumber norelativenumber" })

    local salt_group = vim.api.nvim_create_augroup("Salt", { clear = true })
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        callback = function()
            vim.cmd([[ set syntax=yaml ]])
            vim.cmd([[ set softtabstop=2 ]])
            vim.cmd([[ set tabstop=2 ]])
            vim.cmd([[ set shiftwidth=2 ]])
        end,
        group = salt_group,
        pattern = "*.sls",
    })
end

function configure_telescope()
    local actions = require("telescope.actions")
    require("telescope").setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-u>"] = false,
                    ["<C-d>"] = false,
                    ["<C-f>"] = actions.preview_scrolling_down,
                    ["<C-b>"] = actions.preview_scrolling_up,
                    ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    ["<C-q>"] = actions.send_to_qflist,
                    ["<C-l>"] = actions.delete_buffer,
                },
                n = {
                    ["q"] = actions.close,
                    ["C-c"] = actions.close,
                    ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    ["<C-u>"] = actions.results_scrolling_up,
                    ["<C-d>"] = actions.results_scrolling_down,
                    ["<C-f>"] = actions.preview_scrolling_down,
                    ["<C-b>"] = actions.preview_scrolling_up,
                    ["<C-q>"] = actions.send_to_qflist,
                    ["<C-l>"] = actions.delete_buffer,
                },
            },
            file_ignore_patterns = { "^vendor/", "go.mod" },
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown(),
            },
        },
    })

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "file_browser")
    local builtin = require("telescope.builtin")
    local tutils = require("telescope.utils")

    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>km", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })

    -- NOTE: COPY PASTED FROM GEMINI
    function get_unix_path_first_component(path)
        -- Input validation
        if type(path) ~= "string" or path == "" then
            return nil
        end

        -- Handle absolute Unix paths
        if path:sub(1, 1) == "/" then
            return "/" -- For any absolute path, the root is always '/'
        end

        -- Handle relative paths
        local first_slash_pos = path:find("/")

        if first_slash_pos then
            -- If a slash is found, the first component is everything before it
            return path:sub(1, first_slash_pos - 1)
        else
            -- If no slash is found, the whole path is the first component
            -- (e.g., "filename.txt" or "folder_name")
            return path
        end
    end
    -- vim.keymap.set("n", "<leader>sb", function()
    --     print(get_unix_path_first_component(vim.fn.expand("%")))
    -- end)
    vim.keymap.set("n", "<leader>sb", function()
        builtin.live_grep({
            cwd = (function()
                return get_unix_path_first_component(vim.fn.expand("%"))
            end)(),
        })
    end, { desc = "[S]earch by [B]uffer dir" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set(
        "n",
        "<leader>s.",
        builtin.oldfiles,
        { desc = '[S]earch Recent Files ("." for repeat)' }
    )
    vim.keymap.set("n", "<leader>bu", builtin.buffers, { desc = "[ ] Find existing buffers" })
    vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "[ ] Find marks" })
    vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
        }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>s/", function()
        builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
    end, { desc = "[S]earch [/] in Open Files" })
    vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[S]earch [N]eovim files" })
end

function configure_lsp()
    local lsp_attach_cb = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set({ "n", "v" }, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map(
            "<leader>dw",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            "[W]orkspace [S]ymbols"
        )
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("<leader>sk", vim.lsp.buf.signature_help, "Signature Documentation")
        map("<leader>vwa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        map("<leader>vwr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        map("<leader>vwl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")
        map("<leader>lre", ":LspRestart<CR>", "Restart LSP")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            -- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            --     buffer = event.buf,
            --     callback = vim.lsp.buf.document_highlight,
            -- })

            -- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            --     buffer = event.buf,
            --     callback = vim.lsp.buf.clear_references,
            -- })
        end
        -- require("lsp-inlayhints").on_attach(client, event.buf)
        if
            client
            and client.server_capabilities
            and client.server_capabilities.documentSymbolProvider
        then
            require("nvim-navic").attach(client, event.buf)
        end

        -- needed for alabaster colors to not disappear
        if
            client
            and client.server_capabilities
            and client.server_capabilities.semanticTokensProvider
        then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = lsp_attach_cb,
    })

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities =
    --     vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local servers = {
        clangd = {},
        rust_analyzer = {
            -- equivalent of config key in helix languages.toml
            settings = {
                ["rust-analyzer"] = {
                    rustfmt = {
                        -- doesn't work
                        -- extraArgs = { "+nightly" },
                        -- overrideCommand = { "rustfmt", "+nightly", "--emit", "stdout" },
                    },
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    check = {
                        command = "clippy",
                        -- allTargets = true,
                        -- features = "all",
                    },
                    cargo = {
                        -- allTargets = true,
                        -- features = "all",
                        buildScripts = {
                            enable = true,
                        },
                    },
                    procMacro = {
                        enable = true,
                    },
                    diagnostics = {
                        enable = true,
                        disabled = {
                            "unresolved-proc-macro",
                            "proc-macro-disabled",
                            "inactive-code",
                            "attribute-expansion-disabled",
                            "macro-error",
                            "macro-def-error",
                        },
                    },
                    files = {
                        excludeDirs = { "~/.cargo/git" },
                    },
                },
            },
        },
        gopls = {
            settings = {
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
                },
            },
        },
        pyright = {},
        lua_ls = {
            settings = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                    diagnostics = {
                        globals = { "vim" },
                        disable = { "lowercase-global", "missing-fields" },
                    },
                    hint = {
                        enable = true,
                    },
                    format = {
                        -- use stylua for formatting
                        enable = false,
                    },
                },
            },
        },
        ts_ls = {},
    }

    require("mason").setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
        -- linters,
        -- "markdownlint",
        "jsonlint",
        "hadolint",
        -- formatters,
        "prettier",
        "shellcheck",
    })
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers or {}),
        automatic_enable = false,
    })

    for server_name, server in pairs(servers) do
        server.capabilities =
            vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        vim.lsp.config(server_name, server)
        vim.lsp.enable(server_name)
    end
end

function configure_lint()
    local lint = require("lint")
    lint.linters_by_ft = {
        json = { "jsonlint" },
        dockerfile = { "hadolint" },
        sh = { "shellcheck" },
        markdown = nil,
    }

    -- To allow other plugins to add linters to require('lint').linters_by_ft,
    -- instead set linters_by_ft like this:
    -- lint.linters_by_ft = lint.linters_by_ft or {}
    -- lint.linters_by_ft["markdown"] = nil
    -- lint.linters_by_ft["json"] = { "jsonlint" }
    --
    -- However, note that this will enable a set of default linters,
    -- which will cause errors unless these tools are available:
    -- {
    --   clojure = { "clj-kondo" },
    --   dockerfile = { "hadolint" },
    --   inko = { "inko" },
    --   janet = { "janet" },
    --   json = { "jsonlint" },
    --   markdown = { "vale" },
    --   rst = { "vale" },
    --   ruby = { "ruby" },
    --   terraform = { "tflint" },
    --   text = { "vale" }
    -- }
    --
    -- You can disable the default linters by setting their filetypes to nil:
    -- lint.linters_by_ft['clojure'] = nil
    -- lint.linters_by_ft['dockerfile'] = nil
    -- lint.linters_by_ft['inko'] = nil
    -- lint.linters_by_ft['janet'] = nil
    -- lint.linters_by_ft['json'] = nil
    -- lint.linters_by_ft['markdown'] = nil
    -- lint.linters_by_ft['rst'] = nil
    -- lint.linters_by_ft['ruby'] = nil
    -- lint.linters_by_ft['terraform'] = nil
    -- lint.linters_by_ft["text"] = nil
    -- lint.linters_by_ft["terraform"] = nil

    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
            require("lint").try_lint()
        end,
    })
end

function configure_dap()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
        automatic_installation = false,
        automatic_setup = true,
        handlers = {},
        ensure_installed = {
            "delve",
            "python",
            "codelldb",
        },
    })

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<F6>", dap.terminate, { desc = "Debug: Stop" })
    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Debug: Set Breakpoint" })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup()

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- Install golang specific config
    require("dap-go").setup()

    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: " .. vim.fn.getcwd() .. "/")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
end

-- configure_nvim_cmp has been superseded by blink.cmp.
function configure_nvim_cmp()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    luasnip.config.setup({})

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        completion = { completeopt = "menu,menuone" },
        mapping = cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<S-Tab>"] = cmp.mapping.select_next_item(),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<CR>"] = cmp.mapping.confirm(),
            ["<C-s>"] = cmp.mapping.complete({}),
            ["<C-l>"] = cmp.mapping(function()
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, { "i", "s" }),
            ["<C-h>"] = cmp.mapping(function()
                if luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            -- Can also move the 'buffer' and 'path' ones here to always be shown
        }, {
            { name = "buffer" },
            { name = "path" },
        }),
        enabled = function()
            local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
            if in_prompt then -- this will disable cmp in the Telescope window (taken from the default config)
                return false
            end
            local context = require("cmp.config.context")
            return not (
                context.in_treesitter_capture("comment") == true
                or context.in_syntax_group("Comment")
            )
        end,
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
    })
end

function configure_treesitter()
    -- require("nvim-treesitter.configs").setup({
    --     auto_install = true,
    --     autopairs = { enable = true },
    --     highlight = {
    --         enable = true,
    --     },
    --     indent = { enable = true, disable = { "python" } },
    --     incremental_selection = {
    --         enable = true,
    --         keymaps = {
    --             init_selection = "<A-o>",
    --             node_incremental = "<A-o>",
    --             scope_incremental = "<A-a>",
    --             node_decremental = "<A-i>",
    --         },
    --     },
    -- })
    --
    local parsers = {
        "c",
        "cpp",
        "go",
        "lua",
        "python",
        "rust",
        "tsx",
        "typescript",
        "vimdoc",
        "markdown",
        "vim",
        "json",
    }
    require("nvim-treesitter").install(parsers)

    local function treesitter_try_attach(buf, language)
        if not vim.treesitter.language.add(language) then
            return
        end
        vim.treesitter.start(buf, language)

        -- Enable treesitter based folds
        -- For more info on folds see `:help folds`
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"

        -- Check if treesitter indentation is available for this language, and if so enable it
        -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
        local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

        if has_indent_query and language ~= "python" then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end

    local available_parsers = require("nvim-treesitter").get_available()
    vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
            local buf, filetype = args.buf, args.match

            local language = vim.treesitter.language.get_lang(filetype)
            if not language then
                return
            end

            local installed_parsers = require("nvim-treesitter").get_installed("parsers")

            if vim.tbl_contains(installed_parsers, language) then
                -- Enable the parser if it is already installed
                treesitter_try_attach(buf, language)
            elseif vim.tbl_contains(available_parsers, language) then
                -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
                require("nvim-treesitter").install(language):await(function()
                    treesitter_try_attach(buf, language)
                end)
            else
                -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
                treesitter_try_attach(buf, language)
            end
        end,
    })

    -- This is actually so silly but whatever, it's what's outlined here.
    -- These nvim 12 treesitter changes are so disruptive.
    -- https://github.com/daliusd/incr.nvim

    local keymap = vim.keymap.set
    keymap("n", "<A-o>", ":normal van<cr>", opts)
    keymap("v", "<A-o>", function()
        vim.api.nvim_feedkeys("an", "v", false)
    end)
    keymap("n", "<A-i>", ":normal vin<cr>", opts)
    keymap("v", "<A-i>", function()
        vim.api.nvim_feedkeys("in", "v", false)
    end)
    -- not sure how you can do scope_incremental or scope_decremental, it's undocumented.
end

function configure_treesitter_textobjects()
    -- following nvim-treesitter-textobjects help
    -- these used te be a part of treesitter setup but were removed
    require("nvim-treesitter-textobjects").setup({
        select = {
            lookahead = true,
        },
        move = {
            set_jumps = true,
        },
    })
    local select = require("nvim-treesitter-textobjects.select")
    -- select
    vim.keymap.set({ "x", "o" }, "aa", function()
        select.select_textobject("@parameter.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ia", function()
        select.select_textobject("@parameter.inner", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "af", function()
        select.select_textobject("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "if", function()
        select.select_textobject("@function.inner", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ac", function()
        select.select_textobject("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ic", function()
        select.select_textobject("@class.inner", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "as", function()
        select.select_textobject("@local.scope", "locals")
    end)
    -- move
    local move = require("nvim-treesitter-textobjects.move")
    vim.keymap.set({ "n", "x", "o" }, "]m", function()
        move.goto_next_start("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]]", function()
        move.goto_next_start("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]M", function()
        move.goto_next_end("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "][", function()
        move.goto_next_end("@class.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "[m", function()
        move.goto_previous_start("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[[", function()
        move.goto_previous_start("@class.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "[M", function()
        move.goto_previous_end("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[]", function()
        move.goto_previous_end("@class.outer", "textobjects")
    end)

    vim.keymap.set({ "n", "x", "o" }, "]o", function()
        move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]s", function()
        move.goto_next_start("@local.scope", "locals")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]z", function()
        move.goto_next_start("@fold", "folds")
    end)
    -- vim.keymap.set({ "n", "x", "o" }, "]d", function()
    --     move.goto_next("@conditional.outer", "textobjects")
    -- end)
    -- vim.keymap.set({ "n", "x", "o" }, "[d", function()
    --     move.goto_previous("@conditional.outer", "textobjects")
    -- end)
    -- swap
    local swap = require("nvim-treesitter-textobjects.swap")
    vim.keymap.set("n", "<leader>a", function()
        swap.swap_next("@parameter.inner")
    end)
    vim.keymap.set("n", "<leader>A", function()
        swap.swap_previous("@parameter.outer")
        -- swap.swap_next("@parameter.outer")
    end)
end

configure_keymaps()
configure_options()
install_plugins()
configure_autocmds()
