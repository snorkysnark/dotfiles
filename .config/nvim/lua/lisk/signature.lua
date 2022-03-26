local M = {}
local lsp_signature = require("lsp_signature")

lsp_signature.setup {hint_enable = false, handler_opts = {border = 'none'}}

local function is_float_open()
    return _LSP_SIG_CFG.winnr and _LSP_SIG_CFG.winnr > 0 and
               vim.api.nvim_win_is_valid(_LSP_SIG_CFG.winnr)
end

function M.persistent_toggle()
    local insert_or_select = vim.fn.mode() == 'i' or vim.fn.mode() == 's'

    if _LSP_SIG_CFG.floating_window then
        if insert_or_select and is_float_open() then
            lsp_signature.toggle_float_win()
        end
        _LSP_SIG_CFG.floating_window = false
        print("Signature disabled")
    else
        _LSP_SIG_CFG.floating_window = true
        if insert_or_select and not is_float_open() then
            lsp_signature.toggle_float_win()
        end
        print("Signature enabled")
    end
end

local utils = require('lisk.utils')
utils.inoremap('<M-s>',
               '<cmd>lua require"lisk.signature".persistent_toggle()<cr>')
utils.snoremap('<M-s>',
               '<cmd>lua require"lisk.signature".persistent_toggle()<cr>')
utils.nnoremap('<M-s>',
               '<cmd>lua require"lisk.signature".persistent_toggle()<cr>')

return M
