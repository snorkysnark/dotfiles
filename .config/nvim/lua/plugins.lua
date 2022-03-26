-- vim: set foldmethod=marker:
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}
    use {
        'antoinemadec/FixCursorHold.nvim',
        config = function() vim.g.cursorhold_updatetime = 300 end
    }
    use 'AndrewRadev/bufferize.vim'
    use {
        "kwkarlwang/bufresize.nvim",
        config = function()
            if not vim.g.started_by_firenvim then
                require("bufresize").setup()
            end
        end
    }

    -- {{{ Colorscheme
    use {
        'morhetz/gruvbox',
        config = function()
            if os.getenv('DISPLAY') then
                vim.cmd [[
                colorscheme gruvbox
                hi Visual guibg=#665c54 gui=NONE
                hi SignColumn guibg=#282828

                hi link LspSagaLightBulb GruvboxAqua
                hi link FloatermBorder NONE

                " gray
                highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
                " blue
                highlight! CmpItemAbbrMatch guibg=NONE guifg=#D6565B
                highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#D4474F
                " light blue
                highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
                highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
                highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
                " pink
                highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
                highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
                " front
                highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
                highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
                highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
                ]]
            end
        end
    }
    use 'folke/lsp-colors.nvim'
    -- }}}

    -- {{{ Text
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'inkarkat/vim-ReplaceWithRegister'
    use {
        'junegunn/vim-easy-align',
        config = function()
            local utils = require('lisk.utils')
            utils.nmap('ga', '<Plug>(EasyAlign)')
            utils.xmap('ga', '<Plug>(EasyAlign)')
        end
    }
    use {'windwp/nvim-autopairs', config = "require('lisk.autopairs')"}
    use 'Vimjas/vim-python-pep8-indent'
    use 'machakann/vim-swap'
    use {'kana/vim-textobj-entire', requires = {'kana/vim-textobj-user'}}
    use {
        "terrortylor/nvim-comment",
        config = function()
            require('nvim_comment').setup()
        end
    }
    -- }}}

    -- {{{ Syntax
    use 'RRethy/nvim-treesitter-textsubjects'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = "require('lisk.treesitter')"
    }
    use 'fladson/vim-kitty'
    use 'baskerville/vim-sxhkdrc'
    use 'VebbNix/lf-vim'
    use {
        'lifepillar/pgsql.vim',
        config = function() vim.g.sql_type_default = 'pgsql' end
    }
    use 'chrisbra/csv.vim'
    -- }}}

    -- {{{ LSP
    use {
        'ray-x/lsp_signature.nvim',
        config = function()
        end
    }
    use {
        'tami5/lspsaga.nvim',
        config = "require('lisk.signature')"
    }
    use {
        'nvim-lua/lsp-status.nvim',
        config = function()
            local lsp_status = require('lsp-status')
            lsp_status.config {
                status_symbol = ' ',
                indicator_warnings = "",
                indicator_info = "",
                indicator_hint = "",
                current_function = false
            }
            lsp_status.register_progress()
        end
    }
    use {'neovim/nvim-lspconfig', config = "require('lisk.lsp')"}
    use {
        'simrat39/rust-tools.nvim',
        requires = {
            'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim'
        }
    }
    -- }}}

    -- {{{ Completion
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use { 'onsails/lspkind-nvim', commit = '06872e887e7e4579765cc51fa6b0e7643b4284fa' }
    use {'hrsh7th/nvim-cmp', config = "require('lisk.cmp')"}
    -- }}}

    -- {{{ REPL
    use {'jupyter-vim/jupyter-vim', config = "require('lisk.jupyter')"}
    use 'tpope/vim-dadbod'
    use 'kristijanhusak/vim-dadbod-ui'
    use {'iamcco/markdown-preview.nvim', run = ':call mkdp#util#install()'}
    -- }}}

    -- {{{ UI
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require("indent_blankline").setup {
                char = "",
                buftype_exclude = {"terminal", "help"},
                filetype_exclude = {"packer", "dbui", "dbout"},
                show_trailing_blankline_indent = false,
                show_first_indent_level = false
            }
        end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = "require('lisk.lualine')"
    }
    use {
        'rrethy/vim-hexokinase',
        run = 'make hexokinase',
        config = function()
            vim.g.Hexokinase_ftEnabled = {}

            local utils = require('lisk.utils')
            utils.nnoremap('<leader>sc', '<cmd>HexokinaseToggle<cr>')
        end
    }
    use {'voldikss/vim-floaterm', config = "require('lisk.floaterm')"}
    use {
        "folke/which-key.nvim",
        config = function() require("which-key").setup {} end
    }
    use {
        'KabbAmine/vCoolor.vim',
        setup = function() vim.g.vcoolor_disable_mappings = true end,
        config = function()
            local utils = require('lisk.utils')
            utils.nnoremap('<M-c>', '<cmd>VCoolor<cr>')
        end
    }
    -- }}}

    -- {{{ Navigation
    use {
        'justinmk/vim-sneak',
        config = function()
            vim.g['sneak#use_ic_scs'] = true
            local utils = require('lisk.utils')

            utils.map('f', '<Plug>Sneak_f')
            utils.map('F', '<Plug>Sneak_F')
            utils.map('t', '<Plug>Sneak_t')
            utils.map('T', '<Plug>Sneak_T')

            table.insert(require('lisk.funcs').remove_hilight_cmds,
                         "call sneak#util#removehl()")
        end
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}},
        config = "require('lisk.telescope')"
    }
    -- }}}

    -- {{{ Formatting
    use {
        'andrejlevkovitch/vim-lua-format',
        config = function()
            require('lisk.funcs').formatting.lua = function()
                vim.cmd("call LuaFormat()")
                vim.cmd("w")
            end
        end
    }
    use {
        'ambv/black',
        config = function()
            require('lisk.funcs').formatting.python = function()
                vim.cmd("silent Black")
                vim.cmd("w")
            end
        end
    }
    -- }}}

    -- {{{ Debugging
    use {
        'mfussenegger/nvim-dap',
        config = "require('lisk.dap')",
        requires = {
            'rcarriga/nvim-dap-ui'
        }
    }
    -- }}}

    use 'tpope/vim-fugitive'

    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }
end)
