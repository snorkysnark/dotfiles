local public = {}

-- number, relativenumber
local default_state = {number = true, relativenumber = true}
local o = vim.o

local function apply_saved()
    local state = vim.w.lisk_numberline or default_state
    o.number = state.number
    o.relativenumber = state.relativenumber
end

function public.set_relative()
    o.number = true
    o.relativenumber = true
end

function public.set_absolute()
    o.number = true
    o.relativenumber = false
end

local function set_enabled(value)
    if value then
        apply_saved()
    else
        vim.w.lisk_numberline = {
            number = o.number,
            relativenumber = o.relativenumber
        }
        o.number = false
        o.relativenumber = false
    end
end

function public.toggle_enabled() set_enabled(not (o.number or o.relativenumber)) end
function public.toggle_merge_signcolumn()
    if o.signcolumn == 'number' then
        o.signcolumn = 'auto'
    else
        o.signcolumn = 'number'
    end
end

return public
