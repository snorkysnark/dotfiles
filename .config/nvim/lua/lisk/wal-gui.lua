local function load_colors()
    vim.cmd([[source ]] .. os.getenv('HOME') .. [[/.cache/wal/colors-wal.vim]])

    local colors = {}
    for i = 0, 15 do colors[i] = vim.api.nvim_eval('color' .. i) end
    return colors
end
local colors = load_colors()

local function apply_highlights(highlights)
    for name, properties in pairs(highlights) do
        local cmd = 'hi ' .. name
        for prop, value in pairs(properties) do
            if prop == 'deco' then
                cmd = cmd .. ' gui=' .. value .. ' cterm=' .. value
            else
                cmd = cmd .. ' ' .. prop .. '=' .. value
            end
        end
        vim.cmd(cmd)
    end
end

local function apply_links(links)
    for from, to in pairs(links) do vim.cmd('hi link ' .. from .. ' ' .. to) end
end

local highlights = {
    Normal = {guibg = 'NONE', guifg = colors[7]},
    NonText = {guibg = 'NONE', guifg = colors[0]},
    Comment = {guibg = 'NONE', guifg = colors[8]},
    Conceal = {guibg = 'NONE'},
    Constant = {guibg = 'NONE', guifg = colors[3]},
    Error = {guibg = colors[1], guifg = colors[7]},
    Identifier = {guibg = 'NONE', guifg = colors[1], deco = 'BOLD'},
    Ignore = {guibg = colors[8], guifg = colors[0]},
    PreProc = {guibg = 'NONE', guifg = colors[3]},
    Special = {guibg = 'NONE', guifg = colors[6]},
    Statement = {guibg = 'NONE', guifg = colors[1]},
    String = {guibg = 'NONE', guifg = colors[2]},
    Number = {guibg = 'NONE', guifg = colors[3]},
    Todo = {guibg = colors[2], guifg = colors[0]},
    Type = {guibg = 'NONE', guifg = colors[3]},
    Underlined = {guibg = 'NONE', guifg = colors[1], deco = 'underline'},
    StatusLine = {guibg = colors[7], guifg = colors[0]},
    StatusLineNC = {guibg = colors[8], guifg = colors[0]},
    TabLine = {guibg = 'NONE', guifg = colors[8], deco = 'NONE'},
    TabLineFill = {guibg = 'NONE', guifg = colors[0]},
    TabLineSel = {guibg = colors[10], guifg = colors[0]},
    TermCursorNC = {guibg = colors[3], guifg = colors[0]},
    VertSplit = {guibg = colors[8], guifg = colors[0]},
    Title = {guibg = 'NONE', guifg = colors[4]},
    CursorLine = {guibg = colors[2], guifg = colors[0]},
    LineNr = {guibg = 'NONE', guifg = colors[8]},
    CursorLineNr = {guibg = 'NONE', guifg = colors[8]},
    helpLeadBlank = {guibg = 'NONE', guifg = colors[7]},
    helpNormal = {guibg = 'NONE', guifg = colors[7]},
    Visual = {guibg = '#4E4B61'},
    VisualNOS = {guibg = '#4E4B61'},
    Pmenu = {guibg = colors[8], guifg = colors[7]},
    PmenuSbar = {guibg = colors[6], guifg = colors[7]},
    PmenuSel = {guibg = colors[4], guifg = colors[0]},
    PmenuThumb = {guibg = colors[8], guifg = colors[8]},
    FoldColumn = {guibg = 'NONE', guifg = colors[7]},
    Folded = {guibg = 'NONE', guifg = colors[8]},
    WildMenu = {guibg = colors[2], guifg = colors[0]},
    SpecialKey = {guibg = 'NONE', guifg = colors[8]},
    DiffAdd = {guibg = 'NONE', guifg = colors[2]},
    DiffChange = {guibg = 'NONE', guifg = colors[8]},
    DiffDelete = {guibg = 'NONE', guifg = colors[1]},
    DiffText = {guibg = 'NONE', guifg = colors[4]},
    IncSearch = {guibg = colors[3], guifg = colors[0], deco = 'NONE'},
    Search = {guibg = colors[3], guifg = colors[0]},
    Directory = {guibg = 'NONE', guifg = colors[4]},
    MatchParen = {guibg = colors[1], guifg = colors[0]},
    ColorColumn = {guibg = colors[4], guifg = colors[0]},
    signColumn = {guibg = 'NONE', guifg = colors[4]},
    ErrorMsg = {guibg = 'NONE', guifg = colors[8]},
    MoreMsg = {guibg = 'NONE', guifg = colors[2]},
    Question = {guibg = 'NONE', guifg = colors[4]},
    WarningMsg = {guibg = colors[1], guifg = colors[0]},
    Cursor = {guibg = 'NONE', guifg = colors[8]},
    Structure = {guibg = 'NONE', guifg = colors[5]},
    CursorColumn = {guibg = colors[8], guifg = colors[7]},
    ModeMsg = {guibg = 'NONE', guifg = colors[7]},
    SpellBad = {guibg = 'NONE', guifg = colors[1], deco = 'underline'},
    SpellCap = {guibg = 'NONE', guifg = colors[4], deco = 'underline'},
    SpellLocal = {guibg = 'NONE', guifg = colors[5], deco = 'underline'},
    SpellRare = {guibg = 'NONE', guifg = colors[6], deco = 'underline'},
    Boolean = {guibg = 'NONE', guifg = colors[5]},
    Character = {guibg = 'NONE', guifg = colors[1]},
    Conditional = {guibg = 'NONE', guifg = colors[5]},
    Define = {guibg = 'NONE', guifg = colors[5]},
    Delimiter = {guibg = 'NONE', guifg = colors[5]},
    Float = {guibg = 'NONE', guifg = colors[5]},
    NormalFloat = {guibg = 'NONE', guifg = colors[5]},
    Include = {guibg = 'NONE', guifg = colors[4]},
    Keyword = {guibg = 'NONE', guifg = colors[5]},
    Label = {guibg = 'NONE', guifg = colors[3]},
    Operator = {guibg = 'NONE', guifg = colors[7]},
    Repeat = {guibg = 'NONE', guifg = colors[3]},
    SpecialChar = {guibg = 'NONE', guifg = colors[5]},
    Tag = {guibg = 'NONE', guifg = colors[3]},
    Typedef = {guibg = 'NONE', guifg = colors[3]},
    vimUserCommand = {guibg = 'NONE', guifg = colors[1], deco = 'BOLD'},
    vimNotation = {guibg = 'NONE', guifg = colors[4]},
    vimMapModKey = {guibg = 'NONE', guifg = colors[4]},
    vimBracket = {guibg = 'NONE', guifg = colors[7]},
    vimCommentString = {guibg = 'NONE', guifg = colors[8]},
    htmlLink = {guibg = 'NONE', guifg = colors[1], deco = 'underline'},
    htmlBold = {guibg = 'NONE', guifg = colors[3], deco = 'BOLD'},
    htmlItalic = {guibg = 'NONE', guifg = colors[5]},
    htmlEndTag = {guibg = 'NONE', guifg = colors[7]},
    htmlTag = {guibg = 'NONE', guifg = colors[7]},
    htmlTagName = {guibg = 'NONE', guifg = colors[1], deco = 'BOLD'},
    htmlH1 = {guibg = 'NONE', guifg = colors[7]},
    cssMultiColumnAttr = {guibg = 'NONE', guifg = colors[2]},
    cssBraces = {guibg = 'NONE', guifg = colors[7]},
    cssValueLength = {guibg = 'NONE', guifg = colors[7]},
    cssUnitDecorators = {guibg = 'NONE', guifg = colors[7]},
    cssValueNumber = {guibg = 'NONE', guifg = colors[7]},
    cssNoise = {guibg = 'NONE', guifg = colors[8]},
    cssTagName = {guibg = 'NONE', guifg = colors[1]},
    cssFunctionName = {guibg = 'NONE', guifg = colors[4]},
    scssSelectorChar = {guibg = 'NONE', guifg = colors[7]},
    scssAttribute = {guibg = 'NONE', guifg = colors[7]},
    sassidChar = {guibg = 'NONE', guifg = colors[1]},
    sassClassChar = {guibg = 'NONE', guifg = colors[5]},
    sassInclude = {guibg = 'NONE', guifg = colors[5]},
    sassMixing = {guibg = 'NONE', guifg = colors[5]},
    sassMixinName = {guibg = 'NONE', guifg = colors[4]},
    javaScript = {guibg = 'NONE', guifg = colors[7]},
    javaScriptBraces = {guibg = 'NONE', guifg = colors[7]},
    javaScriptNumber = {guibg = 'NONE', guifg = colors[5]},
    markdownH1 = {guibg = 'NONE', guifg = colors[7]},
    markdownAutomaticLink = {
        guibg = 'NONE',
        guifg = colors[2],
        deco = 'underline'
    },
    markdownError = {guibg = 'NONE', guifg = colors[7]},
    markdownCode = {guibg = 'NONE', guifg = colors[3]},
    markdownCodeBlock = {guibg = 'NONE', guifg = colors[3]},
    markdownCodeDelimiter = {guibg = 'NONE', guifg = colors[5]},
    markdownItalic = {deco = 'Italic'},
    markdownBold = {deco = 'Bold'},
    xdefaultsValue = {guibg = 'NONE', guifg = colors[7]},
    rubyInclude = {guibg = 'NONE', guifg = colors[4]},
    rubyDefine = {guibg = 'NONE', guifg = colors[5]},
    rubyFunction = {guibg = 'NONE', guifg = colors[4]},
    rubyStringDelimiter = {guibg = 'NONE', guifg = colors[2]},
    rubyInteger = {guibg = 'NONE', guifg = colors[3]},
    rubyAttribute = {guibg = 'NONE', guifg = colors[4]},
    rubyConstant = {guibg = 'NONE', guifg = colors[3]},
    rubyInterpolation = {guibg = 'NONE', guifg = colors[2]},
    rubyInterpolationDelimiter = {guibg = 'NONE', guifg = colors[3]},
    rubyRegexp = {guibg = 'NONE', guifg = colors[6]},
    rubySymbol = {guibg = 'NONE', guifg = colors[2]},
    rubyTodo = {guibg = 'NONE', guifg = colors[8]},
    rubyRegexpAnchor = {guibg = 'NONE', guifg = colors[7]},
    pythonOperator = {guibg = 'NONE', guifg = colors[5]},
    pythonFunction = {guibg = 'NONE', guifg = colors[4]},
    pythonRepeat = {guibg = 'NONE', guifg = colors[5]},
    pythonStatement = {guibg = 'NONE', guifg = colors[1], deco = 'Bold'},
    pythonBuiltIn = {guibg = 'NONE', guifg = colors[4]},
    phpMemberSelector = {guibg = 'NONE', guifg = colors[7]},
    phpComparison = {guibg = 'NONE', guifg = colors[7]},
    phpParent = {guibg = 'NONE', guifg = colors[7]},
    cOperator = {guibg = 'NONE', guifg = colors[6]},
    cPreCondit = {guibg = 'NONE', guifg = colors[5]},
    SignifySignAdd = {guibg = 'NONE', guifg = colors[2]},
    SignifySignChange = {guibg = 'NONE', guifg = colors[4]},
    SignifySignDelete = {guibg = 'NONE', guifg = colors[1]},
    NERDTreeDirSlash = {guibg = 'NONE', guifg = colors[4]},
    NERDTreeExecFile = {guibg = 'NONE', guifg = colors[7]},
    ALEErrorSign = {guibg = 'NONE', guifg = colors[1]},
    ALEWarningSign = {guibg = 'NONE', guifg = colors[3]},
    ALEError = {guibg = 'NONE', guifg = colors[1]},
    ALEWarning = {guibg = 'NONE', guifg = colors[3]},

    -- LSP
    LspDiagnosticsDefaultError = {guifg = "#db4b4b"},
    LspDiagnosticsDefaultWarning = {guifg = "#e0af68"},
    LspDiagnosticsDefaultInformation = {guifg = "#0db9d7"},
    LspDiagnosticsDefaultHint = {guifg = "#10B981"},

    LspDiagnosticsUnderlineError = {guisp = "#db4b4b", deco='undercurl'},
    LspDiagnosticsUnderlineWarning = {guisp = "#e0af68", deco='undercurl'},
    LspDiagnosticsUnderlineInformation = {guisp = "#0db9d7", deco='undercurl'},
    LspDiagnosticsUnderlineHint = {guisp = "#10B981", deco='undercurl'},

    -- Neovim treesitter
    TSInclude = {guibg = 'NONE', guifg = colors[5]},
    TSNamespace = {guibg = 'NONE', guifg = colors[4]},
    TSRepeat = {guibg = 'NONE', guifg = colors[5]},
    TSOperator = {guibg = 'NONE', guifg = colors[4]},

    -- Nvim Cmp
    CmpItemAbbr = {guifg = colors[7]},
    CmpItemAbbrMatch = {guifg = colors[9]},
    CmpItemAbbrMatchFuzzy = {guifg = colors[9]},
    CmpItemKind = {guifg = colors[3]}
}

local links = {
    vimMap = 'vimUserCommand',
    vimLet = 'vimUserCommand',
    vimCommand = 'vimUserCommand',
    vimFTCmd = 'vimUserCommand',
    vimAutoCmd = 'vimUserCommand',
    vimNotFunc = 'vimUserCommand',
    htmlH2 = 'htmlH1',
    htmlH3 = 'htmlH1',
    htmlH4 = 'htmlH1',
    htmlH5 = 'htmlH1',
    htmlH6 = 'htmlH1',
    cssFontAttr = 'cssMultiColumnAttr',
    cssFlexibleBoxAttr = 'cssMultiColumnAttr',
    cssAttrComma = 'cssBraces',
    cssValueLength = 'cssValueNumber',
    scssDefinition = 'cssNoise',
    markdownH2 = 'markdownH1',
    markdownH3 = 'markdownH1',
    markdownH4 = 'markdownH1',
    markdownH5 = 'markdownH1',
    markdownH6 = 'markdownH1',
    markdownUrl = 'markdownAutomaticLink',
    rubyRegexpQuantifier = 'rubyRegexpAnchor',

    Sneak = 'Search',
    LspDiagnosticsVirtualTextError = 'LspDiagnosticsDefaultError',
    LspDiagnosticsVirtualTextWarning = 'LspDiagnosticsDefaultWarning',
    LspDiagnosticsVirtualTextInformation = 'LspDiagnosticsDefaultInformation',
    LspDiagnosticsVirtualTextHint = 'LspDiagnosticsDefaultHint',
    LspReferenceText = 'CursorLine',
    LspReferenceRead = 'LspReferenceText',
    LspReferenceWrite = 'LspReferenceText',
}

vim.cmd [[hi clear]]
vim.o.background = 'dark'
if vim.fn.exists('syntax_on') then vim.cmd [[syntax reset]] end
vim.g.colors_name = 'wal-gui'
apply_highlights(highlights)
apply_links(links)
