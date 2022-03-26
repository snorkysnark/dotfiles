local lualine = require('lualine')
local lsp_status = require('lsp-status')

-- For some reason, 'setup' may be called multiple times o_0
local function fix_tabline_setup()
    local setup = lualine.setup
    lualine.setup = function(config)
        setup(config)
        vim.o.showtabline = 1
    end
end
fix_tabline_setup()

lualine.setup {
    options = {theme = 'gruvbox-material'},
    sections = {
        lualine_b = {'branch', 'diff', 'filename'},
        lualine_c = {function() return lsp_status.status() end}
    },
    tabline = {lualine_a = {{'tabs', mode = 1, max_length = vim.o.columns}}}
}

if vim.g.started_by_firenvim then
    vim.o.laststatus = 0
end
