local utils = require('lisk.utils')

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = false})

-- local signs = {
--    Error = " ",
--    Warning = " ",
--    Information = " ",
--    Hint = " "
-- }
local signs = {Error = "", Warn = "", Info = "", Hint = ""}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

local lsp_status = require('lsp-status')
local function on_attach(client, buf)
    local map_opts = {'silent', {buffer = buf}}

    utils.nnoremap('K', '<cmd>lua vim.lsp.buf.hover()<cr>', map_opts)
    utils.nnoremap('Y', '<cmd>lua vim.diagnostic.open_float()<cr>', map_opts)
    utils.nnoremap(']d',
                   '<cmd>lua vim.diagnostic.goto_next{popup_opts={focusable=false}}<cr>',
                   {'silent', {buffer = buf, hint = 'Next diagnostic'}})
    utils.nnoremap('[d',
                   '<cmd>lua vim.diagnostic.goto_prev{popup_opts={focusable=false}}<cr>',
                   {'silent', {buffer = buf, hint = 'Prev diagnostic'}})

    utils.nnoremap('gd', '<cmd>Telescope lsp_definitions theme=ivy<cr>',
                   map_opts)
    utils.nnoremap('<leader>a',
                   '<cmd>Telescope lsp_code_actions theme=cursor<cr>', map_opts)
    utils.nnoremap('gR', '<cmd>Telescope lsp_references theme=ivy<cr>', map_opts)

    utils.nnoremap('<leader>c', '<cmd>Lspsaga rename<cr>', map_opts)

    utils.nnoremap('<leader>D', '<cmd>Telescope diagnostics theme=ivy<cr>',
                   map_opts)

    lsp_status.on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

local lspconfig = require('lspconfig')

require('lisk.lsp.lua').setup(on_attach, capabilities)
lspconfig.pyright.setup {
    cmd = {
        'sh', '-c',
        'pdm run pyright-langserver --stdio || pyright-langserver --stdio'
    },
    on_attach = on_attach,
    capabilities = capabilities,
    on_new_config = function(cfg, root) if root then cfg.cmd_cwd = root end end
}

require('rust-tools').setup {
    server = {
        on_attach = function(client, buf)
            on_attach(client, buf)

            local map_opts = {'silent', {buffer = buf}}
            utils.nnoremap('<leader>st', '<cmd>RustToggleInlayHints<cr>',
                           map_opts)
        end,
        capabilities = capabilities
    }
}

require'lspconfig'.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
