local function install_plugins()
	local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/folke/lazy.nvim.git',
			'--branch=stable',
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
	local plugins = {
		{
			'dracula/vim',
			name = 'dracula',
			priority = 1000,
			init = function()
				vim.cmd.colorscheme('dracula')
			end,
		},
		{ 'tpope/vim-commentary' },
		{ 'tpope/vim-fugitive' }, -- :Git commands
		{ 'tpope/vim-rhubarb' }, -- github related commands
		{ 'tpope/vim-surround' }, -- dealing with quotes and parens
		{ 'tpope/vim-sleuth' }, -- detect tabs and shiftwidth
		{
			'lewis6991/gitsigns.nvim',
			opts = {
				signs = {
					add = { text = '+' },
					change = { text = '~' },
					delete = { text = '_' },
					topdelete = { text = '‾' },
					changedelete = { text = '~' },
				},
			},
		},
		{ 'folke/zen-mode.nvim', opts = {} },
		{
			'nvim-telescope/telescope.nvim',
			event = 'VimEnter',
			branch = '0.1.x',
			dependencies = {
				'nvim-lua/plenary.nvim',
				{
					'nvim-telescope/telescope-fzf-native.nvim',
					build = 'make',
					cond = function()
						return vim.fn.executable('make') == 1
					end,
				},
				'nvim-telescope/telescope-ui-select.nvim',
				'nvim-tree/nvim-web-devicons',
			},
			config = configure_telescope,
		},
		{ 'windwp/nvim-autopairs', opts = { break_undo = false } },
		{
			'neovim/nvim-lspconfig',
			dependencies = {
				'williamboman/mason.nvim',
				'williamboman/mason-lspconfig.nvim',
				'WhoIsSethDaniel/mason-tool-installer.nvim',
				{ 'j-hui/fidget.nvim', opts = {} },
				{ 'folke/neodev.nvim', opts = {} },
				{ 'lvimuser/lsp-inlayhints.nvim', opts = {} },
			},
			config = configure_lsp,
			-- default priority is 50
			-- this needs to load before mason-nvim-dap, because it runs require('mason').setup()
			-- so set it to something higher than 50
			priority = 53,
		},
		{
			'mfussenegger/nvim-lint',
			dependencies = {
				'williamboman/mason.nvim',
				'rshkarin/mason-nvim-lint',
			},
			event = { 'BufReadPre', 'BufNewFile' },
			config = configure_lint,
		},
		{
			'mfussenegger/nvim-dap',
			dependencies = {
				-- Creates a beautiful debugger UI
				'rcarriga/nvim-dap-ui',

				-- Required dependency for nvim-dap-ui
				'nvim-neotest/nvim-nio',

				-- Installs the debug adapters for you
				'williamboman/mason.nvim',
				'jay-babu/mason-nvim-dap.nvim',

				-- Add your own debuggers here
				'leoluz/nvim-dap-go',
			},
			config = configure_dap,
		},
		{
			'stevearc/conform.nvim',
			opts = {
				notify_on_error = true,
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
					lua = { 'stylua' },
					-- Conform can also run multiple formatters sequentially
					-- python = { "isort", "black" },
					--
					-- You can use a sub-list to tell conform to run *until* a formatter
					-- is found.
					-- javascript = { { "prettierd", "prettier" } },
				},
			},
			init = function()
				vim.api.nvim_create_user_command('Format', function(args)
					local range = nil
					if args.count ~= -1 then
						local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
						range = {
							start = { args.line1, 0 },
							['end'] = { args.line2, end_line:len() },
						}
					end
					require('conform').format({ async = true, lsp_fallback = true, range = range })
				end, { range = true })
				vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
			end,
		},
		{
			'hrsh7th/nvim-cmp',
			event = 'InsertEnter',
			dependencies = {
				{
					'L3MON4D3/LuaSnip',
					build = (function()
						-- Build Step is needed for regex support in snippets.
						-- This step is not supported in many windows environments.
						-- Remove the below condition to re-enable on windows.
						if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
							return
						end
						return 'make install_jsregexp'
					end)(),
					dependencies = {
						{
							'rafamadriz/friendly-snippets',
							config = function()
								require('luasnip.loaders.from_vscode').lazy_load()
							end,
						},
					},
				},
				'saadparwaiz1/cmp_luasnip',
				'hrsh7th/cmp-nvim-lsp',
				'hrsh7th/cmp-path',
				'hrsh7th/cmp-buffer',
				'hrsh7th/cmp-cmdline',
			},
			config = configure_nvim_cmp,
		},
		{
			'nvim-treesitter/nvim-treesitter',
			dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
			build = ':TSUpdate',
			config = configure_treesitter,
		},
		{
			'simrat39/symbols-outline.nvim',
			opts = {
				width = 15,
				position = 'top',
			},
		},
		{
			'nvim-tree/nvim-tree.lua',
			dependencies = {
				'nvim-tree/nvim-web-devicons',
			},
			opts = {
				view = { relativenumber = true },
				filters = {
					dotfiles = false,
				},
			},
		},
		{ 'khaveesh/vim-fish-syntax' },
		{
			'akinsho/toggleterm.nvim',
			version = '*',
			config = true,
		},
		{ 'mbbill/undotree' },
		{ 'hashivim/vim-terraform' },
		-- { 'brenton-leighton/multiple-cursors.nvim', version = "*", opts = {} },
		{
			'mg979/vim-visual-multi',
			branch = 'master',
			config = function()
				vim.g.VM_theme = 'neon'
			end,
		},
	}
	local lazy_opts = {
		install = {
			colorscheme = { 'dracula' },
		},
	}
	require('lazy').setup(plugins, lazy_opts)
end

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

	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
	vim.keymap.set('n', '<leader>of', vim.diagnostic.open_float)
	vim.keymap.set('n', '<leader>sl', vim.diagnostic.setloclist)
	vim.keymap.set('n', '<leader>sq', vim.diagnostic.setqflist)

	-- VNOREMAP
	vim.keymap.set('v', 'K', ':m .-2<CR>==', opts)
	vim.keymap.set('v', 'J', ':m .+1<CR>==', opts)
	vim.keymap.set('v', '<', '<gv', opts)
	vim.keymap.set('v', '>', '>gv', opts)

	-- XNOREMAP
	-- vim.keymap.set("x", "J", [[:move '>+1<CR>gv-gv]], opts)
	-- vim.keymap.set("x", "K", [[:move '<-2<CR>gv-gv]], opts)

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

local function configure_options()
	local options = {
		autoindent = true,
		autowrite = true,
		backup = false,
		backspace = 'indent,eol,start',
		clipboard = 'unnamedplus',
		completeopt = { 'menuone', 'noselect' }, -- mostly just for cmp
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

	if vim.fn.exists('+colorcolumn') == 1 then
		options.colorcolumn = '100'
	end

	for k, v in pairs(options) do
		vim.opt[k] = v
	end
	vim.opt.path:append('**')
	vim.opt.shortmess:append('c')

	-- disable netrw
	-- vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
	-- vim.g.netrw_banner = 0

	vim.cmd([[setlocal spell spelllang=en_us]])
	vim.cmd([[ set nospell ]])
end

-- [[ Autocmd ]]
local function configure_autocmds()
	-- No line numbers on term
	vim.api.nvim_create_autocmd('TermOpen', { command = 'setlocal nonumber norelativenumber' })

	local salt_group = vim.api.nvim_create_augroup('Salt', { clear = true })
	vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
		callback = function()
			vim.cmd([[ set syntax=yaml ]])
			vim.cmd([[ set softtabstop=2 ]])
			vim.cmd([[ set tabstop=2 ]])
			vim.cmd([[ set shiftwidth=2 ]])
		end,
		group = salt_group,
		pattern = '*.sls',
	})
end

function configure_telescope()
	local actions = require('telescope.actions')
	require('telescope').setup({
		defaults = {
			mappings = {
				i = {
					['<C-u>'] = false,
					['<C-d>'] = false,
					['<C-f>'] = actions.preview_scrolling_down,
					['<C-b>'] = actions.preview_scrolling_up,
					['<C-s>'] = actions.send_selected_to_qflist + actions.open_qflist,
					['<C-q>'] = actions.send_to_qflist,
					['<C-l>'] = actions.delete_buffer,
				},
				n = {
					['q'] = actions.close,
					['C-c'] = actions.close,
					['<C-s>'] = actions.send_selected_to_qflist + actions.open_qflist,
					['<C-u>'] = actions.results_scrolling_up,
					['<C-d>'] = actions.results_scrolling_down,
					['<C-f>'] = actions.preview_scrolling_down,
					['<C-b>'] = actions.preview_scrolling_up,
					['<C-q>'] = actions.send_to_qflist,
					['<C-l>'] = actions.delete_buffer,
				},
			},
			file_ignore_patterns = { '^vendor/', 'go.mod' },
		},
		extensions = {
			['ui-select'] = {
				require('telescope.themes').get_dropdown(),
			},
		},
	})

	pcall(require('telescope').load_extension, 'fzf')
	pcall(require('telescope').load_extension, 'ui-select')
	pcall(require('telescope').load_extension, 'file_browser')
	local builtin = require('telescope.builtin')

	vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
	vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
	vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
	vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
	vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
	vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
	vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
	vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
	vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
	vim.keymap.set('n', '<leader>bu', builtin.buffers, { desc = '[ ] Find existing buffers' })
	vim.keymap.set(
		'n',
		'<leader>/',
		builtin.current_buffer_fuzzy_find,
		{ desc = '[/] Fuzzily search in current buffer' }
	)

	vim.keymap.set('n', '<leader>s/', function()
		builtin.live_grep({ grep_open_files = true, prompt_title = 'Live Grep in Open Files' })
	end, { desc = '[S]earch [/] in Open Files' })
	vim.keymap.set('n', '<leader>sn', function()
		builtin.find_files({ cwd = vim.fn.stdpath('config') })
	end, { desc = '[S]earch [N]eovim files' })
end

function configure_lsp()
	local lsp_attach_cb = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set({ 'n', 'v' }, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
		end

		map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
		map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
		map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
		map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
		map('K', vim.lsp.buf.hover, 'Hover Documentation')

		map('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
		map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
		map('<leader>dw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
		map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
		map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
		map('<leader>sk', vim.lsp.buf.signature_help, 'Signature Documentation')
		map('<leader>vwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
		map('<leader>vwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
		map('<leader>vwl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, '[W]orkspace [L]ist Folders')

		-- -- Create a command `:Format` local to the LSP buffer
		-- vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		-- 	vim.lsp.buf.format()
		-- end, { desc = "Format current buffer with LSP" })
		-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
		-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		-- if client.supports_method("textDocument/formatting") then
		-- 	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		-- 	vim.api.nvim_create_autocmd("BufWritePre", {
		-- 		group = augroup,
		-- 		buffer = bufnr,
		-- 		callback = function()
		-- 			vim.lsp.buf.format()
		-- 		end,
		-- 	})
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
				buffer = event.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
				buffer = event.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
		require('lsp-inlayhints').on_attach(client, event.buf)
	end

	vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
		callback = lsp_attach_cb,
	})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

	local servers = {
		clangd = {},
		rust_analyzer = {
			-- equivalent of config key in helix languages.toml
			settings = {
				['rust-analyzer'] = {
					imports = {
						granularity = {
							group = 'module',
						},
						prefix = 'self',
					},
					check = {
						command = 'clippy',
					},
					procMacro = {
						enable = true,
					},
					files = {
						excludeDirs = { '~/.cargo/git' },
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
						disable = { 'lowercase-global', 'missing-fields' },
					},
					hint = {
						enable = true,
					},
					defaultConfig = {
						max_line_length = '100',
					},
				},
			},
		},
	}

	require('mason').setup()

	local ensure_installed = vim.tbl_keys(servers or {})
	vim.list_extend(ensure_installed, {
		'stylua', -- Used to format Lua code
		-- linters,
		'markdownlint',
	})
	require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

	require('mason-lspconfig').setup({
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
				require('lspconfig')[server_name].setup(server)
			end,
		},
	})
end

function configure_lint()
	local lint = require('lint')
	-- lint.linters_by_ft = {
	-- 	markdown = { 'markdownlint' },
	-- }

	-- To allow other plugins to add linters to require('lint').linters_by_ft,
	-- instead set linters_by_ft like this:
	lint.linters_by_ft = lint.linters_by_ft or {}
	lint.linters_by_ft['markdown'] = { 'markdownlint' }
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
	-- lint.linters_by_ft['text'] = nil

	-- Create autocommand which carries out the actual linting
	-- on the specified events.
	local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
	vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
		group = lint_augroup,
		callback = function()
			require('lint').try_lint()
		end,
	})
end

function configure_dap()
	local dap = require('dap')
	local dapui = require('dapui')

	require('mason-nvim-dap').setup({
		automatic_installation = false,
		-- Makes a best effort to setup the various debuggers with
		-- reasonable debug configurations
		automatic_setup = true,

		-- You can provide additional configuration to the handlers,
		-- see mason-nvim-dap README for more information
		handlers = {},

		-- You'll need to check that you have the required things installed
		-- online, please don't ask me how to install them :)
		ensure_installed = {
			-- Update this to ensure that you have the debuggers for the langs you want
			'delve',
			'python',
			'codelldb',
		},
	})

	-- Basic debugging keymaps, feel free to change to your liking!
	vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
	vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
	vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
	vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
	vim.keymap.set('n', '<F6>', dap.terminate, { desc = 'Debug: Stop' })
	vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
	vim.keymap.set('n', '<leader>B', function()
		dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
	end, { desc = 'Debug: Set Breakpoint' })

	-- Dap UI setup
	-- For more information, see |:help nvim-dap-ui|
	dapui.setup()

	-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
	vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

	dap.listeners.after.event_initialized['dapui_config'] = dapui.open
	dap.listeners.before.event_terminated['dapui_config'] = dapui.close
	dap.listeners.before.event_exited['dapui_config'] = dapui.close

	-- Install golang specific config
	require('dap-go').setup()

	dap.configurations.cpp = {
		{
			name = 'Launch file',
			type = 'codelldb',
			request = 'launch',
			program = function()
				return vim.fn.input('Path to executable: ' .. vim.fn.getcwd() .. '/')
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
		},
	}
	dap.configurations.c = dap.configurations.cpp
	dap.configurations.rust = dap.configurations.cpp
end

function configure_nvim_cmp()
	local cmp = require('cmp')
	local luasnip = require('luasnip')
	luasnip.config.setup({})

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		completion = { completeopt = 'menu,menuone,noinsert' },
		mapping = cmp.mapping.preset.insert({
			['<C-n>'] = cmp.mapping.select_next_item(),
			['<Tab>'] = cmp.mapping.select_next_item(),
			['<C-p>'] = cmp.mapping.select_prev_item(),
			['<S-Tab>'] = cmp.mapping.select_next_item(),
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<CR>'] = cmp.mapping.confirm({ select = true }),
			['<C-s>'] = cmp.mapping.complete({}),
			['<C-l>'] = cmp.mapping(function()
				if luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { 'i', 's' }),
			['<C-h>'] = cmp.mapping(function()
				if luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { 'i', 's' }),
		}),
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			-- Can also move the 'buffer' and 'path' ones here to always be shown
		}, {
			{ name = 'buffer' },
			{ name = 'path' },
		}),
		enabled = function()
			local in_prompt = vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt'
			if in_prompt then -- this will disable cmp in the Telescope window (taken from the default config)
				return false
			end
			local context = require('cmp.config.context')
			return not (context.in_treesitter_capture('comment') == true or context.in_syntax_group('Comment'))
		end,
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' },
		},
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' },
		}, {
			{ name = 'cmdline' },
		}),
	})
end

function configure_treesitter()
	require('nvim-treesitter.configs').setup({
		ensure_installed = {
			'c',
			'cpp',
			'go',
			'lua',
			'python',
			'rust',
			'tsx',
			'typescript',
			'vimdoc',
			'markdown',
			'vim',
		},
		auto_install = true,
		autopairs = { enable = true },
		highlight = {
			enable = true,
		},
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
	})
end

configure_keymaps()
configure_options()
install_plugins()
configure_autocmds()
