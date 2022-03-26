local cmp = require('cmp')
local luasnip = require('luasnip')
local utils = require('lisk.utils')

local snippet_forward = cmp.mapping(function(fallback)
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        fallback()
    end
end, {"i", "s"})

local snippet_backward = cmp.mapping(function(fallback)
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
    end
end, {"i", "s"})

cmp.setup {
    enabled = function()
        return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' and
                   vim.g.started_by_firenvim == nil
    end,
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    mapping = {
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item()
            else
                cmp.complete()
            end
        end, {'i'}),
        ['<C-y>'] = cmp.config.disable,
        ['<C-c>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert}),
        ["<Tab>"] = snippet_forward,
        ["<S-Tab>"] = snippet_backward
    },
    sources = {
        {name = 'nvim_lsp'}, {name = 'luasnip'}, {
            name = 'buffer',
            option = {
                get_bufnrs = function()
                    local buffers = {}
                    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                        if vim.api.nvim_buf_is_loaded(bufnr) and
                            utils.get_buffer_size(bufnr) <= (1024 * 1024) then
                            buffers[bufnr] = true
                        end
                    end

                    return vim.tbl_keys(buffers)
                end,
                keyword_pattern = [[\k\+]]
            }
        }, {name = 'path'}
    },
    formatting = {
        format = require('lspkind').cmp_format{
            mode = 'text_symbol',
            maxwidth = 50
        }
    }
}
