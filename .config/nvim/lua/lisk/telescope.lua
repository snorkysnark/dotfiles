local utils = require('lisk.utils')
local ts = require('telescope')
ts.setup {
    defaults = {
        layout_strategy = 'flex',
        layout_config = {horizontal = {preview_cutoff = 99, width = 0.9}}
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
        }
    },
    pickers = {
        buffers = {
            mappings = {
                i = { ["<c-d>"] = "delete_buffer" },
                n = { ["dd"] = "delete_buffer" },
            }
        }
    }
}
ts.load_extension('fzf')

utils.nnoremap('<leader>ft', '<cmd>Telescope<cr>')
utils.nnoremap('<leader>fr', '<cmd>Telescope resume<cr>')

utils.nnoremap('<leader>ff', '<cmd>Telescope find_files<cr>')
utils.nnoremap('<leader>fF', '<cmd>Telescope find_files no_ignore=true<cr>')
utils.nnoremap('<leader>fb', '<cmd>Telescope buffers<cr>')
utils.nnoremap('<leader>fh', '<cmd>Telescope help_tags<cr>')
utils.nnoremap('<leader>fg', '<cmd>Telescope live_grep<cr>')

utils.nnoremap('<leader>fT', '<cmd>Telescope filetypes<cr>')

require('which-key').register {["<leader>f"] = {name = "+find"}}
