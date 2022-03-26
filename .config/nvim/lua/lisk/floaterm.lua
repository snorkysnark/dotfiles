vim.g.floaterm_title = ''
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
vim.g.floaterm_autoclose = 1

local utils = require('lisk.utils')

local function lf_callback(commands_file)
    vim.cmd('silent! source ' .. commands_file)
    pcall(os.remove, commands_file)
end

utils.add_global({
    floaterm = {
        lf_wrapper = function(cmd, _, config)
            local commands_file = vim.fn.tempname()
            cmd = cmd .. ' -config ~/.config/lf/lfrc-vim'

            if config.selectCurrent then
                local filename = vim.fn.expand('%:t')
                if filename ~= '' then
                    cmd = cmd .. ' -command "select ' ..
                              vim.fn.shellescape(filename) .. '"'
                end
            end

            return {
                value = {false, cmd},
                jobopts = {
                    on_exit = function()
                        lf_callback(commands_file)
                    end,
                    env = {NVIM_COMMANDS = commands_file}
                }
            }
        end
    }
})
utils.nnoremap('<leader>L', '<cmd>FloatermNew lf<cr>', {hint = 'Lf'})
utils.nnoremap('<leader><C-l>',
               '<cmd>FloatermNew --cwd=<buffer> --selectCurrent=true lf<cr>', {hint = 'Lf here'})

utils.nnoremap('<M-t>', '<cmd>FloatermToggle<cr>')
utils.tnoremap('<M-t>', '<cmd>FloatermToggle<cr>')
