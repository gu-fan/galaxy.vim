"=============================================================
"  Script: Galaxy
"    File: autoload/galaxy.vim
" Summary: A colorscheme that makes scheming colors easier.
"  Author: Rykka <Rykka10(at)gmail.com>
" Last Update: 2012-04-04
"=============================================================
let s:save_cpo = &cpo
set cpo&vim
" CHCK "{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if version < 700
    finish
else
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
" VARS "{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:galaxy         = {}
let g:galaxy.name    = "_GALAXY_"
let g:galaxy.version = "1.3.0"
let g:galaxy.winpos  = "bot"
" g:options "{{{2
function! s:default(option, value) "{{{
    if !exists(a:option)
        let {a:option} = a:value
        return 0
    endif
    return 1
endfunction "}}}
call s:default("g:galaxy_debug",            0)
call s:default("g:galaxy_enable_indent_hl", 1)
call s:default("g:galaxy_indent_hl_pos",    "start")
call s:default("g:galaxy_show_trailing_ws", 1)
call s:default("g:galaxy_indent_hl_ftype",   "python,c,javascript")
call s:default("g:galaxy_colorful_syntax",  1)
call s:default("g:galaxy_load_syn_dict",    1)
call s:default("g:galaxy_load_syn_tuning",    1)
call s:default("g:galaxy_visual_hl_fg",     0)
call s:default("g:galaxy_tcursor_color",    "DarkGray")

call s:default("g:galaxy_statusline_blink", 1)
call s:default("g:galaxy_auto_statusline",  1)
call s:default("g:galaxy_statusline_default", 
            \'%4*%(%3n %)%3*%( %Y %)%2*%( %M%R %)%1*%( %k %)'.
            \'%* %{galaxy#show_mode()} '.
            \'%5* %<%F %='.
            \'%6*%( %{&ff},%{&enc} %)%7* %03l %8* %03c %9* %P '
            \)

if !exists("g:galaxy_cache_File") "{{{
    if has("win32") || has("win64")
        if exists('$HOME')
            let g:galaxy_cache_File = expand('$HOME') . '\.vim_galaxy_cache'
        else
            let g:galaxy_cache_File = expand('$VIM') . '\.vim_galaxy_cache'
        endif
    else
        let g:galaxy_cache_File = expand('$HOME') . '/.vim_galaxy_cache'
    endif
endif "}}}
if !exists("g:galaxy_store_Folder") "{{{
    if has("win32") || has("win64")
        if exists('$HOME')
            let g:galaxy_store_Folder = expand('$HOME').'\vimfiles\colors\galaxy\'
        else
            let g:galaxy_store_Folder = expand('$VIM').'\vimfiles\colors\galaxy\'
        endif
    else
        let g:galaxy_store_Folder = expand('$HOME') . '/.vim/colors/galaxy/'
    endif
endif "}}}

" s:misc_var "{{{2
let s:nocolor = "NONE"
let s:fg      = "fg"
let s:bg      = "bg"
let s:n       = "NONE"
let s:c       = ",undercurl"
let s:r       = ",reverse"
let s:s       = ",standout"
let s:b       = ",bold"
let s:u       = ",underline"
let s:i       = ",italic"

let s:pre_name_list=[
            \ "Red"     , "LightRed"     , "DarkRed"     ,
            \ "Green"   , "LightGreen"   , "DarkGreen"   , "SeaGreen"   ,
            \ "Blue"    , "LightBlue"    , "DarkBlue"    , "SlateBlue"  ,
            \ "Cyan"    , "LightCyan"    , "DarkCyan"    ,
            \ "Magenta" , "LightMagenta" , "DarkMagenta" ,
            \ "Yellow"  , "LightYellow"  , "Brown"       , "DarkYellow" ,
            \ "Gray"    , "LightGray"    , "DarkGray"    ,
            \ "Black"   , "White"        ,
            \ "Orange"  , "Purple"       , "Violet"      ,
            \]
for i in s:pre_name_list
    let i=tolower(i)
    let s:{i}=i
endfor

if has("gui_running")
    let s:mode="gui"
else
    let s:mode="cterm"
endif

let s:prev_dict={}
let s:tips_list=[
            \'Load: 2-Click/Space/<CR>',
            \'New: gn           Del: dd/D',
            \'Select:Click      Edit: e',
            \'Help: F1          Quit: q/Q',
            \]
let s:clr_helptxt=[
            \"Foreground Color(Normal Foreground)",
            \"Syntax Color(Vars,Functions,...)",
            \"Message Color(ErrorMsg,ModeMsg,...)",
            \"Background(Normal Background)",
            \"Diff(DiffAdd,DiffChange,... Background)"]
" s:gui "{{{2
" default hl"{{{
let s:default_hl=[
            \["Normal",         "fgdclr0",  "bgdclr0",  "n"     ],
            \["Italic",         "nocolor",  "nocolor",  "i"     ],
            \["Bold",           "nocolor",  "nocolor",  "b"     ],
            \["BoldItalic",     "nocolor",  "nocolor",  "ib"    ],
            \["Underlined",     "nocolor",  "nocolor",  "u"     ],
            \["Undercurl",      "nocolor",  "nocolor",  "c"     ],
            \["ErrorMsg",       "bgdclr0",  "msgclr0",  "b"     ],
            \["WarningMsg",     "bgdclr0",  "msgclr2",  "b"     ],
            \["MoreMsg",        "bgdclr0",  "msgclr4",  "b"     ],
            \["Question",       "bgdclr0",  "msgclr6",  "b"     ],
            \["ModeMsg",        "bgdclr0",  "msgclr8",  "b"     ],
            \["MatchParen",     "bgdclr0",  "bgdclr6",  "b"     ],
            \["Error",          "nocolor",  "difclr5",  "b"     ],
            \["SpellBad",       "nocolor",  "difclr1",  "n"     ],
            \["SpellCap",       "SpellBad"      ],
            \["SpellLocal",     "nocolor",  "difclr5",  "n"     ],
            \["SpellRare",      "SpellLocal"    ],
            \["Todo",           "msgclr5",  "bgdclr2",  "b"     ],
            \["Title",          "msgclr0",  "nocolor",  "b"     ],
            \["Conceal",        "bgdclr2",  "nocolor",  "n"     ],
            \["Comment",        "bgdclr5",  "nocolor",  "n"     ],
            \["NonText",        "Comment"       ],
            \["Ignore",         "Comment"       ],
            \["SpecialComment", "bgdclr6",  "nocolor",  "b"     ],
            \["DiffDelete",     "bgdclr0",  "bgdclr2",  "n"     ],
            \["DiffAdd",        "fgdclr2",  "difclr0",  "n"     ],
            \["DiffChange",     "fgdclr2",  "difclr6",  "n"     ],
            \["DiffText",       "fgdclr2",  "difclr3",  "n"     ],
            \] "}}}
" syn 0 "{{{
let s:syn_hl_0=[
            \["Keyword",        "synclr9",  "nocolor",  "b"     ],
            \["Statement",      "synclr9",  "nocolor",  "n"     ],
            \["Conditional",    "synclr9",  "nocolor",  "i"     ],
            \["Repeat",         "synclr9",  "nocolor",  "i"     ],
            \["Label",          "synclr9",  "nocolor",  "b"     ],
            \["PreProc",        "synclr1",  "nocolor",  "n"     ],
            \["Include",        "synclr1",  "nocolor",  "b"     ],
            \["Define",         "synclr1",  "nocolor",  "b"     ],
            \["PreCondit",      "Define"        ],
            \["Macro",          "synclr1",  "nocolor",  "ib"    ],
            \["Special",        "synclr2",  "bgdclr0",  "n"     ],
            \["Delimiter",      "synclr2",  "nocolor",  "b"     ],
            \["SpecialChar",    "synclr2",  "nocolor",  "i"     ],
            \["Debug",          "synclr2",  "nocolor",  "bi"    ],
            \["SpecialKey",     "SpecialChar"   ],
            \["Tag",            "Special"       ],
            \["Type",           "synclr3",  "nocolor",  "n"     ],
            \["Typedef",        "synclr3",  "nocolor",  "b"     ],
            \["StorageClass",   "synclr3",  "nocolor",  "i"     ],
            \["Structure",      "synclr3",  "nocolor",  "ib"     ],
            \["Directory",      "Type"          ],
            \["Identifier",     "synclr5",  "nocolor",  "b"     ],
            \["Constant",       "synclr5",  "nocolor",  "n"     ],
            \["Boolean",        "synclr5",  "nocolor",  "n"     ],
            \["Float",          "synclr5",  "nocolor",  "i"     ],
            \["String",         "synclr7",  "nocolor",  "n"     ],
            \["Character",      "synclr7",  "nocolor",  "i"     ],
            \["Function",       "synclr7",  "nocolor",  "b"     ],
            \["Keyword",        "synclr9",  "nocolor",  "b"     ],
            \["Operator",       "synclr9",  "nocolor",  "n"     ],
            \["Exception",      "synclr9",  "nocolor",  "bi"    ],
            \] "}}}
" syn 1 "{{{
let s:syn_hl_1=[
            \["Keyword",        "synclr0",  "nocolor",  "b"     ],
            \["Statement",      "synclr0",  "nocolor",  "n"     ],
            \["Conditional",    "synclr0",  "nocolor",  "i"     ],
            \["Repeat",         "synclr0",  "nocolor",  "i"     ],
            \["Label",          "synclr0",  "nocolor",  "b"     ],
            \["PreProc",        "synclr1",  "nocolor",  "n"     ],
            \["Include",        "synclr1",  "nocolor",  "b"     ],
            \["Define",         "synclr1",  "nocolor",  "b"     ],
            \["PreCondit",      "Define"        ],
            \["Macro",          "synclr1",  "nocolor",  "ib"    ],
            \["Special",        "synclr2",  "bgdclr0",  "n"     ],
            \["Delimiter",      "synclr2",  "nocolor",  "b"     ],
            \["SpecialChar",    "synclr2",  "nocolor",  "i"     ],
            \["Debug",          "synclr2",  "nocolor",  "bi"    ],
            \["SpecialKey",     "SpecialChar"   ],
            \["Tag",            "Special"       ],
            \["Type",           "synclr3",  "nocolor",  "n"     ],
            \["Typedef",        "synclr3",  "nocolor",  "b"     ],
            \["StorageClass",   "synclr4",  "nocolor",  "i"     ],
            \["Structure",      "synclr4",  "nocolor",  "ib"     ],
            \["Directory",      "Type"          ],
            \["Identifier",     "synclr5",  "nocolor",  "b"     ],
            \["Constant",       "synclr5",  "nocolor",  "n"     ],
            \["Boolean",        "synclr5",  "nocolor",  "n"     ],
            \["Float",          "synclr5",  "nocolor",  "i"     ],
            \["String",         "synclr7",  "nocolor",  "n"     ],
            \["Character",      "synclr7",  "nocolor",  "i"     ],
            \["Function",       "synclr7",  "nocolor",  "b"     ],
            \["Keyword",        "synclr9",  "nocolor",  "b"     ],
            \["Operator",       "synclr9",  "nocolor",  "n"     ],
            \["Exception",      "synclr9",  "nocolor",  "bi"    ],
            \] "}}}
" s:styles "{{{2
let s:hl_styles = {}
" default "{{{
let s:hl_styles.GALAXY = [
        \["Cursor",         "bgdclr1",  "msgclr8",  "n"     ],
        \["CursorIM",       "nocolor",  "synclr4",  "n"     ],
        \["CursorLine",     "nocolor",  "bgdclr1",  "n"     ],
        \["CursorColumn",   "CursorLine"    ],
        \["Visual",         "nocolor",  "bgdclr4",  "n"     ],
        \["VisualNOS",      "nocolor",  "bgdclr5",  "n"     ],
        \["Search",         "bgdclr1",  "fgdclr4",  "n"     ],
        \["IncSearch",      "bgdclr0",  "msgclr2",  "b"     ],
        \["Wildmenu",       "msgclr1",  "bgdclr1",  "b"     ],
        \["Pmenu",          "fgdclr1",  "bgdclr1",  "n"     ],
        \["PmenuSel",       "fgdclr1",  "bgdclr1",  "rb"    ],
        \["PmenuSbar",      "fgdclr1",  "fgdclr6",  "n"     ],
        \["PmenuThumb",     "bgdclr0",  "fgdclr2",  "n"     ],
        \["Folded",         "bgdclr5",  "bgdclr2",  "n"     ],
        \["ColorColumn",    "Folded"        ],
        \["FoldColumn",     "bgdclr5",  "bgdclr2",  "n"     ],
        \["LineNr",         "bgdclr4",  "bgdclr1",  "n"     ],
        \["SignColumn",     "msgclr2",  "bgdclr2",  "n"     ],
        \["TabLine",        "bgdclr0",  "bgdclr4",  "n"     ],
        \["TabLineSel",     "fgdclr1",  "bgdclr0",  "b"     ],
        \["TabLineFill",    "bgdclr0",  "bgdclr3",  "n"     ],
        \["StatusLine",     "msgclr2",  "difclr0",  "b"     ],
        \["StatusLineNC",   "bgdclr0",  "bgdclr3",  "n"     ],
        \["VertSplit",      "StatusLineNC"  ],
        \["User1",          "fgdclr4",  "difclr1",  "b"     ],
        \["User2",          "fgdclr3",  "difclr2",  "b"     ],
        \["User3",          "fgdclr2",  "difclr3",  "b"     ],
        \["User4",          "fgdclr1",  "difclr4",  "b"     ],
        \["User5",          "fgdclr0",  "bgdclr3",  "b"     ],
        \["User6",          "bgdclr1",  "bgdclr4",  "b"     ],
        \["User7",          "bgdclr2",  "bgdclr5",  "b"     ],
        \["User8",          "bgdclr3",  "bgdclr6",  "b"     ],
        \["User9",          "bgdclr4",  "bgdclr7",  "b"     ],
        \] "}}}
"{{{ Shadow
let s:hl_styles.SHADOW = [
        \["Cursor",         "bgdclr1",  "msgclr8",  "n"     ],
        \["CursorLine",     "nocolor",  "bgdclr2",  "n"     ],
        \["CursorIM",       "nocolor",  "synclr4",  "n"     ],
        \["CursorLine",     "nocolor",  "bgdclr1",  "n"     ],
        \["CursorColumn",   "CursorLine"    ],
        \["Visual",         "nocolor",  "bgdclr3",  "n"     ],
        \["VisualNOS",      "nocolor",  "bgdclr2",  "n"     ],
        \["Search",         "fgdclr2",  "bgdclr3",  "n"     ],
        \["IncSearch",      "bgdclr0",  "msgclr2",  "b"     ],
        \["Wildmenu",       "fgdclr1",  "bgdclr2",  "rb"    ],
        \["Pmenu",          "bgdclr6",  "bgdclr1",  "n"     ],
        \["PmenuSel",       "fgdclr1",  "bgdclr1",  "rb"    ],
        \["PmenuSbar",      "bgdclr6",  "bgdclr1",  "n"     ],
        \["PmenuThumb",     "bgdclr0",  "bgdclr4",  "n"     ],
        \["Folded",         "bgdclr5",  "bgdclr1",  "n"     ],
        \["ColorColumn",    "Folded"        ],
        \["FoldColumn",     "bgdclr5",  "bgdclr1",  "n"     ],
        \["LineNr",         "bmdclr0",  "bgdclr2",  "n"     ],
        \["SignColumn",     "msgclr2",  "bgdclr1",  "n"     ],
        \["TabLine",        "bmdclr0",  "bgdclr3",  "n"     ],
        \["TabLineSel",     "fgdclr2",  "bgdclr0",  "b"     ],
        \["TabLineFill",    "bmdclr0",  "bgdclr2",  "n"     ],
        \["StatusLine",     "difclr0",  "msgclr0",  "b"     ],
        \["StatusLineNC",   "bgdclr0",  "bgdclr3",  "n"     ],
        \["VertSplit",      "StatusLineNC"  ],
        \["User1",          "fgdclr4",  "bgdclr1",  "b"     ],
        \["User2",          "fgdclr3",  "bgdclr2",  "b"     ],
        \["User3",          "fgdclr2",  "bgdclr3",  "b"     ],
        \["User4",          "fgdclr1",  "bgdclr4",  "b"     ],
        \["User5",          "bgdclr0",  "bgdclr5",  "b"     ],
        \["User6",          "bgdclr1",  "bgdclr6",  "b"     ],
        \["User7",          "bgdclr2",  "bgdclr7",  "b"     ],
        \["User8",          "bgdclr3",  "bgdclr8",  "b"     ],
        \["User9",          "bgdclr4",  "bgdclr9",  "b"     ],
        \] "}}}
"{{{ Abound
let s:hl_styles.ABOUND = [
        \["Cursor",         "bgdclr1",  "msgclr8",  "n"     ],
        \["CursorIM",       "nocolor",  "synclr4",  "n"     ],
        \["CursorLine",     "nocolor",  "bgdclr1",  "n"     ],
        \["CursorColumn",   "CursorLine"    ],
        \["Visual",         "nocolor",  "fgdclr6",  "n"     ],
        \["VisualNOS",      "nocolor",  "fgdclr5",  "n"     ],
        \["Search",         "fgdclr0",  "bgdclr4",  "n"     ],
        \["IncSearch",      "fgdclr9",  "msgclr2",  "b"     ],
        \["Wildmenu",       "synclr0",  "fgdclr2",  "rb"    ],
        \["Pmenu",          "fgdclr0",  "fgdclr9",  "n"     ],
        \["PmenuSel",       "bgdclr8",  "bgdclr0",  "rb"    ],
        \["PmenuSbar",      "fgdclr1",  "fgdclr5",  "n"     ],
        \["PmenuThumb",     "bgdclr2",  "fgdclr2",  "n"     ],
        \["Folded",         "fgdclr3",  "fgdclr8",  "n"     ],
        \["ColorColumn",    "Folded"        ],
        \["FoldColumn",     "fgdclr6",  "fgdclr8",  "n"     ],
        \["LineNr",         "fgdclr4",  "fgdclr9",  "n"     ],
        \["SignColumn",     "msgclr2",  "fgdclr4",  "n"     ],
        \["TabLine",        "fgdclr8",  "fgdclr3",  "n"     ],
        \["TabLineSel",     "fgdclr1",  "bgdclr0",  "b"     ],
        \["TabLineFill",    "bgdclr0",  "fgdclr4",  "n"     ],
        \["StatusLine",     "difclr0",  "msgclr0",  "b"     ],
        \["StatusLineNC",   "fgdclr4",  "fgdclr6",  "n"     ],
        \["VertSplit",      "StatusLineNC"  ],
        \["User1",          "bgdclr0",  "msgclr1",  "b"     ],
        \["User2",          "bgdclr0",  "msgclr2",  "b"     ],
        \["User3",          "bgdclr0",  "msgclr3",  "b"     ],
        \["User4",          "bgdclr0",  "msgclr4",  "b"     ],
        \["User5",          "fgdclr1",  "fgdclr6",  "b"     ],
        \["User6",          "fgdclr0",  "fgdclr5",  "b"     ],
        \["User7",          "bgdclr4",  "fgdclr4",  "b"     ],
        \["User8",          "bgdclr3",  "fgdclr3",  "b"     ],
        \["User9",          "bgdclr2",  "fgdclr2",  "b"     ],
        \] "}}}
"{{{ Coulor
let s:hl_styles.COLOUR = [
        \["Cursor",         "bgdclr1",  "msgclr4",  "n"     ],
        \["CursorIM",       "nocolor",  "synclr4",  "n"     ],
        \["CursorLine",     "nocolor",  "bgdclr1",  "n"     ],
        \["CursorColumn",   "CursorLine"    ],
        \["Visual",         "nocolor",  "bgdclr4",  "n"     ],
        \["VisualNOS",      "nocolor",  "bgdclr3",  "n"     ],
        \["Search",         "fgdclr1",  "bgdclr4",  "n"     ],
        \["IncSearch",      "bgdclr0",  "msgclr2",  "b"     ],
        \["Wildmenu",       "difclr0",  "fgdclr2",  "rb"    ],
        \["Pmenu",          "bgdclr0",  "fgdclr2",  "n"     ],
        \["PmenuSel",       "difclr1",  "fgdclr2",  "rb"    ],
        \["PmenuSbar",      "bgdclr1",  "fgdclr0",  "n"     ],
        \["PmenuThumb",     "bgdclr2",  "fgdclr6",  "n"     ],
        \["Folded",         "bgdclr8",  "bgdclr2",  "n"     ],
        \["ColorColumn",    "Folded"        ],
        \["FoldColumn",     "bgdclr4",  "bgdclr2",  "n"     ],
        \["LineNr",         "bgdclr6",  "bgdclr1",  "n"     ],
        \["SignColumn",     "msgclr2",  "bgdclr2",  "n"     ],
        \["TabLine",        "bgdclr0",  "fgdclr1",  "n"     ],
        \["TabLineSel",     "fgdclr2",  "bgdclr0",  "b"     ],
        \["TabLineFill",    "bgdclr0",  "fgdclr2",  "n"     ],
        \["StatusLine",     "difclr3",  "synclr0",  "b"     ],
        \["StatusLineNC",   "fgdclr8",  "fgdclr3",  "n"     ],
        \["VertSplit",      "StatusLineNC"  ],
        \["User1",          "difclr3",  "synclr1",  "b"     ],
        \["User2",          "difclr3",  "synclr2",  "b"     ],
        \["User3",          "difclr3",  "synclr3",  "b"     ],
        \["User4",          "difclr3",  "synclr4",  "b"     ],
        \["User5",          "bgdclr1",  "fgdclr3",  "b"     ],
        \["User6",          "bgdclr2",  "fgdclr4",  "b"     ],
        \["User7",          "bgdclr3",  "fgdclr5",  "b"     ],
        \["User8",          "fgdclr1",  "fgdclr6",  "b"     ],
        \["User9",          "fgdclr0",  "fgdclr7",  "b"     ],
        \] "}}}
"{{{term_list
let s:term_hl_list=[
            \["Normal",         "fg_t",  "bg_t",  "n"      ],
            \["Cursor",         "fg_t",  "bg_t",  "r"      ],
            \["CursorLine",     "black",  "dif2_t",  "n"   ],
            \["CursorColumn",   "CursorLine"               ],
            \["Visual",         "nocolor",  "fd_t",  "n"   ],
            \["VisualNOS",      "Visual"                   ],
            \["Search",         "nocolor",  "dif2_t",  "n" ],
            \["IncSearch",      "nocolor",  "msg1_t",  "n" ],
            \["Wildmenu",       "msg1_t",  "fg_t",  "r"    ],
            \["Pmenu",          "fg_t",  "cn_t",  "n"      ],
            \["PmenuSel",       "bg_t",  "msg1_t",  "n"    ],
            \["PmenuSbar",      "Pmenu"                    ],
            \["PmenuThumb",     "fg_t",  "msg2_t",  "n"    ],
            \["DiffAdd",        "nocolor",  "dif0_t",  "n" ],
            \["DiffChange",     "nocolor",  "dif1_t",  "n" ],
            \["DiffDelete",     "msg0_t",  "bg_t",  "b"    ],
            \["DiffText",       "nocolor",  "dif2_t",  "n" ],
            \["Folded",         "bg_t",  "fd_t",  "n"      ],
            \["FoldColumn",     "dif2_t",  "fd_t",  "n"    ],
            \["LineNr",         "Folded"                   ],
            \["SignColumn",     "msg1_t",  "fd_t",  "n"    ],
            \["ColorColumn",    "Folded"                   ],
            \["tabline",        "bg_t",  "fd_t",  "n"      ],
            \["tablinesel",     'syn0_t',  "bg_t",  "n"    ],
            \["tablinefill",    "cn_t",  "fg_t",  "n"      ],
            \["StatusLine",     "dif2_t",  "fg_t",  "n"    ],
            \["StatusLineNC",   "bg_t",  "fg_t",  "n"      ],
            \["VertSplit",      "StatusLineNC"             ],
            \["User1",          "msg0_t",  "fg_t",  "n"    ],
            \["User2",          "msg1_t",  "fg_t",  "n"    ],
            \["User3",          "msg2_t",  "fg_t",  "n"    ],
            \["User4",          "dif0_t",  "fg_t",  "n"    ],
            \["User5",          "dif1_t",  "fg_t",  "n"    ],
            \["User6",          "dif2_t",  "fg_t",  "n"    ],
            \["User7",          "dif2_t",  "fg_t",  "n"    ],
            \["User8",          "dif2_t",  "fg_t",  "n"    ],
            \["User9",          "dif2_t",  "fg_t",  "n"    ],
            \["MoreMsg",        "dif2_t",  "bg_t",  "n"    ],
            \["Question",       "msg1_t",  "bg_t",  "n"    ],
            \["ModeMsg",        "dif0_t",  "bg_t",  "n"    ],
            \["MatchParen",     "bg_t",  "syn1_t",  "n"    ],
            \["WarningMsg",     "cn_t",  "msg1_t",  "n"    ],
            \["SpellLocal",     "WarningMsg"               ],
            \["SpellRare",      "WarningMsg"               ],
            \["ErrorMsg",       "fg_t",  "msg0_t",  "n"    ],
            \["Error",          "ErrorMsg"                 ],
            \["SpellBad",       "Error"                    ],
            \["SpellCap",       "SpellBad"                 ],
            \["Todo",           "fg_t",  "dif0_t",  "n"    ],
            \["Title",          "msg0_t",  "nocolor",  "n" ],
            \["Conceal",        "cn_t",  "bg",  "n"        ],
            \["Comment",        "cn_t",  "bg",  "n"        ],
            \["NonText",        "Comment"                  ],
            \["Ignore",         "Comment"                  ],
            \["SpecialComment", "syn0_t",  "bg",  "n"      ],
            \["Underlined",     "ud_t",  "bg",  "n"        ],
            \["Keyword",        "syn0_t",  "bg",  "n"      ],
            \["Statement",      "syn0_t",  "bg",  "n"      ],
            \["Conditional",    "Statement"                ],
            \["Repeat",         "Statement"                ],
            \["Function",       "syn0_t",  "bg",  "n"      ],
            \["Structure",      "syn0_t",  "bg",  "n"      ],
            \["Exception",      "syn2_t",  "bg",  "r"      ],
            \["Debug",          "Exception"                ],
            \["SpecialChar",    "syn2_t",  "bg",  "n"      ],
            \["SpecialKey",     "SpecialChar"              ],
            \["Tag",            "SpecialChar"              ],
            \["PreProc",        "syn2_t",  "bg",  "n"      ],
            \["Include",         "PreProc"                 ],
            \["Define",         "PreProc"                  ],
            \["Macro",          "PreProc"                  ],
            \["PreCondit",      "PreProc"                  ],
            \["Special",        "syn2_t",  "bg",  "n"      ],
            \["Delimiter",      "Special"                  ],
            \["Type",           "syn3_t",  "bg",  "n"      ],
            \["Operator",       "Type"                     ],
            \["Directory",      "Type"                     ],
            \["Identifier",     "syn3_t",  "bg",  "n"      ],
            \["StorageClass",   "Identifier"               ],
            \["Constant",       "syn3_t",  "bg",  "n"      ],
            \["Boolean",        "Constant"                 ],
            \["Float",          "Constant"                 ],
            \["Number",         "Constant"                 ],
            \["String",         "syn1_t",  "bg",  "n"      ],
            \["Character",      "syn1_t",  "bg",  "n"      ],
            \["Label",          "syn1_t",  "bg",  "r"      ],
            \]
let s:b8_name=[
            \"DarkGrey","Blue","Green","Cyan","Red","Magenta","Yellow",
            \"White",
\]

let s:n8_num=[0,4,2,6,1,5,8,7]
let s:n8_name=[
            \"Black","DarkBlue","DarkGreen","DarkCyan","DarkRed","DarkMagenta","DarkYellow",
            \"LightGrey",
            \]
"}}}
function! s:set_light16_var() "{{{
    let s:fg_t   = "black"
    let s:bg_t   = "lightgrey"
    let s:cn_t   = "darkgrey"
    let s:fd_t   = "darkgrey"
    let s:ud_t   = "darkblue"
    let s:syn0_t = "darkcyan"
    let s:syn1_t = "darkgreen"
    let s:syn2_t = "darkmagenta"
    let s:syn3_t = "darkred"
    let s:msg0_t = "red"
    let s:msg1_t = "magenta"
    let s:msg2_t = "yellow"
    let s:dif0_t = "green"
    let s:dif1_t = "cyan"
    let s:dif2_t = "darkyellow"
endfunction "}}}
function! s:set_light8_var() "{{{
    let s:t_Co   = 8
    let s:fg_t   = "black"
    let s:bg_t   = "lightgrey"
    let s:cn_t   = "darkcyan"
    let s:fd_t   = "black"
    let s:ud_t   = "darkblue"
    let s:syn0_t = "darkblue"
    let s:syn1_t = "darkyellow"
    let s:syn2_t = "darkmagenta"
    let s:syn3_t = "darkred"
    let s:msg0_t = "red"
    let s:msg1_t = "magenta"
    let s:msg2_t = "yellow"
    let s:dif0_t = "green"
    let s:dif1_t = "cyan"
    let s:dif2_t = "darkgreen"
endfunction "}}}
function! s:set_dark16_var() "{{{
    let s:fg_t   = "lightgrey"
    let s:bg_t   = "black"
    let s:cn_t   = "darkgrey"
    let s:fd_t   = "darkgrey"
    let s:ud_t   = "blue"
    let s:syn0_t = "darkcyan"
    let s:syn1_t = "darkgreen"
    let s:syn2_t = "darkyellow"
    let s:syn3_t = "darkmagenta"
    let s:msg0_t = "red"
    let s:msg1_t = "magenta"
    let s:msg2_t = "yellow"
    let s:dif0_t = "darkgreen"
    let s:dif1_t = "darkcyan"
    let s:dif2_t = "darkmagenta"
endfunction "}}}
function! s:set_dark8_var() "{{{
    let s:t_Co=8
    let s:fg_t="lightgrey"
    let s:bg_t="black"
    let s:cn_t="darkgrey"
    let s:fd_t="white"
    let s:ud_t="blue"
    let s:syn0_t="darkcyan"
    let s:syn1_t="darkgreen"
    let s:syn2_t="darkyellow"
    let s:syn3_t="darkmagenta"
    let s:msg0_t="red"
    let s:msg1_t="magenta"
    let s:msg2_t="yellow"
    let s:dif0_t="darkgreen"
    let s:dif1_t="darkcyan"
    let s:dif2_t="darkmagenta"
endfunction "}}}
" s:schemes "{{{2
"                       bgd     fgd      syn      msg       dif
let s:default_schemes=[
            \{"name":"Black",
            \"colors":["000000","C1CBD6","9FB9D6","FF0D0D","4B6266"]},
            \{"name":"White",
            \"colors":["FFFFFF","000000","306399","FF0D0D","B0E1EB"]},
            \{"name":"Paper",
            \"colors":["EBE9E8","2B2C33","345B85","CC2020","D9A79E"]},
            \{"name":"Wine",
            \"colors":["0D0609","9C9B94","A37B5F","F03535","2D374A"]},
            \{"name":"Spring",
            \"colors":["D5E6A1","4B4B4D","496791","B32222","CCBE8F"],
            \"style":"SHADOW"},
            \{"name":"MoonNight",
            \"colors":["060F1A","B4B6B8","7FA5B8","C2A832","598099"],
            \"style":"SHADOW"},
            \{"name":"Factory",
            \"colors":["050505","A6A6A6","8296B3","54DEB0","404259"],
            \"style":"SHADOW"},
            \{"name":"Village",
            \"colors":["B1E6AC","362020","324F7D","1B488C","CCBD66"],
            \"style":"COLOUR"},
            \{"name":"Slates",
            \"colors":["F2EFE4","232733","386599","FF2828","D9B2AD"],
            \"style":"COLOUR"},
            \{"name":"InkGreen",
            \"colors":["0A0D07","A9BA93","8682D1","FF7236","363E4D"],
            \"style":"ABOUND"},
            \{"name":"RosyBlue",
            \"colors":["262633","CCC2C7","A681CC","54DFB1","404157"],
            \"style":"ABOUND"},
            \]
let s:win_txtline = 2
let s:win_builtin_line=len(s:default_schemes)

" SYNX "{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:synlink_dict     = {}
let s:syn_hi_gui_dict  = {}
let s:syn_hi_term_dict = {}
let s:synlink_dict.ada = [
            \["adaBegin             ","Structure       "          ],
            \["adaEnd               ","Structure       "          ],
            \["adaKeyword           ","Keyword         "          ],
            \]
let s:synlink_dict.cpp = [
            \["cppAccess            ","Structure       "          ],
            \["cppStatement         ","Special         "          ],
            \]
let s:synlink_dict.hs = [
            \["ConId                ","Structure  "               ],
            \["hsPragma             ","PreProc    "               ],
            \["hsConSym             ","Operator   "               ],
            \]
let s:synlink_dict.html = [
            \["htmlEndTag           ","Tag        "               ],
            \["htmlLink             ","Underlined "               ],
            \["htmlSpecialTagName   ","SpecialChar"               ],
            \["htmlTag              ","Tag        "               ],
            \["htmlTagName          ","Delimiter  "               ],
            \]
let s:synlink_dict.lisp = [
            \["lispFunc             ","Function   "               ],
            \["lispKey              ","Keyword    "               ],
            \]
let s:synlink_dict.netrw = [
            \["netrwDir             ","Special    "               ],
            \["netrwExe             ","Wildmenu   "               ],
            \["netrwSymLink         ","Statement  "               ],
            \]
let s:synlink_dict.pascal = [
            \["pascalAsmKey         ","Keyword       "            ],
            \["pascalDirective      ","PreProc       "            ],
            \["pascalModifier       ","Macro         "            ],
            \["pascalPredefined     ","Define        "            ],
            \["pascalStatement      ","Statement     "            ],
            \["pascalStruct         ","Structure     "            ],
            \]
let s:synlink_dict.php = [
            \["phpComparison        ","Special       "            ],
            \]
let s:synlink_dict.python = [
            \]
let s:synlink_dict.ruby = [
            \["rubyDefine           ","Typedef       "            ],
            \["rubyRegexp           ","Special       "            ],
            \]
let s:synlink_dict.scm = [
            \["schemeSyntax         ","Special       "            ],
            \]
let s:synlink_dict.sh = [
            \]
let s:synlink_dict.sql = [
            \["sqlKeyword           ","Keyword       "            ],
            \]
let s:synlink_dict.tex = [
            \["texDocType           ","PreProc       "            ],
            \["texLigature          ","Constant      "            ],
            \["texNewCmd            ","PreProc       "            ],
            \["texOnlyMath          ","Constant      "            ],
            \["texRefZone           ","Constant      "            ],
            \["texSection           ","Structure     "            ],
            \["texSectionMarker     ","Structure     "            ],
            \["texSectionModifier   ","Constant      "            ],
            \]
let s:synlink_dict.vim = [
            \["vimFuncKey           ","Function      "            ],
            \["vimOption            ","Keyword       "            ],
            \["vimHiAttrib          ","Constant      "            ],
            \["vimHiGroup           ","Special"                   ],
            \["vimCommentTitle      ","SpecialComment"            ],
            \["vimCommentTitleLeader","SpecialComment"            ],
            \["vimSpecial           ","Special       "            ],
            \]
let s:syn_hi_term_dict.vimwiki2 = [
            \["VimwikiHeader1       ", "Red",     "bg",  "b"      ],
            \["VimwikiHeader2       ", "Magenta", "bg",  "b"      ],
            \["VimwikiHeader3       ", "Blue",    "bg",  "b"      ],
            \["VimwikiHeader4       ", "Cyan",    "bg",  "b"      ],
            \["VimwikiHeader5       ", "Green",   "bg",  "b"      ],
            \["VimwikiHeader6       ", "Yellow",  "bg",  "b"      ],
            \]
let s:syn_hi_gui_dict.vimwiki2 = [
            \["VimwikiHeader1       ", "msgclr0",  "nocolor",  "b" ],
            \["VimwikiHeader2       ", "msgclr2",  "nocolor",  "b" ],
            \["VimwikiHeader3       ", "msgclr4",  "nocolor",  "b" ],
            \["VimwikiHeader4       ", "msgclr6",  "nocolor",  "b" ],
            \["VimwikiHeader5       ", "msgclr7",  "nocolor",  "b" ],
            \["VimwikiHeader6       ", "msgclr8",  "nocolor",  "b" ],
            \]
let s:synlink_dict.xml = [
            \["xmlProcessingDelim   ","PreProc       "            ],
            \["xmlNamespace         ","PreProc       "            ],
            \["xmlTag               ","Tag "                      ],
            \["xmlTagName           ","Delimiter"                 ],
            \]
let s:synlink_dict.galaxy = [
            \["galaxyItalic         ","msgclr2",  "nocolor",  "b" ],
            \]
function! s:syntax_tune() "{{{
    aug galaxy#syn
        au!
        au! Syntax vim call <SID>syn_vim()
    aug END
endfunction "}}}

function! s:syn_vim() "{{{
    " vim function and endfunction hl-group
    silent! syn clear vimFuncBody
    syn region	vimFuncBody  contained	start="\ze("	matchgroup=vimFuncKey end="\<\(endf\>\|endfu\%[nction]\>\)"		contains=@vimFuncBodyList
endfunction "}}}
" CLRS"{{{1
"======================================================================
function! s:gen_base_colors(colors) "{{{

    let NOCYCLE = 0
    let [bgd, fgd, syn, msg, dif] = a:colors
    let H = exists("a:1") ? a:1 : 5
    let S = exists("a:2") ? a:2 : 6
    let V = exists("a:3") ? a:3 : 6
    
    " more darker/lighter than background color bgdclr0
    let [bmdy, bmdi , bmdq] = colorv#hex2yiq(bgd)
    if bmdy < 50
        let bmdy=bmdy/2.5
        let y_sign = 1
    else
        let bmdy=100-(100-bmdy)/2.5
        let y_sign = -1
    endif
    let bmd = colorv#yiq2hex([bmdy,bmdi,bmdq])

    " 3 colors only.
    let s:bmdclr_list=colorv#list_gen(bmd,"Value",3,y_sign*V,NOCYCLE)

    let s:bgdclr_list=colorv#list_gen(bgd,"Value",10,y_sign*V,NOCYCLE)
    let s:fgdclr_list=colorv#list_gen(fgd,"Value",10,(-y_sign*V),NOCYCLE)
    let s:synclr_list=colorv#yiq_list_gen(syn,"Hue",10,7*H)
    let s:msgclr_list=colorv#yiq_list_gen(msg,"Hue",10,7*H)
    let s:difclr_list=colorv#yiq_list_gen(dif,"Hue",10,7*H)

    for c in ["bgd","fgd","syn","msg","dif","bmd"]
        for i in range(len(s:{c}clr_list))

            let s:{c}clr{i}  = s:{c}clr_list[i]
            " let s:difclr mix with background color
            if c == "dif"
                let s:{c}clr{i} = colorv#hexadd(
                            \s:{c}clr{i}."AF", s:bgdclr0."FF")[0:-3]
            endif
            " convert to term code
            if !has("gui_running")
                let s:{c}clr{i}  = colorv#hex2term(s:{c}clr{i},"CHECK")
            endif
        endfor
    endfor


endfunction "}}}
function! s:hi_t_list(list,...) "{{{
    let list=a:list
    for item in list
        if len(item) == 4
            let [hl_grp,hl_fg,hl_bg,hl_fm]=item

            if empty(hl_fm)
                let fm_txt = ""
            else
                let fm_txt = "NONE"
            endif

            let fm_txt .= hl_fm=~'r' ? ",reverse"     : ""

            let fg_txt = empty(hl_fg) ? hl_fg :
                        \ exists("s:".hl_fg) ? s:{hl_fg} : s:fg_t
            let bg_txt = empty(hl_bg) ? hl_bg :
                        \ exists("s:".hl_bg) ? s:{hl_bg} : s:bg_t

            " term 8 need set cterm to bold.
            if exists("s:t_Co") && s:t_Co==8 "{{{
                for i in range(8)
                    if fg_txt =~? '\<'.s:b8_name[i].'\>'
                        let fg_txt=s:n8_num[i]
                        let fm_txt.=",bold"
                    endif
                    if bg_txt =~? '\<'.s:b8_name[i].'\>'
                        let bg_txt=s:n8_num[i]
                    endif
                endfor
            endif "}}}

            let bg_txt = empty(bg_txt) ? "" : s:mode."bg=".bg_txt." "
            let fg_txt = empty(fg_txt) ? "" : s:mode."fg=".fg_txt." "
            let fm_txt = empty(fm_txt) ? "" : s:mode."=".fm_txt
            if !empty(fg_txt) || !empty(bg_txt) || !empty(fm_txt)
                        \|| !empty(sp_txt)
                exec "hi! ".hl_grp." ".fg_txt.bg_txt.fm_txt
            endif

        elseif len(item) == 2
            let [hl_from,hl_to]=item
            exec "hi! link ".hl_from." ".hl_to
        endif
    endfor
endfunction "}}}
function! s:hi_list(list,...) "{{{
    for item in a:list
        if len(item) == 4
            let [hl_grp,hl_fg,hl_bg,hl_fm] = item

            if empty(hl_fm) 
                let fm_txt = ""
            else
                let fm_txt = "NONE"
            endif

            let fm_txt .= hl_fm=~'u' ? ",underline"   : ""
            let fm_txt .= hl_fm=~'r' ? ",reverse"     : ""
            let fm_txt .= hl_fm=~'b' ? ",bold"        : ""

            " set undercurl color in gui (guisp)
            let sp_txt = ""
            if hl_fm=~'c' && s:mode=="gui"
                let fm_txt .= ",undercurl"
                let sp_txt = '#'.s:msgclr4
            elseif hl_fm=~'c' && s:mode=="cterm"
                let fm_txt .= ",underline"
            endif

            " italic not work in term
            if hl_fm=~'i' && s:mode=="gui"
                let fm_txt .= ",italic"
            endif

            " standout not work in term
            if hl_fm=~'s' && s:mode=="gui"
                let fm_txt .= ",standout"
            endif

            " "" "msgclr0" "5A3F00"
            let fg_txt = hl_fg =~ '\x\{6}' || empty(hl_fg) ? hl_fg :
                        \ exists("s:".hl_fg) ? s:{hl_fg} : s:fgdclr0
            let bg_txt = hl_bg =~ '\x\{6}' || empty(hl_bg) ? hl_bg :
                        \ exists("s:".hl_bg) ? s:{hl_bg} : s:bgdclr0


            if s:mode=="gui"
                let fg_txt = fg_txt =~ '^\x\{6}$' ? "#".fg_txt : fg_txt
                let bg_txt = bg_txt =~ '^\x\{6}$' ? "#".bg_txt : bg_txt
            else
                let fg_txt= fg_txt =~ '\x\{6}$' ? colorv#hex2term(fg_txt,"CHECK") : fg_txt
                let bg_txt= bg_txt =~ '\x\{6}$' ? colorv#hex2term(bg_txt,"CHECK") : bg_txt
            endif



            let bg_txt = empty(bg_txt) ? "" : s:mode."bg=".bg_txt." "
            let fg_txt = empty(fg_txt) ? "" : s:mode."fg=".fg_txt." "
            let sp_txt = empty(sp_txt) ? "" : s:mode."sp=".sp_txt." "
            let fm_txt = empty(fm_txt) ? "" : s:mode."=".fm_txt

            if !empty(fg_txt) || !empty(bg_txt) || !empty(fm_txt) || !empty(sp_txt)
                exec "hi! ".hl_grp." ".fg_txt.bg_txt.sp_txt.fm_txt
            endif

        elseif len(item) == 2
            let [hl_from,hl_to]=item
            exec "hi! link ".hl_from." ".hl_to
        endif
    endfor
endfunction "}}}
function! s:set_bg(L) "{{{
    " XXX: there maybe errors of &background in terminal
    if a:L<=50
        if exists("g:colors_name")
            unlet g:colors_name
        endif
        set background=dark
    else
        if exists("g:colors_name")
            unlet g:colors_name
        endif
        set background=light
    endif
endfunction "}}}
function! s:get_style_list(style) "{{{
    let hl_scheme = []
    for [name,hl_list] in items(s:hl_styles)
        if a:style == name
            let hl_scheme += hl_list
        endif
    endfor
    return hl_scheme
endfunction "}}}
function! s:get_scheme_list() "{{{
    let scheme_list=deepcopy(s:default_schemes)

    " get stored scheme
    let stored_theme_list = s:load_store()
    if !empty(stored_theme_list)
        let scheme_list=deepcopy(s:default_schemes)

        for i in range(len(stored_theme_list))
            if exists("stored_theme_list[".i."].name")
                        \ && exists("stored_theme_list[".i."].colors")
                        \ && len(stored_theme_list[i].colors)==5
                call add(scheme_list, stored_theme_list[i])
            else
                continue
            endif
        endfor
    endif
    return scheme_list
endfunction "}}}
" INHL{{{1
"======================================================================
function! s:load_indent_hl_syn() "{{{
    " clear indent syntax match  or it will be multi loaded
    silent! call s:clear_indent_syn()

    if  g:galaxy_indent_hl_pos=="end" | let p_txt = "#ms=e"
    else                              | let p_txt = "#me=s+1"
    endif

    " indent Highlight with style
    " WorkRound: without contains
    "            the vimLineComment will display as vimString
    "            if there are '"' in line .
    "            But with contains, Indent0 did not shown.
    for in_str in [repeat(' ', &sw), '\t']
        exe 'syn match galaxyIndent0'.' #^'.in_str.p_txt
                    \.' contains=vimLineComment containedin=ALL'

        for i in range(1,7)
            exe 'syn match galaxyIndent'.i.' #\%(^\1\{'.i.'}\)\@<=\('.in_str.'\)'.p_txt
                    \.' contains=vimLineComment containedin=ALL'
        endfor
    endfor

    syn match galaxyIndentErr #^ \+\t#  containedin=ALL
    syn match galaxyIndentErr #^\t\+ #  containedin=ALL

    if g:galaxy_show_trailing_ws == 1
        syn match galaxyIndentErr #\t\+$# containedin=ALL
        syn match galaxyIndentErr # \+$#  containedin=ALL
    endif

endfunction "}}}
function! s:indent_hl() "{{{
" this function should be called everytime when toggle indent hl
    if exists("s:scheme.style") && s:scheme.style =~? 'COLOUR\|ABOUND'
        let s:indent_hl_list=[
                    \["galaxyIndent0", "nocolor",  "difclr2",  "n"     ],
                    \["galaxyIndent1", "nocolor",  "difclr3",  "n"     ],
                    \["galaxyIndent2", "nocolor",  "difclr4",  "n"     ],
                    \["galaxyIndent3", "nocolor",  "difclr5",  "n"     ],
                    \["galaxyIndent4", "nocolor",  "difclr6",  "n"     ],
                    \["galaxyIndent5", "nocolor",  "difclr7",  "n"     ],
                    \["galaxyIndent6", "nocolor",  "difclr8",  "n"     ],
                    \["galaxyIndent7", "nocolor",  "difclr9",  "n"     ],
                    \]
    else
        let s:indent_hl_list=[
                    \["galaxyIndent0", "nocolor",  "bgdclr1",  "n"     ],
                    \["galaxyIndent1", "nocolor",  "bgdclr2",  "n"     ],
                    \["galaxyIndent2", "nocolor",  "bgdclr3",  "n"     ],
                    \["galaxyIndent3", "nocolor",  "bgdclr4",  "n"     ],
                    \["galaxyIndent4", "nocolor",  "bgdclr5",  "n"     ],
                    \["galaxyIndent5", "nocolor",  "bgdclr6",  "n"     ],
                    \["galaxyIndent6", "nocolor",  "bgdclr7",  "n"     ],
                    \["galaxyIndent7", "nocolor",  "bgdclr8",  "n"     ],
                    \]
    endif
    call s:hi_list(s:indent_hl_list)
    hi link galaxyIndentErr ErrorMsg
endfunction "}}}
function! s:indent_hl_aug() "{{{
    aug galaxy#indent_hl
        for file in split(g:galaxy_indent_hl_ftype,",")
            exe "au! FileType" file "call galaxy#toggle_indent_hl('ON')"
        endfor
    aug END
endfunction "}}}
function! galaxy#toggle_indent_hl(...) "{{{
    if !exists("b:galaxy_indent_hl")
                \ || b:galaxy_indent_hl == 0
                \ || (exists("a:1") && a:1 == "ON")
        call s:load_indent_hl_syn()
        call s:indent_hl()
        let b:galaxy_indent_hl = 1
    elseif b:galaxy_indent_hl == 1 || (exists("a:1") && a:1 == "OFF")
        silent! call s:clear_indent_syn()
        silent! call s:clear_indent_hl()
        let b:galaxy_indent_hl = 0
    endif
endfunction "}}}
function! s:clear_indent_syn() "{{{
    " use silent! to call it
    for i in range(8)
        exe "syn clear galaxyIndent".i
    endfor
    syn clear galaxyIndentErr
endfunction "}}}
function! s:clear_indent_hl() "{{{
    " use silent! to call it
    for i in range(8)
        exe "hi galaxyIndent".i "NONE"
    endfor
    hi galaxyIndentErr NONE
endfunction "}}}
" STAT"{{{1
"======================================================================
function! s:statusline_aug() "{{{
    if version >= 700 "{{{
        let s:list_insert_enter = []
        let s:list_insert_leave = []
        let hl_grp = ["StatusLine","User1","User2","User3",
                    \"User4","User5","User6","User7","User8","User9",]
        let hl_list = (s:scheme_style_list + s:default_hl)
        for grp in hl_grp
            for item in hl_list
                if item[0] == grp
                    call add(s:list_insert_leave,item)

                    let _item = copy(item)
                    if grp =~? '^StatusLine$'
                        let statline_fg = item[1]
                        let [_item[2],_item[1]] = _item[1:2]
                    elseif grp =~? '^User\d$'
                        if exists("s:scheme.style")
                            \&& s:scheme.style =~? 'COLOUR\|ABOUND'
                            if grp =~ '[1234]'
                                " fgd = bgd
                                " let _item[1] = item[2]
                                " bgd = statusline bgd
                                " let _item[2] = statline_fg
                            endif
                            " else
                            " if grp =~ '[1234]'
                                " let _item[1] = item[2]
                                " let _item[2] = statline_fg
                            " endif
                        endif
                    endif
                    call add(s:list_insert_enter,_item)

                    break
                endif
            endfor
        endfor

        aug galaxy#insertenter
            au!
            au InsertEnter * call s:hi_list(s:list_insert_enter)
            au InsertLeave * call s:hi_list(s:list_insert_leave)
        aug END
    endif "}}}
endfunction "}}}
function! s:statusline_term16_aug() "{{{
if version >= 700 "{{{
    if s:y <=50
        let s:list_insert_enter=[
            \["StatusLine",     "Gray",  "Blue",  "n"     ],
            \["User1",          "Red",  "Blue",  "n"     ],
            \["User2",          "Magenta",  "Blue",  "n"     ],
            \["User3",          "Cyan",  "Blue",  "n"     ],
            \["User4",          "Green",  "Blue",  "n"     ],
            \["User5",          "Blue",  "Blue",  "n"     ],
            \["User6",          "Yellow",  "Blue",  "n"     ],
            \]
    else
        let s:list_insert_enter=[
            \["StatusLine",     "Black",  "Yellow",  "n"     ],
            \["User1",          "Red",  "Yellow",  "n"     ],
            \["User2",          "Magenta",  "Yellow",  "n"     ],
            \["User3",          "Cyan",  "Yellow",  "n"     ],
            \["User4",          "Green",  "Yellow",  "n"     ],
            \["User5",          "Blue",  "Yellow",  "n"     ],
            \["User6",          "Yellow",  "Yellow",  "n"     ],
            \]
    endif
        let s:list_insert_leave =[]
        let hl_grp = ["StatusLine","User1","User2","User3",
                    \"User4","User5","User6"]
        for item in s:term_hl_list
            for grp in hl_grp
                if item[0] == grp
                    call add(s:list_insert_leave,item)
                endif
            endfor
        endfor

    aug galaxy#insertenter
        au!
        au InsertEnter * call s:hi_list(s:list_insert_enter)
        au InsertLeave * call s:hi_list(s:list_insert_leave)
    aug END
endif "}}}
endfunction "}}}
function! s:term_cursor() "{{{
    if &t_Co <=16
        if s:y < 50
            let color_normal="Cyan"
            let color_insert="Red"
        else
            let color_normal="Darkblue"
            let color_insert="Darkred"
        endif
    else
        let color_normal="#".s:synclr_list[3]
        let color_insert="#".s:msgclr_list[0]
    endif
    let color_exit=g:galaxy_tcursor_color
    "by lilydjwg
    let au_cmd=""
    if &term =~ 'xterm\|rxvt'
        exe 'silent !echo -ne "\e]12;' . escape(color_normal, '#'). '\007"'
        let &t_SI="\e]12;" . color_insert . "\007"
        let &t_EI="\e]12;" . color_normal . "\007"

        let au_cmd='autocmd VimLeave * :silent !echo -ne "\e]12;"' . escape(color_exit, '#') . '"\007"'
    elseif &term =~ "screen"
        if !exists('$SUDO_UID')
            if exists('$TMUX')
                exe 'silent !echo -ne "\033Ptmux;\033\e]12;"' . escape(color_normal, '#') . '"\007\033\\"'
                let &t_SI="\033Ptmux;\033\e]12;" . color_insert . "\007\033\\"
                let &t_EI="\033Ptmux;\033\e]12;" . color_normal . "\007\033\\"
                let au_cmd='autocmd VimLeave * :silent !echo -ne "\033Ptmux;\033\e]12;"' . shellescape(color_exit, 1) . '"\007\033\\"'
            else
                exe 'silent !echo -ne "\033P\e]12;"' . escape(color_normal, '#') . '"\007\033\\"'
                let &t_SI="\033P\e]12;" . color_insert . "\007\033\\"
                let &t_EI="\033P\e]12;" . color_normal . "\007\033\\"
                let au_cmd='autocmd VimLeave * :silent !echo -ne "\033P\e]12;"' . escape(color_exit, '#')  . '"\007\033\\"'
            endif
        endif
    endif
    aug galaxy#term_cursor
        au!
        exec au_cmd
    aug END
endfunction "}}}
function! galaxy#show_mode() "{{{
    let val= mode()
    if &paste | let val .=' P' | endif
    if &diff  | let val .=' D' | endif
    if &list  | let val .=' L' | endif
    return val
endfunction "}}}

" WINS "{{{1
"======================================================================
function! galaxy#win() "{{{
    call s:getwin()
    "{{{local setting
    setlocal winfixwidth
    setlocal nospell
    setl nocursorline nocursorcolumn
    setl tw=0
    setl buftype=nofile
    setl bufhidden=delete
    setl nolist
    setl noswapfile
    setl nobuflisted
    setl nowrap
    setl nofoldenable
    setl nomodeline
    setl nonumber
    setl noea
    setl foldcolumn=0
    setl sidescrolloff=0
    setl ft=galaxy_
    if v:version >= 703
        setl cc=
    endif
    iabc <buffer>

    aug galaxy#cursor_move
        au! CursorMoved,CursorMovedI <buffer>  call s:on_cursor_moved()
    aug END
    "}}}
    "{{{ maps
    nmap <silent><buffer> q :call galaxy#exit_win()<cr>
    nmap <silent><buffer> Q :call galaxy#exit_win()<cr>
    nmap <silent><buffer> gn :call galaxy#win_scheme_gen_colorv()<cr>
    nmap <silent><buffer> e :call <SID>win_scheme_edit_colorv()<cr>
    nmap <silent><buffer> dd :call <SID>win_scheme_del()<cr>
    nmap <silent><buffer> D :call <SID>win_scheme_del()<cr>
    nnoremap <silent><buffer> <Tab> W
    nnoremap <silent><buffer> <s-Tab> B
    map <silent><buffer> <cr> :call <SID>win_load_scheme()<cr>
    map <silent><buffer> <space> :call <SID>win_load_scheme()<cr>
    map <silent><buffer> <Kenter> :call <SID>win_load_scheme()<cr>
    map <silent><buffer> <2-leftmouse> :call <SID>win_load_scheme()<cr>
    map <silent><buffer>  ? :call <SID>seq_echo()<cr>
    map <silent><buffer>  <F1> :h galaxy<cr>
    map <silent><buffer> H :h galaxy<cr>
    "}}}
    "hi "{{{
    let Title_ptn='\%1l\%<20c'
    let Title_ptn2='\%1l\%>19c'
    let Title_ptnq='\%1l\%60c?'
    call matchadd("SpecialComment",Title_ptn)
    call matchadd("Comment",Title_ptn2)
    call matchadd("TODO",Title_ptnq,25)
    let Type_ptn='\%2l'
    call matchadd("Question",Type_ptn,4) "}}}
    "Text "{{{
    let StringList = []
    let m = "Galaxy v".g:galaxy.version."
                \    H:help  gn:new e:edit dd:delete q:quit  ?"
    call add(StringList,m)
    let m = "SCHEME"
    let m = s:line_sub(m,"BGD",20)
    let m = s:line_sub(m,"FGD",27)
    let m = s:line_sub(m,"SYN",34)
    let m = s:line_sub(m,"MSG",41)
    let m = s:line_sub(m,"DIF",48)
    let m = s:line_sub(m,"STYLE",56)
    call add(StringList,m)
    let s:scheme_list = s:get_scheme_list()
    for scheme in s:scheme_list
        let colors=""
        for color in scheme.colors
            " hi color when create txt .it's faster.
            " but no 256 support.
            " exec "hi ".grp." guifg=#".color." guibg=#".color
            let colors .= color." "
            " if has("gui_running") || &t_Co==256
            "     let grp="glx".color
            "     call s:hi_list([[grp,color,color,"n"]])
            "     let ptn=color
            "     let s:prev_dict[grp]= matchadd(grp,ptn)
            " endif
        endfor
        let name = scheme.name
        let style = exists("scheme.style") ? scheme.style : ""
        let m = strpart(name,0,16)
        let m = s:line_sub(m,colors,20)
        let m = s:line_sub(m,style,56)
        call add(StringList,m)
    endfor
    let l:win_h = len(StringList)
    let l:win_h = l:win_h > 20 ? 20 : l:win_h
    setl ma
    if !empty(StringList)
        for i in range(len(StringList))
            call setline(i+1,StringList[i])
        endfor
    endif
    setl noma "}}}
    if winnr('$') != 1
        execute 'resize' l:win_h
        redraw
    endif
    call galaxy#load_scheme("","START")
    call colorv#preview("sbNc")
    redraw
    call s:echo(len(s:scheme_list)." schemes loaded. Now is ["
                \.s:scheme.name."].")
    call search('\<'.s:scheme.name.'\>')
endfunction "}}}
function! s:getwin() "{{{
    let spLoc= g:galaxy.winpos == "top" ? "topleft " : "botright "
    let spSize= 20
    let spDirc= ""
    let exists_buffer= bufnr(g:galaxy.name)
    if exists_buffer== -1
        silent! exec spLoc .' '.spSize.spDirc.'new '.  g:galaxy.name
    else
        if !s:go_buffer_win(g:galaxy.name)
            silent! exe spLoc ." ".spSize.spDirc."split +buffer" . exists_buffer
        endif
    endif
endfunction "}}}
function! s:go_buffer_win(name) "{{{
    """ if buffer exists , go to buffer and return 1
    """ else return 0
    if bufwinnr(bufnr(a:name)) != -1
        exe bufwinnr(bufnr(a:name)) . "wincmd w"
        return 1
    else
        return 0
    endif
endfunction "}}}
function! s:win_load_scheme() "{{{
    let linenum=line('.')
    if linenum<=2
    if linenum==1 && col('.')==60 && matchstr(getline(1),"?",59,1) == "?"
            call s:seq_echo()
        else
    call s:echo("Please move down to choose a scheme.")
        endif
    return
    else
        let line = getline(linenum)
        let line_lst=split(line,'\s\+')
        let name=line_lst[0]
        if !has("gui_running") && (&t_Co==8 || &t_Co==16)
            " echoe "win load" name
            call galaxy#load_scheme16(name)
        else
            call galaxy#load_scheme(name)
        endif
    endif

endfunction "}}}
function! s:win_scheme_edit_colorv() "{{{
    let [line, col] = getpos('.')[1:2]
    if line <= s:win_txtline
        call s:echo("Please move down to choose a scheme.")
        return
    elseif line <= s:win_txtline + s:win_builtin_line
        call s:echo("You could not modify built-in schemes.")
        return
    endif

    " get scheme color and style from line.
    let line_lst = split(getline(line),'\s\+')
    let scheme = {}
    let scheme.name = line_lst[0]
    let scheme.colors = line_lst[1:5]
    let scheme.style= exists("line_lst[6]") ? line_lst[6] : ""
    let clr_helptxt = s:clr_helptxt
    let s:edit_scheme = deepcopy(scheme)
    let s:edit_linenum = line

    for i in range(6)
        if col >= 20+i*7 && col <= 25+i*7 && i <= 4
            call s:input_cv_call(scheme.colors[i],clr_helptxt[i],"galaxy#e_call",['g:ColorV.HEX'])
            let s:edit_clr = i
            return
        elseif col >=56 && col <= 62
            let style = input("Input scheme's style"
                        \."('G[alaxy](default)|A[bound]|C[olour]|S[hadow]'):\n")
            if style =~? 'c\%[olour]'
                let scheme.style="COLOUR"
            elseif style =~? 's\%[hadow]'
                let scheme.style="SHADOW"
            elseif style =~? 'a\%[bound]'
                let scheme.style="ABOUND"
            else
                let scheme.style=""
            endif

            call s:write_store(scheme)

            " if exists galaxy buffer. go and change the scheme style name.
            if s:go_buffer_win(g:galaxy.name)
                let m = strpart(scheme.name, 0, 16)
                let colors=""
                for color in scheme.colors
                    let colors .= color." "
                endfor
                let m = s:line_sub(m,colors,20)
                let m = s:line_sub(m,scheme.style,56)
                setl ma
                call setline(line,m)
                setl noma
                call colorv#preview_line("Nb",line)
            endif

            let s:edit_clr=-1
            call galaxy#load_scheme(scheme.name)
            return
        endif
    endfor

    call s:echo("Please put cursor on the colors or styles.")
    let s:edit_clr=-1

endfunction "}}}
function! galaxy#e_call(color) "{{{
    let color=a:color
    let scheme=s:edit_scheme
    let line=s:edit_linenum
    if !exists("s:edit_clr") || s:edit_clr == -1
    return
    endif
    if color=~'\x\{6}'
        let scheme.colors[s:edit_clr]=color
    else
        let scheme.colors[s:edit_clr]=eval(color)
    endif
    call s:write_store(scheme)
    if !s:go_buffer_win(g:galaxy.name)
        return -1
    endif
    let colors=""
    for color in scheme.colors
        let colors .= color." "
    endfor
    let m = strpart(scheme.name,0,16)
    let m = s:line_sub(m,colors,20)
    let m = s:line_sub(m,scheme.style,56)
    setl ma
        call setline(line,m)
    setl noma
    call colorv#preview_line("Nb",line)
    call galaxy#load_scheme(scheme.name)
endfunction "}}}
function! s:input_cv_call(color,txt,callfunc,callarg) "{{{
    "1:exit call   | 2: update call
    call colorv#win("",a:color,1,a:callfunc,a:callarg)
    call s:echo("Choose your color for ".a:txt)
endfunction "}}}

function! s:win_scheme_del() "{{{
    " get the name
    let linenum=line('.')
    let col = col('.')
    let s:win_txtline=2
    let s:win_builtin_line=len(s:default_schemes)
    if linenum<=s:win_txtline
        call s:echo("Please move down to choose a scheme.")
        return
    endif
    if linenum <= s:win_txtline + s:win_builtin_line
        call s:echo("You could NOT delete built-in Schemes.")
        return
    endif
    let line = getline(linenum)
    let line_lst=split(line,'\s\+')
    let scheme={}
    let scheme.name=line_lst[0]

    " delete the .galaxy file
    let folder =  expand(g:galaxy_store_Folder)
    let file = folder.scheme.name.".galaxy"
    let input=input("Are you sure to delete the file ".file."?\n(y[es]/no):")
    if filewritable(file) && input=~? 'y\%[es]'
        call delete(file)
        call s:echo("File deleted.")
        if s:go_buffer_win(g:galaxy.name)
            setl ma
            exec linenum."delete"
            setl noma
        endif
    elseif !filewritable(file)
    call s:echo("Error:file not writeable.")
    return
    else
    call s:echo("File deleting quited.")
    return
    endif
    " redraw window
endfunction "}}}
function! s:on_cursor_moved()  "{{{
    if line('.') > 2
        execute 'match' "ErrorMsg".' /\%'.line('.').'l\%<17c/'
        let c=col('.')
        if c >19 && c<26
            execute '2match' "ErrorMsg".' /\%2l\%>19c\%<26c/'
        elseif c >26 && c<33
            execute '2match' "ErrorMsg".' /\%2l\%>26c\%<33c/'
        elseif c >33 && c<40
            execute '2match' "ErrorMsg".' /\%2l\%>33c\%<40c/'
        elseif c >40 && c<47
            execute '2match' "ErrorMsg".' /\%2l\%>40c\%<47c/'
        elseif c >47 && c<54
            execute '2match' "ErrorMsg".' /\%2l\%>47c\%<54c/'
        elseif c >55 && c<62
            execute '2match' "ErrorMsg".' /\%2l\%>55c\%<62c/'
        else
            execute '2match ' "none"
        endif
        " echoe c
    else
        execute 'match' "none"
        execute '2match ' "none"
    endif
endfunction "}}}
function! galaxy#exit_win() "{{{
    if s:go_buffer_win(g:galaxy.name)
    close
    endif
endfunction "}}}
" GENS {{{1
"============================================================================
function! galaxy#win_scheme_gen_colorv() "{{{
    let scheme={}
    let name=input("Please Input your Scheme name ([a-zA-Z0-9_]):\n")
    if !empty(name) && name =~ '^[a-zA-Z0-9_]*$'
        let scheme.name= substitute(name,'\s',"_","g")
    else
        call s:echo("Not a Valid Name. Stopped.")
        return
    endif
    let s:edit_scheme =deepcopy(scheme)
    call s:input_cv_call("111315","Background","galaxy#gen_call",['g:ColorV.HEX','s:edit_scheme.name'])
endfunction "}}}
function! galaxy#gen_call(color,name,...) "{{{
    let scheme={}
    let name=a:name
    if name =~ '[glstvw]:\w*'
        let scheme.name=eval(name)
    else
        let scheme.name=name
    endif
    let colors=[]
    let color=a:color
    if color =~'\x\{6}'
        let bgr=color
    else
        let bgr=eval(color)
    endif

    let [bgry,bgri,bgrq]=colorv#hex2yiq(bgr)
    let [bgrh,bgrs,bgrv]=colorv#hex2hsv(bgr)

    " LUMINATIONS:
    " bgry 0 ~10  10~20  20~40  40~50  50~60  60~80  80~100
    " fgry 65~75  65~75  60~80  83~93  15~25  15~35  15~35
    " syny 65~75  65~75  60~80  78~88  25~35  30~45  30~45
    " msgy 75~80  75~80  75~95  88~93  35~45  40~55  40~50
    " dify 20~30  30~40  30~50  45~55  50~60  55~75  75~90

    " SATURATIONS:
    " bgrs 0~100
    " fgrs 0~25
    " syns 40~65
    " msgs 70~95
    " difs 35~70

    " HUE:
    " bgrh 0~360
    " fgrh +180
    " synh +60
    " msgh +180
    " difh +85

    "Foreground color
    "set fgr y  !bgry
    if bgry>=80
        let fgry=bgry-65
    elseif bgry>=60
        let fgry=bgry-45
    elseif bgry>=50
        let fgry=bgry-35
    elseif bgry>=40
        let fgry=bgry+47
    elseif bgry>=20
        let fgry=bgry+51
    elseif bgry>=10
        let fgry=bgry+55
    else
        let fgry=bgry+65
    endif

    let [fgry,fgri,fgrq]=[fgry,-bgri,-bgrq]
    let fgr1=colorv#yiq2hex([fgry,fgri,fgrq])
    let [fgrh,fgrs,fgrv]=colorv#hex2hsv(fgr1)
    "set fgrs 0~25
    if  fgrs <= 10
        let fgrs = 3
    else
        "2~25
        let fgrs = fgrs/4
    endif
    "set fgrv 0~85
    if fgrv >=70
        let fgrv = fgrv-15
    elseif fgrv >=60
        let fgrv = fgrv-10
    elseif fgrv >=50
        let fgrv = fgrv-5
    endif
    let fgr2=colorv#hsv2hex([fgrh,fgrs,fgrv])
    let [fgry2,fgri2,fgrq2]=colorv#hex2yiq(fgr2)
    "use fgry as the static lumination
    let fgr=colorv#yiq2hex([fgry,fgri2,fgrq2])

    "Syntax color
    "syn h:b+180+30 s:45~70 v:5~90
    if fgrv >=80
        let synv = fgrv-5
    elseif fgrv >=60
        let synv = fgrv+5
    elseif fgrv >=40
        let synv = fgrv+10
    elseif fgrv >=20
        let synv = fgrv+15
    else
        let synv = fgrv+20
    endif

    let [synh,syns,synv]=[bgrh+60,fgrs+40,synv]
    let syn0=colorv#hsv2hex([synh,syns,synv])

    if fgry>=90
        let syny=fgry-19
    elseif fgry>=80
        let syny=fgry-9
    elseif fgry>=60
        let syny=fgry-3
    elseif fgry>=40
        let syny=fgry+3
    elseif fgry>=20
        let syny=fgry+12
    else
        let syny=fgry+18
    endif
    let [syny0,syni0,synq0]=colorv#hex2yiq(syn0)
    let syn=colorv#yiq2hex([syny,syni0,synq0])


    "Msg color
    "msg h:b+180+210 s:75~90 v:15~100
    let msgv=synv+5
    let [msgh,msgs,msgv]=[bgrh+180,fgrs+70,msgv]
    let msg0=colorv#hsv2hex([msgh,msgs,msgv])

    if syny>=80
        let msgy=syny-5
    elseif syny>=60
        let msgy=syny+3
    elseif syny>=50
        let msgy=syny+5
    elseif syny>=40
        let msgy=syny+7
    elseif syny>=20
        let msgy=syny+9
    else
        let msgy=syny+11
    endif

    let [msgy0,msgi0,msgq0]=colorv#hex2yiq(msg0)
    let msg=colorv#yiq2hex([msgy,msgi0,msgq0])

    "Diff color
    "dif h:b+30 s:
    if  bgrs <=10
        let difs=bgrs+35
    elseif bgrs <=30
        let difs=bgrs+30
    elseif bgrs <=50
        let difs=bgrs+25
    elseif bgrs <=70
        let difs=bgrs-20
    else
        let difs=bgrs-30
    endif
    if  bgrv <=10
        let difv=bgrv+25
    elseif bgrv <=30
        let difv=bgrv+20
    elseif bgrv <=50
        let difv=bgrv+15
    elseif bgrv <=70
        let difv=bgrv-10
    elseif bgrv <=90
        let difv=bgrv-15
    else
        let difv=bgrv-20
    endif
    let [difh,difs,difv]=[bgrh+85,difs,difv]
    let dif0=colorv#hsv2hex([difh,difs,difv])

    if bgry>=80
        let dify=bgry-10
    elseif bgry>=60
        let dify=bgry-5
    elseif bgry>=50
        let dify=bgry
    elseif bgry>=40
        let dify=bgry+5
    elseif bgry>=20
        let dify=bgry+10
    else
        let dify=bgry+20
    endif
    let [dify0,difi0,difq0]=colorv#hex2yiq(dif0)
    let dif=colorv#yiq2hex([dify,difi0,difq0])

    for i in [bgr,fgr,syn,msg,dif]
        call add(colors,i)
    endfor
    let scheme.colors=colors
    call s:write_store(scheme)

    if exists("a:1") && a:1 =="SILENT"
        return
    else
        call galaxy#load_scheme(scheme.name)
        call galaxy#win()
    endif

endfunction "}}}
function! galaxy#auto_gen() "{{{
"auto gen with colorv list
    let CacheStringList = getline(0,'$')
    let namelist=[]
    for i in CacheStringList
        if i =~ '\(\S*\)\s*\(#\x\{6}\)'
            let name=substitute(i,'\(^.*\)\s*\(#\x\{6}\)','\1','')
            let name=substitute(name,'\s*',"",'g')
            let name=substitute(name,'\W','_','')
            let name =strpart(name,0,17)
            let color=matchstr(i,'#\x\{6}')
            let color=substitute(color,'#','','')
            call add(namelist,[name,color])
        endif
    endfor
    if !empty(namelist)
        call s:caution("Generating ColorSchemes, Please Wait...")
        let n=0
        for [name,color] in namelist
            call galaxy#gen_call(color,name,"SILENT")
            let n+=1
        endfor
        call s:caution("Generating Complete! ".n." Schemes was generated.")
    endif
    " echo string(namelist)
    call galaxy#load_scheme()
endfunction "}}}
" HELP "{{{1
"======================================================================
function! s:exec(cmd) "{{{
    let old_ei = &ei
    set ei=all
    exec a:cmd
    let &ei = old_ei
endfunction "}}}
function! s:echo(msg) "{{{
    exe "echom \"[Galaxy Note] ".escape(a:msg,'"')."\""
endfunction "}}}
function! s:caution(msg) "{{{
    echohl Modemsg
    exe "echom \"[Galaxy Caution] ".escape(a:msg,'"')."\""
    echohl Normal
endfunction "}}}
function! s:warning(msg) "{{{
    echohl Warningmsg
    exe "echo \"[Galaxy Warning] ".escape(a:msg,'"')."\""
    echohl Normal
endfunction "}}}
function! s:error(msg) "{{{
    echohl Errormsg
    redraw
    echom "[Galaxy Error] ".escape(a:msg,'"')." "
    echohl Normal
endfunction "}}}
function! s:debug(msg) "{{{
    if g:galaxy_debug!=1
        return
    endif
    echohl Errormsg
    echom "[Galaxy Debug] ".escape(a:msg,'"')
    echohl Normal
endfunction "}}}

function! s:line(text,pos) "{{{
    let suf_len= s:line_width-a:pos-len(a:text)+1
    let suf_len= suf_len <= 0 ? 1 : suf_len
    return repeat(' ',a:pos-1).a:text.repeat(' ',suf_len)
endfunction "}}}
function! s:line_sub(line,text,pos) "{{{
    let [line,text,pos]=[a:line,a:text,a:pos]
    if len(line) < len(text)+pos
    let line = line.repeat(' ',len(text)+pos-len(line))
    endif
    if pos!=1
        let pat='^\(.\{'.(pos-1).'}\)\%(.\{'.len(text).'}\)'
        return substitute(line,pat,'\1'.text,'')
    else
    let pat='^\%(.\{'.len(text).'}\)'
        return substitute(line,pat,text,'')
    endif
endfunction "}}}
function! s:clear_text() "{{{
    if expand('%') !=g:galaxy.name
        call s:warning("Not [GALAXY] buffer")
        return
    endif
    let cur=getpos('.')
    " silent! normal! ggVG"_x
    silent %delete _
    return cur
endfunction "}}}
function! s:seq_echo() "{{{
    " let txt_list
    let txt_list=s:tips_list

    let s:seq_num= exists("s:seq_num") ? s:seq_num : 0
    let idx=0
    for txt in txt_list
        if s:fmod(s:seq_num,len(txt_list)) == idx
            call s:echo("[".idx."]".txt)
            break
        endif
        let idx+=1
    endfor
    let s:seq_num+=1
endfunction "}}}
function! s:fmod(x,y) "{{{
    "no fmod() in 702
    if v:version < 703
        if a:y == 0
            let tmp = 0
        else
            let tmp = a:x - a:y * floor(a:x/a:y)
        endif
            return tmp
    else
    return fmod(s:float(a:x),s:float(a:y))
    endif

endfunction "}}}
function! s:float(x) "{{{
    if type(a:x) == type([])
    if !empty(a:x)
        let x=[]
        for i in a:x
                let z = s:float(i)
                call add(x,z)
            endfor
            return x
        else
            throw "Empty List for s:float()"
        endif
    else
        let x= type(a:x) == type("0.5") ? str2float(a:x) : type(a:x) == type(1) ? a:x+0.0 : a:x
        return x
    endif
endfunction "}}}
" LOAD "{{{1
"======================================================================
function! s:write_store(scheme) "{{{
    " and should remove the cache

    let scheme=a:scheme
    let CacheStringList = []
    let folder=expand(g:galaxy_store_Folder)
    if !isdirectory(folder) "{{{
        if exists("*mkdir")
            try
                call mkdir(folder,"p")
            catch /^Vim\%((\a\+)\)\=:E/
                call s:error("Could not mkdir on this system. Stopped.")
                return -1
            endtry
        else
            call s:error("Could not mkdir on this system. Stopped.")
            return -1
        endif
    elseif filewritable(folder) != 2
        call s:error("The galaxy store Folder is not writeable.")
        return -1
    endif "}}}
    " XXX: let scheme_list_list became the editing variable
    if exists("scheme.colors") && len(scheme.colors)==5
        call add(CacheStringList,"GALAXY_NAME\t\t".scheme.name)
        call add(CacheStringList,
                    \"GALAXY_COLORS\t" .scheme.colors[0]." "
                    \.scheme.colors[1]." " .scheme.colors[2]." "
                    \.scheme.colors[3]." " .scheme.colors[4])

        if exists("scheme.style")
            call add(CacheStringList,"GALAXY_STYLE\t".scheme.style)
        endif

        if exists("scheme.highlights")
            for i in range(len(scheme.highlights))
                if len(scheme.highlights[i]) == 4
                    call add(CacheStringList,
                                \"GALAXY_HIGH\t\t"
                                \.scheme.highlights[i][0]." "
                                \.scheme.highlights[i][1]." "
                                \.scheme.highlights[i][2]." "
                                \.scheme.highlights[i][3])
                elseif len(scheme.highlights[i]) == 2
                    call add(CacheStringList,
                                \"GALAXY_HIGH\t\t"
                                \.scheme.highlights[i][0]." "
                                \.scheme.highlights[i][1])
                endif
            endfor
        endif

        " call add(CacheStringList,"GALAXY_END")
        call add(CacheStringList,"")

        let file = folder . scheme.name. ".galaxy"
        try
            call writefile(CacheStringList, file)
        catch /^Vim\%((\a\+)\)\=:E/
            call s:error("Could not write scheme files. ".v:exception)
            return -1
        endtry
    endif
endfunction "}}}
function! s:load_store() "{{{
    let folder =  expand(g:galaxy_store_Folder)
    let s:file_list = split(globpath(folder, '*.galaxy'), '\n')
    let l:stored_theme_list= []
    if isdirectory(folder)
        for file in s:file_list
            let l:stored_theme_list +=  galaxy#load_file(file)
        endfor
    endif
    return l:stored_theme_list
endfunction "}}}
function! galaxy#load_cache() "{{{
    let file = expand(g:galaxy_cache_File)
    let s:_gui_name = exists("s:_gui_name") ? s:_gui_name : ""
    let s:_term_name = exists("s:_term_name") ? s:_term_name : ""
    try
        let CacheStringList = readfile(file)
    catch /^Vim\%((\a\+)\)\=:E/
        call s:debug("Could not load cache. ".v:exception)
        return -1
    endtry
    for i in CacheStringList
        if i =~ '_GUI_NAME'
            let s:_gui_name = matchstr(i,'_GUI_NAME\s*\zs.*\ze\s*')
        endif
        if i =~ 'TERM_NAME'
            let s:_term_name = matchstr(i,'TERM_NAME\s*\zs.*\ze\s*')
        endif
    endfor
    if !has("gui_running")
        return s:_term_name
    else
        return s:_gui_name
    endif
endfunction "}}}
function! galaxy#load_file(file) "{{{
    let file = a:file
    if !filereadable(file)
        return 0
    endif
    let l:cached_theme_list=[]
    for i in readfile(file) + ["GALAXY_END"]
        if !exists("l:tmp_dict")
            let l:tmp_dict={}
        endif
        if i =~ 'GALAXY_NAME'
            let l:tmp_dict.name =
                        \matchstr(i,'GALAXY_NAME\s*\zs.*\ze\s*')
        endif
        if i =~ 'GALAXY_COLORS'
            let colors=matchstr(i,'GALAXY_COLORS\s*\zs.*\ze$')
            let l:tmp_dict.colors = split(colors,'\s')
            if len(l:tmp_dict.colors)==5
                let l:color_is_5=1
            else
                let l:color_is_5=0
            endif
        endif
        if i =~ 'GALAXY_STYLE'
            let l:tmp_dict.style =
                        \matchstr(i,'GALAXY_STYLE\s*\zs.*\ze\s*')
        endif
        if i =~ 'GALAXY_HIGH'
            let highlights = matchstr(i,'GALAXY_HIGH\s*\zs.*\ze$')
            let l:tmp_dict.highlights = []
            call add(l:tmp_dict.highlights,split(highlights,'\s'))
        endif
        if i =~ 'GALAXY_END'
            if exists("l:color_is_5") && l:color_is_5==1
                call add(l:cached_theme_list,deepcopy(l:tmp_dict))
            endif
            unlet l:tmp_dict
        endif
    endfor
    return l:cached_theme_list
endfunction "}}}
function! galaxy#write_cache() "{{{
    let CacheStringList = []
    let file = expand(g:galaxy_cache_File)
    if !has("gui_running")
        let term_name=s:scheme.name
        let gui_name=s:_gui_name
    else
        let gui_name=s:scheme.name
        let term_name=s:_term_name
    endif
    call add(CacheStringList,"_GUI_NAME\t".gui_name)
    call add(CacheStringList,"TERM_NAME\t".term_name)
    call add(CacheStringList,"")
    try
        call writefile(CacheStringList, file)
    catch /^Vim\%((\a\+)\)\=:E/
        call s:error("Could not caching-scheme. ".v:exception)
        return -1
    endtry
endfunction "}}}
" MAIN "{{{1
"======================================================================
function! galaxy#init() "{{{
    if !has("gui_running") && &t_Co<=16
        call galaxy#load_scheme16("","START")
    else
        call galaxy#load_scheme("","START")
    endif
    aug galaxy#cache
        au! VIMLEAVEPre * call galaxy#write_cache()
    aug END
endfunction "}}}
function! galaxy#load(name) "{{{
    if !has("gui_running") && (&t_Co==8 || &t_Co==16)
        call galaxy#load_scheme16(a:name)
    else
        call galaxy#load_scheme(a:name)
    endif
endfunction "}}}
function! galaxy#load_scheme(...) "{{{

    let cache_scheme = (exists("a:1") && a:1 !~ '^\s*$') ? a:1
                \ : galaxy#load_cache()

    let s:scheme_list = s:get_scheme_list()
    let s:scheme = s:scheme_list[0]
    let s:scheme.style = "GALAXY"
    for scheme in s:scheme_list
        if scheme.name == cache_scheme
            let s:scheme = scheme
            if !exists("s:scheme.style") || s:scheme.style =~ '^\s*$'
                let s:scheme.style = "GALAXY"
            endif
            break
        endif
    endfor

    let [s:y,s:i,s:q]=colorv#hex2yiq(s:scheme.colors[0])
    call s:set_bg(s:y)
    "generate base colors:bgd/fgd/syn/msg/dif
    call s:gen_base_colors(s:scheme.colors)

    " predefined highlights
    call s:hi_list(s:default_hl)
    if g:galaxy_colorful_syntax == 1
        call s:hi_list(s:syn_hl_1)
    else
        call s:hi_list(s:syn_hl_0)
    endif

    " predefined scheme style highlights
    let s:scheme_style_list = s:get_style_list(s:scheme.style)
    call s:hi_list(s:scheme_style_list)
    
    
    " predefined filetype syntax highlights
    if g:galaxy_load_syn_dict==1
        for list in values(s:synlink_dict)
            call s:hi_list(list)
        endfor
        for list in values(s:syn_hi_gui_dict)
            call s:hi_list(list)
        endfor
    endif

    if g:galaxy_load_syn_tuning==1
        call s:syntax_tune()
    endif

    " the scheme defined highlights
    if exists("s:scheme.highlights")
        call s:hi_list(s:scheme.highlights)
    endif

    if g:galaxy_visual_hl_fg == 1
        call s:hi_list([
                    \["Visual",         "bgdclr1",  "fgdclr1",  "n"     ],
                    \["VisualNOS",      "bgdclr1",  "fgdclr1",  "n"     ],
                    \])
    endif


    if g:galaxy_statusline_blink == 1
        call s:statusline_aug()
    endif
    if g:galaxy_auto_statusline == 1
        let &statusline = g:galaxy_statusline_default
    endif
    if g:galaxy_enable_indent_hl == 1
        call s:indent_hl_aug()
    endif
    if !has("gui_running")
        call s:term_cursor()
    endif

    if !exists("a:2") || a:2!="START"
        call galaxy#write_cache()
        redraw
        if !empty(s:scheme.style)
            echom "Galaxy Scheme:\"".s:scheme.name."\" loaded. With style:" .s:scheme.style."."
        else
            echom "Galaxy Scheme:\"".s:scheme.name."\" loaded."
        endif
    endif

    let g:colors_name = "galaxy"
    let g:galaxy_name = s:scheme.name
    let g:galaxy.scheme = s:scheme
endfunction "}}}
function! galaxy#load_scheme16(...) "{{{
    let cache_scheme = (exists("a:1") && a:1 !~ '^\s*$') ? a:1
                \ : galaxy#load_cache()
    let s:scheme_list = s:get_scheme_list()
    let s:scheme = s:scheme_list[0]
    for scheme in s:scheme_list
        if scheme.name == cache_scheme
            let s:scheme = scheme
            break
        endif
    endfor
    let [s:y,s:i,s:q]=colorv#hex2yiq(s:scheme.colors[0])

    if &t_Co==16
        if s:y <=50
            call s:set_dark16_var()
            let s:scheme.style = "dark16"
        else
            call s:set_light16_var()
            let s:scheme.style = "light16"
        endif
    else
        if s:y <=50
            call s:set_dark8_var()
            let s:scheme.style = "dark8"
        else
            call s:set_light8_var()
            let s:scheme.style = "light8"
        endif
    endif

    call s:hi_t_list(s:term_hl_list)

    if g:galaxy_statusline_blink == 1
        call s:statusline_term16_aug()
    endif
    if g:galaxy_enable_indent_hl == 1
        call s:indent_hl_aug()
    endif

    call s:term_cursor()

    " predefined syntax highlights
    if g:galaxy_load_syn_dict==1
        for list in values(s:synlink_dict)
            call s:hi_list(list)
        endfor
        for list in values(s:syn_hi_term_dict)
            call s:hi_list(list)
        endfor
    endif

    if g:galaxy_load_syn_tuning==1
        call s:syntax_tune()
    endif

    " set cursorline on 16 term
    " set cul

    if !exists("a:2") || a:2!="START"
        call galaxy#write_cache()
        redraw
        " if !empty(s:scheme.style)
        echom "Galaxy Scheme:\"".s:scheme.name."\" loaded. With style:" .s:scheme.style."."
        " else
            " echom "Galaxy Scheme:\"".s:scheme.name."\" loaded."
        " endif
    endif
    let g:colors_name = "galaxy"
    let g:galaxy_name = s:scheme.name
    let g:galaxy.scheme = s:scheme
endfunction "}}}
function! galaxy#next_scheme(...) "{{{
    if !exists("s:scheme_list")
        let s:scheme_list = s:get_scheme_list()
        let scheme_name=galaxy#load_cache()
    else
        let scheme_name=s:scheme.name
    endif
    for i in range(len(s:scheme_list))
        if s:scheme_list[i]['name']=~'\<'.scheme_name.'\>'
            let scheme_num=i
            break
        endif
    endfor

    if exists("a:1") && a:1 == "-"
        let scheme_num-=1
    else
        let scheme_num+=1
    endif
    if scheme_num >= len(s:scheme_list)
    let scheme_num=0
    elseif scheme_num < 0
    let scheme_num  = len(s:scheme_list)-1
    endif
    let name=s:scheme_list[scheme_num]['name']
    if !has("gui_running") && (&t_Co==8 || &t_Co==16)
        call galaxy#load_scheme16(name)
    else
        call galaxy#load_scheme(name)
    endif
endfunction "}}}
"}}}1
let &cpo = s:save_cpo
unlet s:save_cpo
" vim:tw=78:fdm=marker:
