local public = {}

vim.g.jupyter_mapkeys = false

local utils = require('lisk.utils')
function public.setup_python()
    utils.nnoremap('<localleader>c',
                   '<cmd>lua require"lisk.jupyter".connect_to_qtconsole()<cr>',
                   {'buffer'})

    utils.nnoremap('<localleader>E', '<cmd>JupyterSendRange<cr>', {'buffer'})
    utils.nmap('<localleader>e', '<Plug>JupyterRunTextObj', {'buffer'})
    utils.vmap('<localleader>e', '<Plug>JupyterRunVisual', {'buffer'})

    utils.nnoremap('<localleader>x', '<cmd>JupyterSendCell<cr>', {'buffer'})

    utils.nnoremap('<localleader>d', '<cmd>JupyterCd %:p:h<cr>', {'buffer'})
    utils.nnoremap('<localleader>s', [[<cmd>lua require('lisk.funcs').open_scratch{ft='python'}<cr>i]], {'buffer'})
end

local function is_qtconsole_open()
    local handle = io.popen('pgrep -f jupyter-qtconsole')
    local result = handle:read('*a')
    handle:close()
    return result ~= ''
end

function public.connect_to_qtconsole()
    if not is_qtconsole_open() then
        print('Starting QT Console')
        vim.cmd('silent exe "!pdm run jupyter qtconsole &disown"')

        local timer = vim.loop.new_timer()
        timer:start(1000, 1000, vim.schedule_wrap(function()
            if is_qtconsole_open() then
                vim.cmd('JupyterConnect')
                timer:close()
            end
        end))
    else
        vim.cmd('JupyterConnect')
    end
end
utils.augroup('lisk_jupyter',
              [[autocmd FileType python lua require'lisk.jupyter'.setup_python()]])

return public
