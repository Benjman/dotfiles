local cmp = require('cmp')
local mapping = require('cmp.config.mapping')
local types = require('cmp.types')

cmp.setup({

    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
        end,
    },

    mapping = {
        ['<Tab>'] = mapping(mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }), { 'i' }),
        ['<S-Tab>'] = mapping(mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }), { 'i' }),
        ['<C-k>'] = mapping(mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }), { 'i' }),
        ['<C-j>'] = mapping(mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }), { 'i' }),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },

    -- the order of sources matters, first sources are given priority over later ones
    -- config options:
    --      keyword_length
    --      priority
    --      max_item_count
    --      (more?)
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'vsnip' }, -- For vsnip users.
        { name = 'buffer', keyword_length = 5 },
    }),

    experimental = {
        native_menu = false,
        ghost_text = true,
    }
})
