local fname = "lua/completions.lua"
local require_mod = require("helpers").require_mod

local cmp_status_ok, cmp = require_mod("cmp", fname)
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = require_mod("luasnip", fname)
if not snip_status_ok then
    return
end
-- luasnip.config.setup() -- not sure if needed

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

-- If you're feeling frisky and have a nerd font
--   פּ ﯟ   some other good icons
-- local kind_icons = {
--     Text = "",
--     Method = "m",
--     Function = "",
--     Constructor = "",
--     Field = "",
--     Variable = "",
--     Class = "",
--     Interface = "",
--     Module = "",
--     Property = "",
--     Unit = "",
--     Value = "",
--     Enum = "",
--     Keyword = "",
--     Snippet = "",
--     Color = "",
--     File = "",
--     Reference = "",
--     Folder = "",
--     EnumMember = "",
--     Constant = "",
--     Struct = "",
--     Event = "",
--     Operator = "",
--     TypeParameter = "",
-- }

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
    -- If you have a nerd font
    -- formatting = {
    --     fields = { "kind", "abbr", "menu" },
    --     format = function(entry, vim_item)
    --         -- Kind icons
    --         -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
    --         -- This concatonates the icons with the name of the item kind
    --         vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
    --         vim_item.menu = ({
    --             luasnip = "[Snippet]",
    --             buffer = "[Buffer]",
    --             path = "[Path]",
    --         })[entry.source.name]
    --         return vim_item
    --     end,
    -- },
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
        documentation = cmp.config.window.bordered(),
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
