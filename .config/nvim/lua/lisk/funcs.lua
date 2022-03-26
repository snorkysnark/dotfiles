local public = {}
local utils = require('lisk.utils')

function public.execute_macro_over_visual_range()
    print('@' .. vim.fn.getcmdline())
    vim.cmd([['<,'>normal @]] .. vim.fn.nr2char(vim.fn.getchar()))
end

public.remove_hilight_cmds = {"noh"}

function public.remove_highlignt()
    for _, command in ipairs(public.remove_hilight_cmds) do vim.cmd(command) end
end

function public.edit_vim_config()
    if utils.current_tab_empty() then
        vim.cmd('edit ' .. utils.init_lua .. ' | tcd ' .. utils.config_folder)
    else
        vim.cmd('tabe ' .. utils.init_lua .. ' | tcd ' .. utils.config_folder)
    end
end

function public.open_scratch(options)
    vim.cmd [[
    new
    setlocal nobuflisted
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    ]]
    for key, value in pairs(options) do
        if value == true then
            vim.cmd('setlocal ' .. key)
        else
            vim.cmd('setlocal ' .. key .. '=' .. value)
        end
    end
end

public.formatting = {}
function public.format()
    local format_func = public.formatting[vim.bo.filetype]
    if format_func then
        format_func()
    else
        vim.lsp.buf.formatting_sync()
        vim.cmd('w')
    end
end

function public.cd_here(cd_command)
    local path = vim.fn.expand('%:h')
    local full_cmd = cd_command..' '..path
    vim.cmd(full_cmd)
    print(full_cmd)
end

return public
