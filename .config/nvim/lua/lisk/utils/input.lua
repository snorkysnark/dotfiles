local public = {}
local wk = require('which-key')

local function generic_map(noremap, mode, key, command, args_list)
    local flags = {}
    local buffer = nil

    if args_list then
        if not args_list[1] then args_list = {args_list} end

        for _, arg in ipairs(args_list) do
            if type(arg) == 'table' then
                for arg_name, arg_value in pairs(arg) do
                    if arg_name == 'buffer' then
                        buffer = arg_value
                    elseif arg_name == 'hint' then
                        wk.register({[key] = arg_value})
                    end
                end
            elseif arg == 'buffer' then
                buffer = 0
            else
                flags[arg] = true
            end
        end
    end

    if noremap then flags.noremap = true end

    if buffer then
        vim.api.nvim_buf_set_keymap(buffer, mode, key, command, flags)
    else
        vim.api.nvim_set_keymap(mode, key, command, flags)
    end
end

local modes = {'', 'm', 'n', 'v', 'x', 's', 'o', 'm', 'i', 'l', 'c', 't'}
for _, mode in ipairs(modes) do
    public[mode .. 'map'] = function(key, command, opts)
        generic_map(false, mode, key, command, opts)
    end

    public[mode .. 'noremap'] = function(key, command, opts)
        generic_map(true, mode, key, command, opts)
    end
end

return public
