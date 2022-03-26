require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-S-j>",
            node_incremental = "<C-S-j>",
            scope_incremental = "<C-S-l>",
            node_decremental = "<C-S-k>"
        }
    },
    textsubjects = {
        enable = true,
        keymaps = {
            ['.'] = 'textsubjects-smart',
            ['Y'] = 'textsubjects-container-outer'
        }
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        }
    }
}

local utils = require('lisk.utils')
utils.nnoremap('<leader>sh', '<cmd>TSBufToggle highlight<cr>')
