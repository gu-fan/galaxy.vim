"=============================================================
"  Script: Galaxy
"    File: autoload/galaxy.vim
" Summary: A colorscheme to make colorscheming simpler 
"  Author: Rykka G.Forest <Rykka10(at)gmail.com>
" License: The MIT Licence
"          http://www.opensource.org/licenses/mit-license.php
"          Copyright (c) 2011-2012 Rykka.ForestGreen
" Last Update: 2012-05-07
"=============================================================
let s:save_cpo = &cpo
set cpo&vim
" VARS "{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:galaxy         = {}
let g:galaxy.version = "2.0.1"
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
call s:default("g:galaxy_visual_hl_fg",     1)
call s:default("g:galaxy_tcursor_color",    "DarkGray")

call s:default("g:galaxy_colorful_syntax",  1)
call s:default("g:galaxy_load_syn_dict",    1)
call s:default("g:galaxy_load_syn_tuning",  1)

call s:default("g:galaxy_enable_indent_hl", 1)
call s:default("g:galaxy_indent_hl_pos",    "start")
call s:default("g:galaxy_indent_hl_ftype",  "python")
call s:default("g:galaxy_show_trailing_ws", 1)

call s:default("g:galaxy_enable_statusline",1)
call s:default("g:galaxy_statusline_hl_insert", 1)
call s:default("g:galaxy_statusline_style", "Left")
call s:default("g:galaxy_default_ff",  "unix")
call s:default("g:galaxy_default_enc", "utf-8")

if has("win32") || has("win64")
    if exists('$HOME')
        call s:default("g:galaxy_cache_file", 
                    \expand('$HOME') . '\.vim_galaxy_cache')
        call s:default("g:galaxy_scheme_file", 
                    \expand('$HOME') . '\.vim_galaxy_schemes')
    elseif exists('$HOME')
        call s:default("g:galaxy_cache_file",  
                    \expand('$VIM') . '\.vim_galaxy_cache')
        call s:default("g:galaxy_scheme_file",  
                    \expand('$VIM') . '\.vim_galaxy_schemes')
    endif
else
    call s:default("g:galaxy_cache_file", 
                \expand('$HOME') . '/.vim_galaxy_cache')
    call s:default("g:galaxy_scheme_file",  
                \expand('$HOME') . '/.vim_galaxy_schemes')
endif

" s:vars  initial "{{{2
"
let s:galaxy  = {}
let s:galaxy.name  = "_GALAXY_".g:galaxy.version

let s:seq_num = 0
let s:scheme  = {}
let s:scheme.name = "White"
let s:scheme.style = "Shadow"
let s:scheme.colors = ["FFFFFF","000000","306399","FF0D0D","B0E1EB"]
"               ui name style syntax status indent
let s:cache_term = ["TEM_OPT","","","","",""]
let s:cache_gui  = ["GUI_OPT","","","","",""]

if has("gui_running")
    let s:mode="gui"
else
    let s:mode="cterm"
endif
let s:bgy = "dark"

" constants "{{{
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

"
let s:pre_name_list=[
\"Red"          , "LightRed"    , "DarkRed"   , "Green"       , "LightGreen" ,
\"DarkGreen"    , "SeaGreen"    , "Blue"      , "LightBlue"   , "DarkBlue"   ,
\"SlateBlue"    , "Cyan"        , "LightCyan" , "DarkCyan"    , "Magenta"    ,
\"LightMagenta" , "DarkMagenta" , "Yellow"    , "LightYellow" ,
\"Brown"        , "DarkYellow"  , "Gray"      , "LightGray"   , "DarkGray"   ,
\"Black"        , "White"       , "Orange"    , "Purple"      , "Violet"     ,
\]

for i in s:pre_name_list
    let z = tolower(i)
    let s:{z} = i
endfor
unlet z
unlet i

"}}}
" txt "{{{
let s:tips_list=[
            \'Load: 2-Click/Space/<CR>',
            \'New: gn/gr        Del: dd/D',
            \'Select:Click      Edit: e',
            \'Screen:sc         Galaxy:sv',
            \'Help: F1/H        Quit: q/Q',
            \]
let s:head_tip = [
            \"      Screen:sc   Load:<Click>  Edit:e  New:gn  Tips:?",
            \"      Galaxy:sv    Load:<Space>  Edit:e  New:gr  Tips:?",
            \"      Screen:sc   Load:<Enter>  Edit:e  New:gn  Help:H",
            \]
let s:hlp_txt=[
            \"Background(Normal Background)",
            \"Foreground Color(Normal Foreground)",
            \"Syntax Color(Vars,Functions,...)",
            \"Message Color(ErrorMsg,ModeMsg,...)",
            \"Diff(DiffAdd,DiffChange,... Background)"]
"}}}
"
" SCHM "{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" s:gui "{{{2
" default hl"{{{
let s:default_hl=[
            \["Normal",         "fgdclr0",  "bgdclr0",  "n"     ],
            \["Italic",         "nocolor",  "nocolor",  "i"     ],
            \["Bold",           "nocolor",  "nocolor",  "b"     ],
            \["BoldItalic",     "nocolor",  "nocolor",  "ib"    ],
            \["Underlined",     "nocolor",  "nocolor",  "u"     ],
            \["Undercurl",      "nocolor",  "nocolor",  "c"     ],
            \["Reverse",        "nocolor",  "nocolor",  "r"     ],
            \["ErrorMsg",       "bgdclr0",  "msgclr0",  "b"     ],
            \["WarningMsg",     "bgdclr0",  "msgclr2",  "b"     ],
            \["MoreMsg",        "bgdclr0",  "msgclr4",  "b"     ],
            \["Question",       "bgdclr0",  "msgclr6",  "b"     ],
            \["ModeMsg",        "bgdclr0",  "msgclr8",  "b"     ],
            \["MatchParen",     "bgdclr0",  "bgdclr7",  "b"     ],
            \["Error",          "nocolor",  "difclr5",  "b"     ],
            \["SpellBad",       "nocolor",  "difclr1",  "c"     ],
            \["SpellCap",       "SpellBad"      ],
            \["SpellLocal",     "nocolor",  "difclr5",  "c"     ],
            \["SpellRare",      "SpellLocal"    ],
            \["Todo",           "msgclr5",  "bgdclr3",  "b"     ],
            \["Title",          "synclr0",  "nocolor",  "b"     ],
            \["Conceal",        "bgdclr2",  "nocolor",  "n"     ],
            \["Comment",        "bgdclr6",  "nocolor",  "n"     ],
            \["NonText",        "Comment"       ],
            \["Ignore",         "Comment"       ],
            \["SpecialComment", "bgdclr7",  "nocolor",  "b"     ],
            \["DiffDelete",     "bgdclr0",  "bgdclr4",  "n"     ],
            \["DiffAdd",        "fgdclr2",  "difclr0",  "n"     ],
            \["DiffChange",     "fgdclr2",  "difclr6",  "n"     ],
            \["DiffText",       "fgdclr2",  "difclr3",  "n"     ],
            \] "}}}
" syn 0 LESS "{{{
let s:syn_hl_0=[
            \["Keyword",        "synclr0",  "nocolor",  "b"     ],
            \["Statement",      "synclr0",  "nocolor",  "n"     ],
            \["Conditional",    "synclr0",  "nocolor",  "n"     ],
            \["Repeat",         "synclr0",  "nocolor",  "n"     ],
            \["Label",          "synclr0",  "nocolor",  "b"     ],
            \["PreProc",        "synclr2",  "nocolor",  "n"     ],
            \["Include",        "synclr2",  "nocolor",  "b"     ],
            \["Define",         "synclr2",  "nocolor",  "b"     ],
            \["PreCondit",      "Define"        ],
            \["Macro",          "synclr2",  "nocolor",  "b"     ],
            \["Type",           "synclr3",  "nocolor",  "n"     ],
            \["Typedef",        "synclr3",  "nocolor",  "b"     ],
            \["StorageClass",   "synclr4",  "nocolor",  "n"     ],
            \["Structure",      "synclr4",  "nocolor",  "b"     ],
            \["Directory",      "Type"          ],
            \["Identifier",     "synclr4",  "nocolor",  "n"     ],
            \["Constant",       "synclr5",  "nocolor",  "b"     ],
            \["Number",         "synclr5",  "nocolor",  "n"     ],
            \["Boolean",        "synclr5",  "nocolor",  "n"     ],
            \["Float",          "synclr5",  "nocolor",  "n"     ],
            \["Character",      "synclr7",  "nocolor",  "b"     ],
            \["String",         "synclr7",  "nocolor",  "n"     ],
            \["Function",       "synclr9",  "nocolor",  "b"     ],
            \["Operator",       "synclr9",  "nocolor",  "n"     ],
            \["Exception",      "synclr2",  "nocolor",  "b"     ],
            \["Special",        "synclr2",  "bgdclr0",  "n"     ],
            \["Delimiter",      "synclr2",  "nocolor",  "b"     ],
            \["SpecialChar",    "synclr2",  "nocolor",  "b"     ],
            \["Debug",          "synclr2",  "nocolor",  "b"     ],
            \["SpecialKey",     "SpecialChar"   ],
            \["Tag",            "Special"       ],
            \] "}}}
" syn 1 MORE "{{{
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
            \["Type",           "synclr3",  "nocolor",  "n"     ],
            \["Typedef",        "synclr3",  "nocolor",  "b"     ],
            \["StorageClass",   "synclr4",  "nocolor",  "i"     ],
            \["Structure",      "synclr4",  "nocolor",  "ib"     ],
            \["Directory",      "Type"          ],
            \["Identifier",     "synclr4",  "nocolor",  "n"     ],
            \["Constant",       "synclr5",  "nocolor",  "b"     ],
            \["Number",         "synclr5",  "nocolor",  "n"     ],
            \["Boolean",        "synclr5",  "nocolor",  "b"     ],
            \["Float",          "synclr5",  "nocolor",  "i"     ],
            \["Character",      "synclr6",  "nocolor",  "i"     ],
            \["String",         "synclr7",  "nocolor",  "n"     ],
            \["Function",       "synclr8",  "nocolor",  "b"     ],
            \["Operator",       "synclr9",  "nocolor",  "n"     ],
            \["Exception",      "synclr2",  "nocolor",  "bi"    ],
            \["Special",        "synclr2",  "bgdclr0",  "n"     ],
            \["Delimiter",      "synclr2",  "nocolor",  "b"     ],
            \["SpecialChar",    "synclr2",  "nocolor",  "i"     ],
            \["Debug",          "synclr2",  "nocolor",  "bi"    ],
            \["SpecialKey",     "SpecialChar"   ],
            \["Tag",            "Special"       ],
            \] "}}}

" s:styles "{{{2
let s:hl_styles = {}
"{{{ Shadow
" CursorS is for Screen cursor recover.
let s:hl_styles.Shadow = [
        \["Cursor",         "bgdclr1",  "fgdclr1",  "n"     ],
        \["CursorS",        "bgdclr1",  "fgdclr1",  "n"     ],
        \["CursorIM",       "nocolor",  "msgclr4",  "n"     ],
        \["CursorLine",     "nocolor",  "difclr3",  "n"     ],
        \["CursorColumn",   "CursorLine"    ],
        \["Visual",         "nocolor",  "bgdclr6",  "n"     ],
        \["VisualNOS",      "nocolor",  "bgdclr5",  "n"     ],
        \["Search",         "fgdclr0",  "bgdclr4",  "n"     ],
        \["IncSearch",      "bgdclr1",  "msgclr6",  "b"     ],
        \["Pmenu",          "bgdclr8",  "bgdclr3",  "n"     ],
        \["PmenuSel",       "fgdclr1",  "bgdclr1",  "rb"    ],
        \["PmenuSbar",      "bgdclr6",  "bgdclr1",  "n"     ],
        \["PmenuThumb",     "bgdclr0",  "bgdclr5",  "n"     ],
        \["Wildmenu",       "bgdclr0",  "fgdclr0",  "rb"    ],
        \["Folded",         "bgdclr8",  "bgdclr1",  "n"     ],
        \["FoldColumn",     "bgdclr7",  "bgdclr3",  "n"     ],
        \["ColorColumn",    "msgclr7",  "bgdclr3",  "n"     ],
        \["LineNr",         "bgdclr8",  "bgdclr2",  "n"     ],
        \["SignColumn",     "msgclr2",  "bgdclr2",  "n"     ],
        \["TabLine",        "bgdclr9",  "bgdclr2",  "n"     ],
        \["TabLineSel",     "fgdclr1",  "bgdclr0",  "b"     ],
        \["TabLineFill",    "bgdclr0",  "bgdclr4",  "n"     ],
        \["StatusLine",     "fgdclr0",  "bgdclr5",  "b"     ],
        \["StatusLineNC",   "bgdclr0",  "bgdclr5",  "n"     ],
        \["VertSplit",      "StatusLineNC"  ],
        \["User1",          "bgdclr0",  "synclr1",  "b"     ],
        \["User2",          "bgdclr0",  "synclr3",  "b"     ],
        \["User3",          "bgdclr0",  "synclr5",  "b"     ],
        \["User4",          "bgdclr0",  "synclr7",  "b"     ],
        \["User5",          "bgdclr0",  "synclr9",  "b"     ],
        \["User6",          "bgdclr0",  "msgclr1",  "b"     ],
        \["User7",          "bgdclr0",  "msgclr3",  "b"     ],
        \["User8",          "bgdclr0",  "msgclr5",  "b"     ],
        \["User9",          "bgdclr0",  "msgclr7",  "b"     ],
        \["User10",         "bgdclr0",  "msgclr9",  "b"     ],
        \["User11",         "bgdclr9",  "bgdclr4",  "b"     ],
        \["User12",         "bgdclr8",  "bgdclr3",  "b"     ],
        \["User13",         "bgdclr7",  "bgdclr2",  "b"     ],
        \["User14",         "bgdclr6",  "bgdclr1",  "b"     ],
        \["User15",         "bgdclr9",  "bgdclr5",  "b"     ],
        \["User16",         "bgdclr1",  "bgdclr6",  "b"     ],
        \["User17",         "bgdclr1",  "bgdclr7",  "b"     ],
        \["User18",         "bgdclr1",  "bgdclr8",  "b"     ],
        \["User19",         "bgdclr1",  "bgdclr9",  "b"     ],
        \] "}}}
"{{{ Colour
let s:hl_styles.Colour = [
        \["Cursor",         "bgdclr1",  "fgdclr1",  "n"     ],
        \["CursorS",        "bgdclr1",  "fgdclr1",  "n"     ],
        \["CursorIM",       "nocolor",  "msgclr4",  "n"     ],
        \["CursorLine",     "nocolor",  "bgdclr1",  "n"     ],
        \["CursorColumn",   "CursorLine"    ],
        \["Visual",         "nocolor",  "bgdclr4",  "n"     ],
        \["VisualNOS",      "nocolor",  "bgdclr3",  "n"     ],
        \["Search",         "fgdclr2",  "bgdclr3",  "n"     ],
        \["IncSearch",      "bgdclr0",  "msgclr2",  "b"     ],
        \["Wildmenu",       "fgdclr1",  "bgdclr2",  "b"    ],
        \["Pmenu",          "fgdclr1",  "bgdclr4",  "n"     ],
        \["PmenuSel",       "bgdclr0",  "fgdclr0",  "b"    ],
        \["PmenuSbar",      "fgdclr1",  "bgdclr5",  "n"     ],
        \["PmenuThumb",     "bgdclr2",  "bgdclr4",  "n"     ],
        \["Folded",         "bgdclr9",  "bgdclr1",  "n"     ],
        \["FoldColumn",     "fgdclr9",  "fgdclr4",  "n"     ],
        \["ColorColumn",    "msgclr7",  "bgdclr3",  "n"     ],
        \["LineNr",         "bgdclr2",  "fgdclr3",  "n"     ],
        \["SignColumn",     "msgclr2",  "fgdclr3",  "n"     ],
        \["TabLine",        "bgdclr3",  "fgdclr3",  "n"     ],
        \["TabLineSel",     "fgdclr0",  "bgdclr0",  "b"     ],
        \["TabLineFill",    "fgdclr9",  "fgdclr5",  "n"     ],
        \["StatusLine",     "bgdclr0",  "fgdclr5",  "b"     ],
        \["StatusLineNC",   "bgdclr2",  "fgdclr5",  "n"     ],
        \["VertSplit",      "StatusLineNC"  ],
        \["User1",          "bgdclr0",  "synclr1",  "b"     ],
        \["User2",          "bgdclr0",  "synclr3",  "b"     ],
        \["User3",          "bgdclr0",  "synclr5",  "b"     ],
        \["User4",          "bgdclr0",  "synclr7",  "b"     ],
        \["User5",          "bgdclr0",  "synclr9",  "b"     ],
        \["User6",          "bgdclr0",  "msgclr1",  "b"     ],
        \["User7",          "bgdclr0",  "msgclr3",  "b"     ],
        \["User8",          "bgdclr0",  "msgclr5",  "b"     ],
        \["User9",          "bgdclr0",  "msgclr7",  "b"     ],
        \["User10",         "bgdclr0",  "msgclr0",  "b"     ],
        \["User11",         "bgdclr2",  "fgdclr6",  "b"     ],
        \["User12",         "bgdclr3",  "fgdclr7",  "b"     ],
        \["User13",         "bgdclr4",  "fgdclr8",  "b"     ],
        \["User14",         "bgdclr4",  "fgdclr9",  "b"     ],
        \["User15",         "bgdclr2",  "fgdclr5",  "b"     ],
        \["User16",         "bgdclr2",  "fgdclr4",  "b"     ],
        \["User17",         "bgdclr2",  "fgdclr3",  "b"     ],
        \["User18",         "bgdclr2",  "fgdclr2",  "b"     ],
        \["User19",         "bgdclr2",  "fgdclr1",  "b"     ],
        \] "}}}
" "{{{ Default
" let s:hl_styles.Default = [
"         \["Cursor",         "bgdclr1",  "msgclr7",  "n"     ],
"         \["CursorS",        "bgdclr1",  "msgclr7",  "n"     ],
"         \["CursorIM",       "nocolor",  "msgclr4",  "n"     ],
"         \["CursorLine",     "nocolor",  "bgdclr1",  "n"     ],
"         \["CursorColumn",   "CursorLine"    ],
"         \["Visual",         "nocolor",  "bgdclr4",  "n"     ],
"         \["VisualNOS",      "nocolor",  "bgdclr5",  "n"     ],
"         \["Search",         "fgdclr1",  "bgdclr3",  "n"     ],
"         \["IncSearch",      "bgdclr0",  "msgclr2",  "b"     ],
"         \["Wildmenu",       "msgclr1",  "bgdclr1",  "b"     ],
"         \["Pmenu",          "fgdclr2",  "bgdclr3",  "n"     ],
"         \["PmenuSel",       "fgdclr1",  "bgdclr1",  "rb"    ],
"         \["PmenuSbar",      "fgdclr1",  "fgdclr6",  "n"     ],
"         \["PmenuThumb",     "bgdclr0",  "fgdclr2",  "n"     ],
"         \["Folded",         "bgdclr8",  "bgdclr1",  "n"     ],
"         \["ColorColumn",    "Folded"        ],
"         \["FoldColumn",     "bgdclr5",  "bgdclr2",  "b"     ],
"         \["LineNr",         "bgdclr4",  "bgdclr1",  "n"     ],
"         \["SignColumn",     "msgclr2",  "bgdclr2",  "n"     ],
"         \["TabLine",        "fgdclr4",  "bgdclr4",  "n"     ],
"         \["TabLineSel",     "fgdclr1",  "bgdclr0",  "b"     ],
"         \["TabLineFill",    "bgdclr9",  "bgdclr0",  "n"     ],
"         \["StatusLine",     "bgdclr0",  "bgdclr6",  "b"     ],
"         \["StatusLineNC",   "bgdclr4",  "bgdclr8",  "r"     ],
"         \["VertSplit",      "StatusLineNC"  ],
"         \["User1",          "bgdclr2",  "synclr1",  "b"     ],
"         \["User2",          "bgdclr2",  "bgdclr6",  "b"     ],
"         \["User3",          "bgdclr3",  "bgdclr7",  "b"     ],
"         \["User4",          "bgdclr4",  "bgdclr8",  "b"     ],
"         \["User5",          "bgdclr5",  "bgdclr9",  "b"     ],
"         \["User6",          "bgdclr3",  "bgdclr7",  "b"     ],
"         \["User7",          "bgdclr4",  "bgdclr7",  "b"     ],
"         \["User8",          "bgdclr5",  "bgdclr8",  "b"     ],
"         \["User9",          "bgdclr6",  "bgdclr9",  "b"     ],
"         \] "}}}
" {{{ Colour
" let s:hl_styles.Colour = [
"         \["Cursor",         "bgdclr1",  "msgclr4",  "n"     ],
"         \["CursorS",        "bgdclr1",  "msgclr4",  "n"     ],
"         \["CursorIM",       "nocolor",  "msgclr4",  "n"     ],
"         \["CursorLine",     "nocolor",  "difclr1",  "n"     ],
"         \["CursorColumn",   "CursorLine"    ],
"         \["Visual",         "nocolor",  "bgdclr4",  "n"     ],
"         \["VisualNOS",      "nocolor",  "bgdclr3",  "n"     ],
"         \["Search",         "fgdclr1",  "bgdclr4",  "n"     ],
"         \["IncSearch",      "bgdclr0",  "msgclr2",  "b"     ],
"         \["Wildmenu",       "difclr0",  "fgdclr2",  "rb"    ],
"         \["Pmenu",          "fgdclr2",  "bgdclr2",  "n"     ],
"         \["PmenuSel",       "fgdclr0",  "bgdclr2",  "rb"    ],
"         \["PmenuSbar",      "fgdclr1",  "bgdclr0",  "n"     ],
"         \["PmenuThumb",     "bgdclr2",  "bgdclr6",  "n"     ],
"         \["Folded",         "bgdclr9",  "bgdclr4",  "n"     ],
"         \["ColorColumn",    "Folded"        ],
"         \["FoldColumn",     "bgdclr3",  "bgdclr7",  "b"     ],
"         \["LineNr",         "bgdclr2",  "bgdclr6",  "n"     ],
"         \["SignColumn",     "msgclr2",  "bgdclr2",  "n"     ],
"         \["TabLine",        "bgdclr3",  "bgdclr7",  "n"     ],
"         \["TabLineSel",     "fgdclr2",  "bgdclr0",  "b"     ],
"         \["TabLineFill",    "bgdclr2",  "bgdclr6",  "n"     ],
"         \["StatusLine",     "fgdclr1",  "bgdclr3",  "b"     ],
"         \["StatusLineNC",   "bgdclr7",  "bgdclr3",  "r"     ],
"         \["VertSplit",      "StatusLineNC"  ],
"         \["User1",          "bgdclr4",  "synclr2",  "b"     ],
"         \["User2",          "bgdclr5",  "synclr4",  "b"     ],
"         \["User3",          "bgdclr6",  "synclr6",  "b"     ],
"         \["User4",          "bgdclr7",  "synclr8",  "b"     ],
"         \["User5",          "bgdclr5",  "bgdclr1",  "b"     ],
"         \["User6",          "bgdclr6",  "bgdclr2",  "b"     ],
"         \["User7",          "bgdclr7",  "bgdclr3",  "b"     ],
"         \["User8",          "bgdclr8",  "bgdclr4",  "b"     ],
"         \["User9",          "bgdclr8",  "bgdclr5",  "b"     ],
"         \] "}}}
" {{{ Classic
" 
" let s:hl_styles.Classic = [
"         \["Cursor",         "bgdclr1",  "msgclr7",  "n"     ],
"         \["CursorS",        "bgdclr1",  "msgclr7",  "n"     ],
"         \["CursorIM",       "nocolor",  "msgclr4",  "n"     ],
"         \["CursorLine",     "nocolor",  "bgdclr1",  "n"     ],
"         \["CursorColumn",   "CursorLine"    ],
"         \["Visual",         "nocolor",  "bgdclr4",  "n"     ],
"         \["VisualNOS",      "nocolor",  "bgdclr5",  "n"     ],
"         \["Search",         "fgdclr1",  "bgdclr3",  "n"     ],
"         \["IncSearch",      "bgdclr0",  "msgclr2",  "b"     ],
"         \["Wildmenu",       "msgclr1",  "bgdclr1",  "b"     ],
"         \["Pmenu",          "bgdclr8",  "bgdclr3",  "n"     ],
"         \["PmenuSel",       "fgdclr1",  "bgdclr1",  "rb"    ],
"         \["PmenuSbar",      "bgdclr0",  "bgdclr4",  "n"     ],
"         \["PmenuThumb",     "bgdclr7",  "bgdclr3",  "n"     ],
"         \["Folded",         "fgdclr5",  "bgdclr1",  "n"     ],
"         \["FoldColumn",     "bgdclr6",  "bgdclr2",  "b"     ],
"         \["ColorColumn",    "FoldColumn"        ],
"         \["LineNr",         "fgdclr1",  "bgdclr3",  "n"     ],
"         \["SignColumn",     "msgclr2",  "bgdclr3",  "n"     ],
"         \["TabLine",        "fgdclr4",  "bgdclr4",  "n"     ],
"         \["TabLineSel",     "fgdclr1",  "bgdclr0",  "b"     ],
"         \["TabLineFill",    "bgdclr9",  "bgdclr0",  "n"     ],
"         \["StatusLine",     "fgdclr0",  "bgdclr5",  "b"     ],
"         \["StatusLineNC",   "bgdclr1",  "bgdclr5",  "n"     ],
"         \["VertSplit",      "StatusLineNC"  ],
"         \["User1",          "bgdclr6",  "msgclr1",  "br"     ],
"         \["User2",          "bgdclr7",  "msgclr3",  "br"     ],
"         \["User3",          "bgdclr8",  "msgclr5",  "br"     ],
"         \["User4",          "bgdclr9",  "msgclr7",  "br"     ],
"         \["User5",          "bgdclr0",  "msgclr9",  "b"     ],
"         \["User6",          "bgdclr4",  "synclr1",  "br"     ],
"         \["User7",          "bgdclr3",  "synclr3",  "br"     ],
"         \["User8",          "bgdclr2",  "synclr5",  "br"     ],
"         \["User9",          "bgdclr6",  "synclr7",  "br"     ],
"         \["User10",         "bgdclr0",  "synclr9",  "b"     ],
"         \["User11",         "bgdclr9",  "bgdclr4",  "b"     ],
"         \["User12",         "bgdclr8",  "bgdclr3",  "b"     ],
"         \["User13",         "bgdclr7",  "bgdclr2",  "b"     ],
"         \["User14",         "bgdclr6",  "bgdclr1",  "b"     ],
"         \["User15",         "bgdclr9",  "bgdclr5",  "b"     ],
"         \["User16",         "bgdclr0",  "bgdclr6",  "b"     ],
"         \["User17",         "bgdclr0",  "bgdclr7",  "b"     ],
"         \["User18",         "bgdclr0",  "bgdclr8",  "b"     ],
"         \["User19",         "bgdclr0",  "bgdclr9",  "b"     ],
"         \] "}}}

" s:schemes "{{{2
"         scheme        bgd     fgd      syn      msg       dif
let s:default_schemes=[
        \["White"    ,"FFFFFF","303133","306399","CC2929","80AEB6"],
        \["Paper"    ,"EBE9E8","171D33","325F8F","C21B1B","DBA399"],
        \["Grape"    ,"0D0609","B895AA","B8825C","CC2929","506792"],
        \["Spring"   ,"CBE5A1","171F1B","436491","B80F28","DBC683"],
        \["MoonNight","060F1A","CACCA7","699DB8","EB2F3F","6D98B6"],
        \["Cloudy"   ,"ACE5DB","191D29","2B4E87","CC2929","DBCC78"],
        \["Flax"     ,"F2EFE4","1D2921","386599","CC292E","D9B2AD"],
        \["InkGreen" ,"0A0D07","8CA383","7F7BC7","FF3636","5E7091"],
        \["Cream"    ,"FFFACC","2C1733","386599","CC3D42","D9B2AD"],
        \["Black"    ,"000000","B8BDC2","6EA3E0","FF4040","578A92"],
        \]
let s:intro_lines = 2
let s:blt_in_lines=len(s:default_schemes)
" }}}
" term_ "{{{
" s:term hl"{{{
let s:term_hl=[
            \["Normal",         "fgrd_t",  "bgrd_t",  "n"    ],
            \["Cursor",         "fgrd_t",  "bgrd_t",  "r"    ],
            \["CursorS",        "fgrd_t",  "bgrd_t",  "r"    ],
            \["CursorLine",     "nocolor", "dif2_t",  "n"    ],
            \["CursorColumn",   "CursorLine"                 ],
            \["Visual",         "bgrd_t",  "fdep_t",  "n"    ],
            \["VisualNOS",      "Visual"                     ],
            \["Search",         "nocolor", "dif2_t",  "n"    ],
            \["IncSearch",      "nocolor", "msg1_t",  "n"    ],
            \["Wildmenu",       "msg1_t",  "fgrd_t",  "r"    ],
            \["Pmenu",          "fgrd_t",  "cntr_t",  "n"    ],
            \["PmenuSel",       "bgrd_t",  "msg1_t",  "b"    ],
            \["PmenuSbar",      "Pmenu"                      ],
            \["PmenuThumb",     "fgrd_t",  "cntr_t",  "r"    ],
            \["DiffAdd",        "bgrd_t",  "dif0_t",  "n"    ],
            \["DiffChange",     "bgrd_t",  "dif1_t",  "n"    ],
            \["DiffDelete",     "fgrd_t",  "bgrd_t",  "b"    ],
            \["DiffText",       "bgrd_t",  "dif2_t",  "n"    ],
            \["Folded",         "bgrd_t",  "cntr_t",  "n"    ],
            \["FoldColumn",     "dif2_t",  "fdep_t",  "n"    ],
            \["LineNr",         "Folded"                     ],
            \["SignColumn",     "msg1_t",  "fdep_t",  "n"    ],
            \["ColorColumn",    "Folded"                     ],
            \["tabline",        "bgrd_t",  "fdep_t",  "n"    ],
            \["tablinesel",     'syn0_t',  "bgrd_t",  "n"    ],
            \["tablinefill",    "cntr_t",  "fgrd_t",  "n"    ],
            \["StatusLine",     "bgrd_t",  "fgrd_t",  "b"    ],
            \["StatusLineNC",   "dif2_t",  "fgrd_t",  "n"    ],
            \["VertSplit",      "StatusLineNC"               ],
            \["User1",          "fgrd_t",  "msg0_t",  "n"    ],
            \["User2",          "fgrd_t",  "msg1_t",  "n"    ],
            \["User3",          "fgrd_t",  "msg2_t",  "n"    ],
            \["User4",          "fgrd_t",  "msg0_t",  "n"    ],
            \["User5",          "fgrd_t",  "msg1_t",  "n"    ],
            \["User6",          "fgrd_t",  "msg0_t",  "n"    ],
            \["User7",          "fgrd_t",  "msg2_t",  "n"    ],
            \["User8",          "fgrd_t",  "msg1_t",  "n"    ],
            \["User9",          "fgrd_t",  "msg2_t",  "n"    ],
            \["User10",         "fgrd_t",  "msg0_t",  "n"    ],
            \["User11",         "dif1_t",  "fgrd_t",  "n"    ],
            \["User12",         "dif1_t",  "fgrd_t",  "n"    ],
            \["User13",         "dif1_t",  "fgrd_t",  "n"    ],
            \["User14",         "dif1_t",  "fgrd_t",  "n"    ],
            \["User15",         "dif1_t",  "fgrd_t",  "n"    ],
            \["User16",         "dif1_t",  "fgrd_t",  "n"    ],
            \["User17",         "dif1_t",  "fgrd_t",  "n"    ],
            \["User18",         "dif1_t",  "fgrd_t",  "n"    ],
            \["User19",         "dif1_t",  "fgrd_t",  "n"    ],
            \["MatchParen",     "bgrd_t",  "syn1_t",  "n"    ],
            \["MoreMsg",        "syn0_t",  "bgrd_t",  "r"    ],
            \["Question",       "syn1_t",  "bgrd_t",  "r"    ],
            \["ModeMsg",        "syn2_t",  "bgrd_t",  "r"    ],
            \["WarningMsg",     "msg1_t",  "bgrd_t",  "r"    ],
            \["SpellLocal",     "WarningMsg"                 ],
            \["SpellRare",      "WarningMsg"                 ],
            \["ErrorMsg",       "msg0_t",  "bgrd_t",  "r"    ],
            \["Error",          "msg0_t",  "bgrd_t",  "b"    ],
            \["SpellBad",       "Error"                      ],
            \["SpellCap",       "SpellBad"                   ],
            \["Todo",           "fgrd_t",  "dif0_t",  "n"    ],
            \["Title",          "msg0_t",  "nocolor", "n"    ],
            \["Conceal",        "cntr_t",  "bgrd_t",  "n"    ],
            \["Comment",        "cntr_t",  "bgrd_t",  "n"    ],
            \["NonText",        "Comment"                    ],
            \["Ignore",         "Comment"                    ],
            \["Underlined",     "udep_t",  "bgrd_t",  "n"    ],
            \["SpecialComment", "syn0_t",  "bgrd_t",  "n"    ],
            \["Keyword",        "syn0_t",  "bgrd_t",  "b"    ],
            \["Statement",      "syn0_t",  "bgrd_t",  "n"    ],
            \["Conditional",    "Statement"                  ],
            \["Repeat",         "Statement"                  ],
            \["Label",          "syn0_t",  "bgrd_t",  "b"    ],
            \["Function",       "syn0_t",  "bgrd_t",  "n"    ],
            \["Structure",      "syn0_t",  "bgrd_t",  "b"    ],
            \["Type",           "syn1_t",  "bgrd_t",  "n"    ],
            \["Operator",       "Type"                       ],
            \["Directory",      "Type"                       ],
            \["Identifier",     "syn1_t",  "bgrd_t",  "n"    ],
            \["StorageClass",   "Identifier"                 ],
            \["Constant",       "syn1_t",  "bgrd_t",  "b"    ],
            \["Boolean",        "syn1_t",  "bgrd_t",  "n"    ],
            \["Float",          "Boolean"                    ],
            \["Number",         "Boolean"                    ],
            \["String",         "syn2_t",  "bgrd_t",  "n"    ],
            \["Character",      "syn2_t",  "bgrd_t",  "b"    ],
            \["Exception",      "syn3_t",  "bgrd_t",  "r"    ],
            \["Debug",          "Exception"                  ],
            \["SpecialChar",    "syn3_t",  "bgrd_t",  "n"    ],
            \["SpecialKey",     "SpecialChar"                ],
            \["Tag",            "SpecialChar"                ],
            \["PreProc",        "syn3_t",  "bgrd_t",  "n"    ],
            \["Include",        "PreProc"                    ],
            \["Define",         "PreProc"                    ],
            \["Macro",          "PreProc"                    ],
            \["PreCondit",      "PreProc"                    ],
            \["Special",        "syn3_t",  "bgrd_t",  "n"    ],
            \["Delimiter",      "Special"                    ],
            \]
"}}}
"bold name
let s:b8_name=[
            \"DarkGrey","Blue","Green","Cyan","Red","Magenta","Yellow",
            \"White",
\]
let s:n8_num=[0,4,2,6,1,5,3,7]
function! s:set_light16_var() "{{{
    let s:fgrd_t = "black"
    let s:bgrd_t = "lightgrey"
    let s:cntr_t = "darkgrey"
    let s:fdep_t = "darkgrey"
    let s:udep_t = "darkblue"
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
    " let s:t_Co   = 8
    let s:fgrd_t = "black"
    let s:bgrd_t = "lightgrey"
    let s:cntr_t = "darkcyan"
    let s:fdep_t = "black"
    let s:udep_t = "darkblue"
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
    let s:fgrd_t = "lightgrey"
    let s:bgrd_t = "black"
    let s:cntr_t = "darkgrey"
    let s:fdep_t = "darkgrey"
    let s:udep_t = "blue"
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
    let s:fgrd_t="lightgrey"
    let s:bgrd_t="black"
    let s:cntr_t="darkcyan"
    let s:fdep_t="white"
    let s:udep_t="blue"
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
"}}}
"
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
            \["VimwikiHeader1       ", "synclr0",  "nocolor",  "b" ],
            \["VimwikiHeader2       ", "synclr2",  "nocolor",  "b" ],
            \["VimwikiHeader3       ", "synclr4",  "nocolor",  "b" ],
            \["VimwikiHeader4       ", "synclr6",  "nocolor",  "b" ],
            \["VimwikiHeader5       ", "synclr7",  "nocolor",  "b" ],
            \["VimwikiHeader6       ", "synclr8",  "nocolor",  "b" ],
            \]
let s:synlink_dict.xml = [
            \["xmlProcessingDelim   ","PreProc       "            ],
            \["xmlNamespace         ","PreProc       "            ],
            \["xmlTag               ","Tag "                      ],
            \["xmlTagName           ","Delimiter"                 ],
            \]
function! s:syntax_tuning() "{{{
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
                    \.' contains=vimLineComment containedin=ALL display'

        for i in range(1,7)
            exe 'syn match galaxyIndent'.i.' #\%(^\1\{'.i.'}\)\@<=\('.in_str.'\)'.p_txt
                    \.' contains=vimLineComment containedin=ALL display'
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
    if s:mode == "cterm" && &t_Co<=16
        let s:indent_hl_list=[
                    \["galaxyIndent0", "nocolor",  "dif0_t",  "n"     ],
                    \["galaxyIndent1", "nocolor",  "dif1_t",  "n"     ],
                    \["galaxyIndent2", "nocolor",  "dif2_t",  "n"     ],
                    \["galaxyIndent3", "nocolor",  "dif0_t",  "n"     ],
                    \["galaxyIndent4", "nocolor",  "dif1_t",  "n"     ],
                    \["galaxyIndent5", "nocolor",  "dif2_t",  "n"     ],
                    \["galaxyIndent6", "nocolor",  "dif0_t",  "n"     ],
                    \["galaxyIndent7", "nocolor",  "dif1_t",  "n"     ],
                    \]
    elseif exists("s:scheme.style") && s:scheme.style =~? 'Colour'
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
    hi link galaxyIndentErr Error
endfunction "}}}
function! s:indent_hl_aug() "{{{
    if g:galaxy_enable_indent_hl == 1
        aug galaxy#indent_hl
            for file in split(g:galaxy_indent_hl_ftype,",")
                exe "au! FileType" file "call galaxy#toggle_indent_hl('ON')"
            endfor
        aug END
    else
        silent! windo call s:clear_indent_syn()
        silent! windo call s:clear_indent_hl()
        aug galaxy#indent_hl
            au!
        aug END
    endif
endfunction "}}}
function! galaxy#toggle_indent_hl(...) "{{{
    if !exists("b:galaxy_indent_hl")
                \ || b:galaxy_indent_hl == 0
                \ || (a:0 && a:1 == "ON")
        call s:load_indent_hl_syn()
        call s:indent_hl()
        let b:galaxy_indent_hl = 1
    elseif b:galaxy_indent_hl == 1 || (a:0 && a:1 == "OFF")
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
function! galaxy#statusline(cur) "{{{
    let [mode,num,file,env,stat,ro,ft,pos,pos2,mode2] = [
            \'%2{galaxy#mode()} ',  '%3n. ', ' %<%F %= ',
            \'%(%{galaxy#env()} %)', '%(%{galaxy#stat()} %)',
            \'%( %M%R %)',  '%( %Y%( %{galaxy#fflag()}%) %)', 
            \'%5l,%-3c %P ', '%3p%%%5l,%-3c ', '%2{winnr()} '
            \]

    " num of hl-User*
    let n0 = 0       
    let [c1,c2,c3,c4,c5] = [1 , 2, 3, 4, 5]
    let [m1,m2,m3,m4,m5] = [6 , 7, 8, 9,10]
    let [l1,l2,l3,l4,l0] = [11,12,13,14,15]
    let [d1,d2,d3,d4,d0] = [16,17,18,19,15]

    let line =""
    if     a:cur == 1 && g:galaxy_statusline_style == "Left"
        let line.= s:clr(m5,mode)
        let line.= s:clr(m4,num)
        let line.= s:clr(m3,ft)
        let line.= s:clr(m2,env)
        let line.= s:clr(m1,stat)
        let line.= s:clr(c1,ro)
        let line.= s:clr(n0,file)
        let line.= s:clr(l2,pos)
    elseif a:cur == 0 && g:galaxy_statusline_style == "Left"
        let line.= s:clr(d4,mode2)
        let line.= s:clr(d3,num)
        let line.= s:clr(d2,ft)
        let line.= s:clr(d1,env)
        let line.= s:clr(d0,stat)
        let line.= s:clr(d0,ro)
        let line.= s:clr(n0,file)
        let line.= s:clr(l2,pos)
    elseif a:cur == 1 && g:galaxy_statusline_style == "Right"
        let line.= s:clr(l2,num)
        let line.= s:clr(l1,pos2)
        let line.= s:clr(n0,file)
        let line.= s:clr(c1,env)
        let line.= s:clr(c2,stat)
        let line.= s:clr(c3,ro)
        let line.= s:clr(c4,ft)
        let line.= s:clr(c5,mode)
    elseif a:cur == 0 && g:galaxy_statusline_style == "Right"
        let line.= s:clr(l2,num)
        let line.= s:clr(l1,pos2)
        let line.= s:clr(n0,file)
        let line.= s:clr(d1,env)
        let line.= s:clr(d2,stat)
        let line.= s:clr(d3,ro)
        let line.= s:clr(d3,ft)
        let line.= s:clr(d4,mode2)
    elseif g:galaxy_statusline_style == "Test"
        let line.= s:clr( 0,"  0 ")
        let line.= s:clr( 1,"  1 ")
        let line.= s:clr( 2,"  2 ")
        let line.= s:clr( 3,"  3 ")
        let line.= s:clr( 4,"  4 ")
        let line.= s:clr( 5,"  5 ")
        let line.= s:clr( 6,"  6 ")
        let line.= s:clr( 7,"  7 ")
        let line.= s:clr( 8,"  8 ")
        let line.= s:clr( 9,"  9 ")
        let line.= s:clr(10," 10 ")
        let line.= s:clr(11," 11 ")
        let line.= s:clr(12," 12 ")
        let line.= s:clr(13," 13 ")
        let line.= s:clr(14," 14 ")
        let line.= s:clr(15," 15 ")
        let line.= s:clr(16," 16 ")
        let line.= s:clr(17," 17 ")
        let line.= s:clr(18," 18 ")
        let line.= s:clr(19," 19 ")
    endif
    return line
endfunction "}}}
function! s:statusline_aug() "{{{

    set  stl=%!galaxy#statusline(0)
    setl stl=%!galaxy#statusline(1)

    aug galaxy#win_enter
        au!
        au! BufWinEnter,WinEnter          * setl stl=%!galaxy#statusline(1)
        au! WinLeave                      * set  stl <
    aug END

    if g:galaxy_statusline_hl_insert != 1 
        return
    endif

    let s:list_insert_enter = []
    let s:list_insert_leave = []
    let hl_list = (s:mode=="cterm" && &t_Co<=16) ? s:term_hl : s:hl_styles[s:scheme.style]
    for item in hl_list
        if item[0] =~ '^User\d\+$'
            let d = substitute(item[0],'User\(\d\+\)','\1','')
            if d>10
                continue
            else
                call add(s:list_insert_leave,item)
            endif

            let _item = copy(item)
            if s:mode=="cterm" &&  &t_Co <= 16
                let _item[1] = "bgdr_t"
                let _item[2] = "msg0_t"
            else
                let _item[1] = "bgdclr0"
                let _item[2] = "msgclr8"
            endif
            call add(s:list_insert_enter,_item)
        endif
    endfor
    
    "NOTE: store it for not executing s:hl_list() every time
    let s:hl_cmd_ie = s:hi_list(s:list_insert_enter)
    let s:hl_cmd_il = s:hi_list(s:list_insert_leave)
    aug galaxy#insert_enter
        au!
        au InsertEnter * for cmd in s:hl_cmd_ie| exec cmd |endfor
        au InsertLeave * for cmd in s:hl_cmd_il| exec cmd |endfor
    aug END
endfunction "}}}
function! s:term_cursor() "{{{
    if s:mode== "cterm" && &t_Co <=16
        if s:bgy=="dark"
            let color_normal="LightGrey"
            let color_insert="Red"
        else
            let color_normal="Black"
            let color_insert="red"
        endif
    else
        let color_normal="#".s:fgdclr_list[1]
        let color_insert="#".s:msgclr_list[0]
    endif
    let color_exit=g:galaxy_tcursor_color
    "  XXX:  shell cmd must using shellescape. 
    "  option could without escape.
    let &t_SI = s:term_ce(color_insert)
    let &t_EI = s:term_ce(color_normal)
    exe "sil !printf '". s:term_ce(shellescape(color_normal,1)) ."'"
    aug galaxy#term_cursor
        au!
        exe "au VimLeave * sil !printf '". s:term_ce(shellescape(color_exit,1)) ."'"
    aug END
endfunction "}}}
function! s:term_ce(text) "{{{
    " terminal cursor control sequences
    " http://en.wikipedia.org/wiki/ANSI_escape_sequences
    " http://invisible-island.net/xterm/ctlseqs/ctlseqs.html
    if  &term =~ "screen" && exists('$TMUX') && !exists('$SUDO_UID')
        " for tmux, should substitude every inside '\033' to '\033\033'
        return "\033Ptmux;\033\033]12;".a:text."\007\033\\"
    elseif &term =~ "screen"  && !exists('$SUDO_UID')
        return "\033P\033]12;".a:text."\007\033\\"
    else
        return "\033]12;".a:text."\007"
    endif
endfunction "}}}
let s:env_loaded = 0
function! s:load_env() "{{{
    " load after all autoload/files loaded
    if exists("*SyntasticStatuslineFlag") "{{{
        call s:default("g:galaxy_env_syntastic", 1)
        let g:syntastic_stl_format = '[%E{%eE #1:%fe}%B{, }%W{%wW #1:%fw}]'
    else
        let g:galaxy_env_syntastic = 0
    endif "}}}
    if exists("*fugitive#statusline") "{{{
        call s:default("g:galaxy_env_fugitive", 1)
    else
        let g:galaxy_env_fugitive = 0
    endif "}}}
    if has("python") "{{{
        call s:default("g:galaxy_env_virtualenv", 1)
    else
        let g:galaxy_env_virtualenv = 0
    endif "}}}
endfunction "}}}
function! galaxy#env() "{{{

    if s:env_loaded == 0
        call s:load_env()
        let s:env_loaded = 1
    endif
    
    let val = ""
    if g:galaxy_env_syntastic
        let s = SyntasticStatuslineFlag()
        if !empty(s)
            let val.=" S:".s
        endif
    endif
    if g:galaxy_env_fugitive
        let l = fugitive#statusline()
        if !empty(l)
            let val.= " ".substitute(l, 
                        \'\v.*GIT(:\w+)=\((\w+)\).*','G:[\2\1]','')
        endif 
    endif
    if g:galaxy_env_virtualenv && exists("$VIRTUAL_ENV")
        let v = fnamemodify($VIRTUAL_ENV,":t")
        if !empty(v)
            let val.= " V:[".v[:10]."]"
        endif
    endif
    if val =~ '^\s*$'
        return ""
    else
        return val
    endif
endfunction "}}}
function! galaxy#mode() "{{{
    let val= ''
    let m = mode()
    if     m == '' | let val = 'CV'
    elseif m == '' | let val = 'CS'
    else             | let val = m
    endif
    return val
endfunction "}}}
function! galaxy#fflag() "{{{
    let val = ""

    if &ff != g:galaxy_default_ff
        let val.= " ".toupper(&ff[:3])
    endif
    let enc = &enc
    if enc == g:galaxy_default_enc
        " pass
    elseif enc == "utf-8"  | let val.= " U8"
    elseif enc == "utf-16" | let val.= " 16"
    elseif enc == "utf-32" | let val.= " 32"
    elseif enc == "latin1" | let val.= " L1"
    elseif enc =~ '^gb'    | let val.= " GB"
    else                   | let val.= " ".&enc
    endif
    if !empty(val)  | return val
    else            | return ""
    endif
endfunction "}}}
function! galaxy#stat() "{{{
    let val = ""
    if &paste | let val .= " Pst" | endif
    if &diff  | let val .= " Dif" | endif
    if &list  | let val .= " Lst" | endif
    if &bin   | let val .= " Bin" | endif
    if !empty(&keymap) | let val .= " K:" . &keymap[0] | endif
    if !empty(val)  | return val
    else            | return ""
    endif
endfunction "}}}
function! s:clr(clr,str) "{{{
    if a:clr == 0
        return '%*'.a:str
    elseif a:clr >= 10
        return '%#User'.a:clr.'#'.a:str
    else
        return '%'.a:clr.'*'.a:str
    endif
endfunction "}}}
" CLRS"{{{1
"======================================================================
function! s:gen_base_colors(colors) "{{{

    let NOCYCLE = 0
    let [bgd, fgd, syn, msg, dif] = a:colors
    
    " NOTE: more darker/lighter than background color bgdclr0
    if s:bgy=="dark" | let y_sign = 1
    else             | let y_sign = -1
    endif

    " NOTE: add value to adjust dark background of blue and purple
    let [h,s,v] = colorv#hex2hsv(bgd)
    if (h >=200 && h <= 280 )
        let bf = 1.5
    else
        let bf = 1
    endif
    let s:bgdclr_list=colorv#list_gen(bgd,"Value",10,y_sign*(5*bf),NOCYCLE)
    let s:fgdclr_list=colorv#list_gen(fgd,"Value",10,(-y_sign*5),NOCYCLE)
    let s:synclr_list=colorv#list_yiq_gen(syn,"Hue",10,35)
    let s:msgclr_list=colorv#list_yiq_gen(msg,"Hue",10,35)
    let s:difclr_list=colorv#list_yiq_gen(dif,"Hue",10,35)

    for c in ["bgd","fgd","syn","msg","dif"]
        for i in range(len(s:{c}clr_list))

            let s:{c}clr{i}  = s:{c}clr_list[i]
            " let s:difclr mix with background color
            if c == "dif"
                let s:{c}clr{i} = colorv#hexadd(
                            \s:{c}clr{i}."FF", s:bgdclr0."99")[0:-3]
            endif
            
            " Hex copy
            let s:h{c}clr{i}  = s:{c}clr{i}
            " convert to term code
            if s:mode=="cterm"
                let s:{c}clr{i}  = colorv#hex2term(s:{c}clr{i},"CHECK")
            endif
        endfor
    endfor


endfunction "}}}
function! s:hi_list(list) "{{{ 
    let list=a:list
    let hl_list = []
    for item in list
        if len(item) == 4
            let [hl_grp,hl_fg,hl_bg,hl_fm]=item
            let [fm_txt,bg_txt,fg_txt,sp_txt] = ["","","",""]
            if s:mode == "cterm" && &t_Co <= 16
                let fm_txt = empty(hl_fm) ? "" : "NONE"
                let fm_txt .= hl_fm=~'r' ? ",reverse"     : ""

                let fg_txt = empty(hl_fg) ? hl_fg :
                            \ exists("s:".hl_fg) ? s:{hl_fg} : s:fgrd_t
                let bg_txt = empty(hl_bg) ? hl_bg :
                            \ exists("s:".hl_bg) ? s:{hl_bg} : s:bgrd_t

                " term 8 need set cterm to bold.
                if &t_Co<=8 "{{{
                    for i in range(8)
                        " for t8 color name
                        if fg_txt =~? '\<'.s:b8_name[i].'\>'
                            let fg_txt=s:n8_num[i]
                            let fm_txt.=",bold"
                        endif
                        if bg_txt =~? '\<'.s:b8_name[i].'\>'
                            let bg_txt=s:n8_num[i]
                        endif
                    endfor
                endif "}}}
            else
                let [hl_grp,hl_fg,hl_bg,hl_fm] = item
                
                "  'msgclr0' '5A3F00'
                let fg_txt = hl_fg =~ '\x\{6}' || empty(hl_fg) ? hl_fg :
                        \ exists("s:".hl_fg) ? s:{hl_fg} : s:fgdclr0
                let bg_txt = hl_bg =~ '\x\{6}' || empty(hl_bg) ? hl_bg :
                        \ exists("s:".hl_bg) ? s:{hl_bg} : s:bgdclr0

                if s:mode=="gui"
                    let fg_txt = fg_txt =~ '^\x\{6}$' ? "#".fg_txt : fg_txt
                    let bg_txt = bg_txt =~ '^\x\{6}$' ? "#".bg_txt : bg_txt
                else
                    " terminal 256
                    let fg_txt= fg_txt =~ '\x\{6}$' ? 
                                \colorv#hex2term(fg_txt,"CHECK") : fg_txt
                    let bg_txt= bg_txt =~ '\x\{6}$' ? 
                                \colorv#hex2term(bg_txt,"CHECK") : bg_txt
                endif

                let fm_txt = empty(hl_fm) ? "" : "NONE"
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

                " not working in term
                if hl_fm=~'i' && s:mode=="gui"
                    let fm_txt .= ",italic"
                endif
                if hl_fm=~'s' && s:mode=="gui"
                    let fm_txt .= ",standout"
                endif
            endif
            let bg_txt = empty(bg_txt) ? "" : " ".s:mode."bg=".bg_txt
            let fg_txt = empty(fg_txt) ? "" : " ".s:mode."fg=".fg_txt
            let sp_txt = empty(sp_txt) ? "" : " ".s:mode."sp=".sp_txt
            let fm_txt = empty(fm_txt) ? "" : " ".s:mode."="  .fm_txt

            if !empty(fg_txt) || !empty(bg_txt) 
                \|| !empty(fm_txt) || !empty(sp_txt)
                let cmd =  "hi! ".hl_grp.fg_txt.bg_txt.sp_txt.fm_txt
                try
                    exec cmd
                catch /^Vim\%((\a\+)\)\=:E/	 
                    call s:debug(hl_grp.v:exception)
                endtry
                call s:debug(cmd)
            endif
            call add(hl_list, cmd)

        elseif len(item) == 2
            let [hl_from,hl_to]=item
            let cmd =  "hi! link ".hl_from." ".hl_to
            exec cmd
            call s:debug(cmd)
            call add(hl_list, cmd)
        endif
    endfor
    return hl_list
endfunction "}}}
function! s:set_background() "{{{
    " XXX: there maybe errors of &background in terminal
    if s:bgy=="dark"
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
" WINS "{{{1
"======================================================================
function! galaxy#win() "{{{

    cal s:new_win(s:galaxy.name)
    " Pre
    cal s:win_map()

    "Text
    let lines = [
    \"GALAXY v1.0.0      Screen:sc   Load:<Click>  Edit:e  New:gn  Tips:?",
    \"STYLE: Default     SYNTAX:Less   STATUSLINE:Left    INDENT_HL:On  ",
    \"SCHEME:            BGD    FGD    SYN    MSG    DIF               ",
    \]
    let s:intro_lines=len(lines)
    let lines[0] = "GALAXY v" . g:galaxy.version 
                \. s:head_tip[(s:random(0,2))]
    let lines[1] = s:get_opt_line()   

    " Load scheme dicts
    cal s:load_file_schemes()
    " Set default first , items(dict) is an unordered list
    for [name, colors] in sort(items(s:d_scheme_dict)) + 
                         \sort(items(s:f_scheme_dict))
        if name == s:scheme.name
            let lines +=[printf("%-15.15s", name)."    ".join(colors)." <<"]
        else
            let lines +=[printf("%-15.15s", name)."    ".join(colors)]
        endif
    endfor

    setl ma
        call setline(1,lines)
    setl noma

    if winnr('$') != 1
        let win_h = len(lines)
        let win_h = win_h > 20 ? 20 : win_h
        execute 'resize' win_h
    endif

    call galaxy#load("","","s")
    cal s:win_hi()

    call s:echo(len(s:A_scheme_dict)." schemes loaded."
                    \."Now is [".s:scheme.name."].")
endfunction "}}}
function! s:win_load_scheme() "{{{
    let row=line('.')
    if row <= s:intro_lines
        call s:win_opt_set()
    else
        let name = s:name_in_row(row)
        let colors = s:colors_in_row(row)
        let line = [printf("%-15.15s", name)."    ".join(colors)." <<"]
        let old_name = s:scheme.name
        let old_row =  search('\<'.old_name.'\>','w')
        if old_row
            let old_colors = s:colors_in_row(old_row)
            let old_line = [printf("%-15.15s", old_name)."    "
                        \.join(old_colors)]
            setl ma
            call setline(old_row,old_line)
            setl noma
        endif
        setl ma
            call setline(row,line)
        setl noma
        call galaxy#load(name)
        0 call search('\<'.name.'\>','w')
        
        " update screen
        if s:get_bufwin(s:screen.name)
            call s:screen.win()
            wincmd p
        endif
    endif
endfunction "}}}
function! s:win_del_scheme() "{{{
    let [row,col] = getpos('.')[1:2]
    if row <= s:intro_lines
        call s:echo("Move down to choose a scheme.")
        return
    elseif row<= s:intro_lines + s:blt_in_lines
        call s:echo("Could not delete built-in Schemes.")
        return
    endif
    
    " save to cache
    let name = s:name_in_row(row)
    if has_key(s:f_scheme_dict, name)
        call remove(s:f_scheme_dict, name)
        call s:save_file_schemes() 
        " write buffer
        if s:get_bufwin(s:galaxy.name)
            setl ma
            exec row."delete"
            setl noma
        endif
        call s:echo("Scheme ".name." deleted.")
    else
        call s:echo("Could not find scheme ".name)
        return
    endif
    
endfunction "}}}
function! s:win_rename_scheme() "{{{
    let [row,col] = getpos('.')[1:2]
     
    if row <= s:intro_lines
        call s:echo("Move down to choose a scheme.")
        return
    endif

    let name = s:name_in_row(row)
    let new_name = input("Input a new name:")
    let new_name = s:valid_name(new_name)
    if new_name is 0
        return
    endif
    
    if has_key(s:f_scheme_dict, name)
        "find from f_dict, cpy colors and rmv old one
        let colors  = copy(s:f_scheme_dict[name])
        cal remove(s:f_scheme_dict, name)
        let note = "Rename scheme '".name."' to '". new_name."'"
        let cmd = "call setline(row, s:line_sub(new_name , join(colors), 20))"
    else
        "not find from f_dict. cpy colors from blt-in
        let colors  = copy(s:d_scheme_dict[name])
        let note = "Create scheme '".new_name."' from Builti-in '".name."'"
        let cmd = "call append(line('$'), s:line_sub(new_name , join(colors), 20))"
    endif

    " add to dict
    cal extend(s:f_scheme_dict, {new_name : colors}, "force")
    cal s:save_file_schemes() 
    cal s:echo(note)

    if s:get_bufwin(s:galaxy.name)
        setl ma
            exe cmd
        setl noma
        0 cal search('\<'.new_name.'\>','w')
    endif
endfunction "}}}
function! s:win_edt_scheme_cv() "{{{
    let [row, col] = getpos('.')[1:2]

    if row <= s:intro_lines
        call s:win_opt_set()
        return
    endif

    let scheme = s:scheme_in_row(row)
    let colors = s:colors_in_scheme(scheme)
    let s:edit_scheme = deepcopy(scheme)
    let s:edit_row = row
    let s:edit_buf = "win"
    let s:edit_idx = -1

    for i in range(5)
        if col <= 16
            call s:win_rename_scheme()
            return
        elseif col >= 20+i*7 && col <= 25+i*7
            call s:input_cv_call(colors[i],s:hlp_txt[i]
                    \,"galaxy#edit_callback",['g:colorv.HEX'])
            let s:edit_idx = i
            return
        endif
    endfor

endfunction "}}}
function! galaxy#edit_callback(color) "{{{

    if !exists("s:edit_idx") || s:edit_idx == -1
        return
    endif

    let row    = s:edit_row

    let name   = s:name_in_scheme(s:edit_scheme)
    if has_key(s:d_scheme_dict, name)
        call s:caution("You are editing a Built-in scheme. ")
        let new_name = input("Input new name to make a copy:")
        let name = s:valid_name(new_name)
        if name is 0
            return
        endif
    endif

    let colors = s:colors_in_scheme(s:edit_scheme)
    if a:color=~'\x\{6}'
        let colors[s:edit_idx]=a:color
    else
        let colors[s:edit_idx]=eval(a:color)
    endif

    let scheme = { name : colors }
    cal extend(s:f_scheme_dict, scheme, "force")
    cal s:save_file_schemes()
    cal galaxy#load(name)

    " edit line in buffer
    if !s:get_bufwin(s:galaxy.name) && !s:get_bufwin(s:screen.name)
        return
    endif

    if s:edit_buf == "scr"
        call s:screen.win()
    else
        call galaxy#win()
    endif

endfunction "}}}
function! s:input_cv_call(color,txt,callfunc,callarg) "{{{
    "1:callback when exit  | 2: callback when update
    call colorv#win("",a:color,["exit",a:callfunc,a:callarg])
    call s:echo(a:txt)
endfunction "}}}
function! s:win_new_scheme_cv() "{{{
    cal s:echo("Two steps to generate a scheme.")
    let name=input("1. Input scheme name:\n")
    let name = s:valid_name(name)
    if name is 0
        return
    endif
    let s:gen_name = name
    let randhex = printf("%06.6s",printf("%X",s:random(0,16777215)))
    cal s:input_cv_call(randhex,"2. Choose Background"
                \,"galaxy#gen_callback",['g:colorv.HEX','s:gen_name'])
endfunction "}}}
function! s:win_new_scheme_rd() "{{{
    cal s:echo("One steps to generate a random scheme.")
    let name=input("1. Input scheme name:\n")
    let name = s:valid_name(name)
    if name is 0
        return
    endif
    let randhex = printf("%06.6s",printf("%X",s:random(0,16777215)))
    call galaxy#gen_callback(randhex,name)
endfunction "}}}
function! galaxy#gen_callback(color,name,...) "{{{
    let name=a:name
    if name =~ '^[glstvw]:\w*'
        let name=eval(name)
    else
        let name=name
    endif
    let colors=[]
    let color=a:color
    if color =~'\x\{6}'
        let bgr=color
    else
        let bgr=eval(color)
    endif
    "{{{ Gen Colors
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
"}}}
    for i in [bgr,fgr,syn,msg,dif]
        call add(colors,i)
    endfor
    
    let name = name[:15]
    let scheme = {name : colors}
    call extend(s:f_scheme_dict, scheme, "force")

    if a:0 && a:1 =="SILENT"
        return
    endif

    call s:save_file_schemes()
    call galaxy#load(name)
    call galaxy#win()
    0cal search('\<'.name.'\>','w')

endfunction "}}}
function! galaxy#auto_gen() "{{{
    let namelist=[]
    for i in getline(1,'$')
        if i =~ '\(\S*\)\s*\(#\x\{6}\)'
            let name=substitute(i,'\(^.*\)\s*\(#\x\{6}\)','\1','')
            let name=substitute(name,'\s*',"",'g')
            let name=substitute(name,'\W','_','')
            let name =strpart(name,0,16)
            let color=matchstr(i,'#\x\{6}')
            let color=substitute(color,'#','','')
            call add(namelist,[name,color])
        endif
    endfor
    if !empty(namelist)
        call s:caution("Generating ColorSchemes, Please Wait...")
        let n=0
        for [name,color] in namelist
            call galaxy#gen_callback(color,name, "SILENT")
            let n+=1
        endfor
        call s:save_file_schemes()
        call s:caution("Generating Complete! ".n." Schemes was generated.")
        call galaxy#load()
    endif
endfunction "}}}

function! s:valid_name(name) "{{{
    if empty(a:name)
        call s:error("Name is empty.")
        return 0
    elseif a:name !~ '^\w*$'
        call s:error("Name must contain word characters ([0-9a-zA-Z_]) only.")
        return 0
    elseif a:name !~ '^\w\{4,15}$'
        call s:error("Name must have 4~15 characters.")
        return 0
    elseif a:name =~ '^\x\{6}$'
        call s:error("Don't use Hex as Name.")
        return 0
    else
        let name = a:name
        if has_key(s:A_scheme_dict, name)
            call s:error("Name already exists.")
            return 0
        endif
    endif
    return name
endfunction "}}}
function! s:win_setl() "{{{
    setl winfixwidth noea
    setl nocursorline nocursorcolumn
    setl buftype=nofile bufhidden=delete
    setl nolist noswapfile nobuflisted
    setl nowrap nofoldenable nomodeline nonumber nospell
    setl foldcolumn=0 sidescrolloff=0 tw=0
    if v:version >= 703
        setl cc=
    endif
    iabc <buffer>
endfunction "}}}
function! s:win_map() "{{{
    mapclear <buffer>
    nma <silent><buffer> q  :call galaxy#exit_win()<cr>
    nma <silent><buffer> Q  :call galaxy#exit_win()<cr>
    nma <silent><buffer> gn :call <SID>win_new_scheme_cv()<cr>
    nma <silent><buffer> gr :call <SID>win_new_scheme_rd()<cr>
    nma <silent><buffer> e  :call <SID>win_edt_scheme_cv()<cr>
    nma <silent><buffer> <leader>ce  :call <SID>win_edt_scheme_cv()<cr>
    nma <silent><buffer> dd :call <SID>win_del_scheme()<cr>

    nno <silent><buffer> <Tab> W
    nno <silent><buffer> <S-Tab> B

    map <silent><buffer> sc   :call galaxy#screen.win()<cr>
    map <silent><buffer> sv   :call galaxy#screen.saver()<CR>
    map <silent><buffer> <CR> :call <SID>win_load_scheme()<cr>
    map <silent><buffer> <Kenter> :call <SID>win_load_scheme()<cr>
    map <silent><buffer> <Space> :call <SID>win_load_scheme())<cr>
    map <silent><buffer> <2-Leftmouse> :call <SID>win_load_scheme()<cr>

    map <silent><buffer> ? :call <SID>echo_tips()<cr>
    map <silent><buffer> <F1> :h galaxy-quickstart<cr>
    map <silent><buffer> H :h galaxy-quickstart<cr>
endfunction "}}}
function! s:win_hi() "{{{
    call matchadd("Function"        , '\%1l\%<20c')
    call matchadd("Comment"         , '\%1l\%>19c')
    call matchadd("TODO"            , '\%1l\%>65c[?H]', 10)
    call matchadd("Comment"         , '\%2l'          , 4)
    call matchadd("SpecialComment"  , '\%<3l\w*:'     , 15)
    call matchadd("WarningMsg"      , '\%3l'          , 10)
    call matchadd("Title"           , '\%>54c\%<56c<<', 15)
    aug galaxy#cursor_move
        au! CursorMoved,CursorMovedI <buffer>  call s:cursor_text_hi()
    aug END
    call colorv#preview("sbNc")
endfunction "}}}
function! s:cursor_text_hi()  "{{{
    let [row,col] = getpos('.')[1:2]
    execute '3match' "none"
    execute '2match' "none"
    if  row == 2
        " check if it is whitespace
        if  getline(row)[col-1] =~ '\s'
            return
        endif

        let [a,b] = s:get_cWORD_pos()
        execute '3match' 'PmenuSel' '/\%'.(2).'l'
                    \.'\%>'.(a-1).'c\%<'.(b+1).'c/'
        return

    endif
    if  row > 3
        if  getline(row)[col-1] =~ '\s'
            execute '2match' "PmenuSel".' /\%'.(row)
                \.'l\%<17c/'
            return
        endif
        let [a,b] = s:get_cWORD_pos()
        execute '3match' "PmenuSel".' /\%'.(3)
                \.'l\%>17c\%>'.(a-1) .'c\%<'.(b+1).'c/'
        execute '2match' "PmenuSel".' /\%'.(row)
                \.'l\(\%>'.(a-1) .'c\%<'.(b+1).'c\|\%<17c\)/'
        return
    endif
endfunction "}}}
function! s:new_win(name,...) "{{{
    let opt = a:0 ? a:1 : g:galaxy.winpos
    let spLoc= opt=="top" ? "topleft " : "botright "
    let spSize= 20
    let spDirc= ""
    let exists_buffer= bufnr(a:name)
    if exists_buffer== -1
        silent! exec spLoc .' '.spSize.spDirc.'new '.  a:name
        cal s:win_setl()
    else
        if !s:get_bufwin(a:name)
            silent! exe spLoc ." ".spSize.spDirc."split +buffer" . exists_buffer
            cal s:win_setl()
        endif
    endif
endfunction "}}}
function! s:get_bufwin(name) "{{{
    """ if buffer exists , go to buffer and return 1
    """ else return 0
    if bufwinnr(bufnr(a:name)) != -1
        exe bufwinnr(bufnr(a:name)) . "wincmd w"
        return 1
    else
        return 0
    endif
endfunction "}}}
function! s:check_win(name) "{{{
    if bufnr('%') != bufnr(a:name)
        return 0
    else
        return 1
    endif
endfunction "}}}
function! galaxy#exit_win() "{{{
    if s:get_bufwin(s:galaxy.name)
        close
    endif
endfunction "}}}

function! s:scheme_in_row(row) "{{{
    let m = split(getline(a:row))
    return {m[0] : m[1:5]}
endfunction "}}}
function! s:name_in_row(row) "{{{
    return split(getline(a:row))[0]
endfunction "}}}
function! s:colors_in_row(row) "{{{
    return split(getline(a:row))[1:5]
endfunction "}}}
function! s:name_in_scheme(scheme) "{{{
    return keys(a:scheme)[0]
endfunction "}}}
function! s:colors_in_scheme(scheme) "{{{
    return values(a:scheme)[0]
endfunction "}}}

function! s:win_opt_set() "{{{
    if !s:check_win(s:galaxy.name) && !s:check_win(s:screen.name)
        return
    endif

    let word = expand('<cWORD>')
    " check if it is whitespace
    if empty(word) || getline('.')[col('.')-1] =~ '\s'
        return
    endif
    let key = split(word,':')[0]
    let mod = 0

    if      key == "GALAXY_SCREEN"
        call s:screen.saver()
    elseif  key == "GALAXY"
        call s:screen.win()
    elseif  key == "Screen"
        call s:screen.win()
    elseif  key == "Saver"
        call s:screen.saver()
    elseif  key == "Load"
        " pass
    elseif  key == "Edit"
        " pass
    elseif  key == "New"
        call s:win_new_scheme_cv()
    elseif  key == "Tips"
        call s:echo_tips()
    elseif  key == "Help"
        h galaxy-quickstart
    endif

    if      key == "STYLE"
        call galaxy#next_style()
        let mod = 1
    elseif  key == "SYNTAX"
        let g:galaxy_colorful_syntax = !g:galaxy_colorful_syntax
        let mod = 1
        call s:retain_cache()
    elseif  key == "STATUSLINE"
        let g:galaxy_statusline_style = g:galaxy_statusline_style == "Right" ? 
            \ "Left"  : g:galaxy_statusline_style=="Left" && g:galaxy_debug==1 ?  
            \ "Test"  : "Right"
        call s:retain_cache()
        let mod = 1
    elseif  key == "INDENT_HL"
        let g:galaxy_enable_indent_hl = !g:galaxy_enable_indent_hl
        echom g:galaxy_enable_indent_hl
        call s:retain_cache()
        let mod = 1
    endif
    if mod == 1
        setl ma
        if s:check_win(s:screen.name)
            call setline('.', " ".s:get_opt_line())
        else
            call setline('.', s:get_opt_line())
        endif
        setl noma
        call galaxy#load("","","s")
    endif
endfunction "}}}
function! s:set_option(opt) "{{{
    let [ui,name,style,syntax,status,indent] = a:opt
    let g:galaxy_colorful_syntax = syntax=="Less" ? 0 : 1
    let g:galaxy_statusline_style = status=="Left" ?
                \"Left"  : status== "Right" ? 
                \"Right" : "Test"
    let g:galaxy_enable_indent_hl = indent=="On" ? 1 : 0
endfunction "}}}
function! s:get_opt_line() "{{{
    let syn    = g:galaxy_colorful_syntax ? "More" : "Less"
    let stat   = g:galaxy_statusline_style
    let indent = g:galaxy_enable_indent_hl ? "On " : "Off"
    let line = "STYLE:". printf("%-7s", s:scheme.style)
            \."      SYNTAX:".syn
            \."   STATUSLINE:".printf("%-5s",g:galaxy_statusline_style)
            \."    INDENT_HL:".indent
    return line
endfunction "}}}
" SCRN {{{1
"============================================================================
let s:screen = {} "{{{
let galaxy#screen = s:screen
let s:screen.name = "GALAXY_SCREEN".g:galaxy.version
"                       b987654321f 
let s:screen_lines = [
\" GALAXY_SCREEN                                           v 2.0.0 ",
\"                                                                 ",
\" SCHEME             BGD    FGD    SYN    MSG    DIF              ",
\" Black              FFFFFF FFFFFF FFFFFF FFFFFF FFFFFF           ",
\"-------------------- GALAXY  GENERATED  COLORS   ----------------",
\"                                                                 ",
\"                                                                 ",
\"                                                                 ",
\"                                                                 ",
\"                                                                 ",
\"                                                                 ",
\"                                                                 ",
\"                                                                 ",
\"                                                                 ",
\"                                                                 ",
\"-----------------------------------------------------------------",
\" STYLE: Default     SYNTAX:Less   STATUSLINE:Left    INDENT_HL:On",
\"-----------------------------------------------------------------",
\"                                                                 ",
\" SYNTAX HIGHLIGHTING GROUP:                                      ",
\"-----------------------------------------------------------------",
\" Constant         Statement       PreProc          Special       ",
\" String           Conditional     Include          SpecialChar   ",
\" Character        Repeat          Define           Tag           ",
\" Number           Label           Macro            Delimiter     ",
\" Boolean          Operator        PreCondit        Debug         ",
\" Float            Keyword                                        ",
\"                  Exception       Type                           ",
\" Identifier                       StorageClass                   ",
\" Function                         Structure                      ",
\"                  Comment         Typedef                        ",
\"                  SpecialComment                                 ",
\"                                                                 ",
\" DEFAULT HIGHLIGHTING GROUP:                                     ",
\"-----------------------------------------------------------------",
\" Cursor           Folded          TabLine          User1         ",
\"                  ColorColumn     TabLineSel       User2         ",
\" CursorIM         FoldColumn      TabLineFill      User3         ",
\" CursorLine       LineNr                           User4         ",
\" CursorColumn     SignColumn      StatusLine       User5         ",
\"                                  StatusLineNC     User6         ",
\" Visual           Wildmenu        VertSplit        User7         ",
\" VisualNOS        Pmenu                            User8         ",
\"                  PmenuSel                         User9         ",
\" Search           PmenuSbar                                      ",
\" IncSearch        PmenuThumb                                     ",
\"                                                                 ",
\" MISC HIGHLIGHTING GROUP  ( * defined by GALAXY )                ",
\"-----------------------------------------------------------------",
\" Normal           ErrorMsg        Conceal          SpellBad      ",
\" Italic     *     WarningMsg      NonText          SpellCap      ",
\" Bold       *     MoreMsg         Ignore           SpellLocal    ",
\" BoldItalic *     ModeMsg                          SpellRare     ",
\" Underlined                       DiffDelete                     ",
\" Undercurl  *     Question        DiffAdd          Error         ",
\" Reverse    *                     DiffChange                     ",
\" Title            MatchParen      DiffText                       ",
\" Todo                                                            ",
\"                                                                 ",
\]
"}}}
function! s:screen.win() dict "{{{
    cal s:new_win(s:screen.name,"top")
    let self.lines= copy(s:screen_lines)
    let lines = self.lines

    let syn = g:galaxy_colorful_syntax == 1 ? "More" : "Less"
    let self.width   = 65
    let self.row_ver = 1
    let self.row_hi  = 4
    let self.row_clr = 6
    let self.row_op  = 17
    let lines[0] = s:line_sub(lines[0],"v ".g:galaxy.version, 58)
    let lines[3] = printf("%-65s", printf(" %-15.15s",s:scheme.name)
                \."   ".join(s:scheme.colors))
    let lines[16] =  " ".s:get_opt_line()
    for i in range(10)
        let lines[6-1+i] = repeat(" ",19).join([s:hbgdclr{i},s:hfgdclr{i}
                    \,s:hsynclr{i},s:hmsgclr{i},s:hdifclr{i}])
    endfor

    setl ma
        call setline(1,lines)
    setl noma

    call self.highlight()
    call self.map()
    "_ resize
endfunction "}}}
function! s:screen.map() dict "{{{
    map <silent><buffer>q   :call galaxy#screen.exit()<CR>
    map <silent><buffer>e   :call galaxy#screen.edit()<CR>
    map <silent><buffer> <CR> :call galaxy#screen.edit()<CR>
    map <silent><buffer> <Kenter> :call galaxy#screen.edit()<CR>
    map <silent><buffer> <Space> :call galaxy#screen.edit()<CR>
    map <silent><buffer> <2-Leftmouse> :call galaxy#screen.edit()<CR>

    nno <silent><buffer> <Tab> W
    nno <silent><buffer> <S-Tab> B
    map <silent><buffer> sv :call galaxy#screen.saver()<CR>

endfunction "}}}
function! s:screen.exit() dict "{{{
    if s:get_bufwin(s:screen.name)
        close
    endif
endfunction "}}}
function! s:screen.rename() "{{{
    let [row,col] = getpos('.')[1:2]
    let line = getline(row)
    let name = split(line)[0]
    
    let new_name = input("Input scheme's new name ( 4~15 char):")
    let new_name = s:valid_name(new_name)
    if new_name is 0
        return
    endif
    
    if has_key(s:f_scheme_dict, name)
        let colors  = deepcopy(s:f_scheme_dict[name])
        cal remove(s:f_scheme_dict, name)
        let note = "Rename scheme '".name."' to '". new_name."'"
    else
        let colors  = deepcopy(s:d_scheme_dict[name])
        let note = "Create scheme '".new_name."' from Builti-in '".name."'"
    endif
    let scheme = {new_name : colors}
    cal extend(s:f_scheme_dict, scheme, "force")
    cal s:save_file_schemes() 
    
    " write buffer
    if s:get_bufwin(self.name)
        setl ma
            call setline(row, s:line_sub(" ".new_name , join(colors), 20))
        setl noma
    endif
    call s:echo(note)
endfunction "}}}
function! s:screen.edit() dict "{{{
    let [row, col] = getpos('.')[1:2]
    let scheme = s:scheme_in_row(self.row_hi)
    let colors = s:colors_in_scheme(scheme)
    let s:edit_scheme = deepcopy(scheme)
    let s:edit_row = row
    "NOTE: for callback
    let s:edit_buf = "scr"
    if row == self.row_hi
        for i in range(5)
            if col <= 16
                call self.rename()
                return
            endif
            if col >= 20+i*7-1 && col <= 25+i*7
                let s:edit_idx = i
                call s:input_cv_call(colors[i],s:hlp_txt[i]
                        \,"galaxy#edit_callback",['g:colorv.HEX'])
                return
            endif
        endfor
    endif
    if row == self.row_op || row == 1
        call s:win_opt_set()
    endif
endfunction "}}}
function! s:screen.highlight() dict "{{{
    " syntax reset

    for line in getline(20,'$')
        for word in split(line)
            if word =~# '\<\u\U\+'
                sil! execute "syn keyword ".word." ".word
            endif
        endfor
    endfor

    call matchadd("Title"          , '\%1l'        , 5)
    call matchadd("WarningMsg"     , '\%3l'        , 10)
    call matchadd("Comment"        , '\%'.self.row_op.'l'       , 4)
    call matchadd("SpecialComment" , '\%'.self.row_op.'l\w*:'   , 15)

    aug galaxy#screen_cursor_move
        au! CursorMoved,CursorMovedI <buffer>  call s:screen.cursor_hi()
    aug END

    call colorv#preview("sNbc")
endfunction "}}}
function! s:screen.cursor_hi() dict "{{{
    let [row,col] = getpos('.')[1:2]
    execute '2match ' "none"
    execute '3match' "none"
    if  row == self.row_hi
        if  col <= 15 && col > 1
            execute '3match' "WarningMsg".' /\%'.(self.row_hi-1)
                    \.'l\%>'.(1) .'c\%<'.(8).'c/'
            execute '2match' "PmenuSel".' /\%'.(self.row_hi)
                    \.'l\%>'.(1) .'c\%<'.(16).'c/'
            return
        endif
        " check if it is whitespace
        if  getline(row)[col-1] =~ '\s'
            return
        endif

        let [a,b] = s:get_cWORD_pos()
        execute '3match' "WarningMsg".' /\%'.(self.row_hi-1)
                \.'l\%>'.(a-1) .'c\%<'.(b+1).'c/'
        execute '2match' "PmenuSel".' /\%'.(self.row_hi)
                \.'l\%>'.(a-1) .'c\%<'.(b+1).'c/'
        return
    endif

    if  row == self.row_op
        " check if it is whitespace
        if  getline(row)[col-1] =~ '\s'
            return
        endif

        let [a,b] = s:get_cWORD_pos()
        execute '3match' 'PmenuSel' '/\%'.(self.row_op).'l'
                    \.'\%>'.(a-1).'c\%<'.(b+1).'c/'
        return

    endif
endfunction "}}}
" SAVR {{{1
"============================================================================
" A little galaxy system.
" Credit me if you use it.
function! s:screen.saver() dict "{{{
    cal s:new_win(s:screen.name)
    call s:screen.clean()

    resize | vert resize
    let width = winwidth(0)
    let height = winheight(0)
    call s:screen.window(width,height)
    call s:echo("Starts...")
    
    let eh = s:event()
    let stars = s:stars()
    let stars.pos = [ width/2, height/2]
    let s:screen.run = 1
    let s:screen.time = localtime()
    while s:screen.run == 1

        call s:screen.clear()
        call s:screen.clock()

        call stars.update()

        call eh.listen()
        call s:screen.update()
        sleep 33m
    endwhile
    call s:screen.re_hi()
endfunction "}}}
" Classes 
function! s:stars() "{{{
    let starsys = {'objs':[]}
    let starsys.center = [10,10]
    let starsys.spd = [0.0,0.0]
    let starsys.pos = [0.0,0.0]
    let starsys.angle = -1.570795
    let starsys.radius = 12
    let starsys.rspd = 0.017453

    let starsys.proj          = s:dparticlesys()
    let starsys.proj.obj.rect = [["0"]]
    let starsys.proj.maxobj   = s:random(40,70)
    let starsys.proj.radius   = s:random(15,50)
    let starsys.proj.fadef    = 0.36
    let starsys.proj.spdf     = 0.04
    let starsys.proj.rndmf    = 3
    let starsys.proj.rndxf    = 7
    let starsys.size          = 3
    let starsys.randobjs      = []
    let starsys.maxrandobj    = 2
    let starsys.maxobj        = 0
    let starsys.tick          = 0
    let starsys.proj.emission_rate  = 1.33

    function! starsys.init() dict "{{{
        for i in range(self.maxobj)
            call self.add()
        endfor
    endfunction "}}}
    function! starsys.add() dict "{{{
        let proj = s:particlesys()
        let c  = s:random(0,0)
        let proj.charn = c
        let proj.obj.rect = [[s:chars{c}[4]]]
        let proj.angle = len(self.objs) * 6.283184 / self.maxobj
        let proj.rotate_spd = s:random(-15,15) / 200.0
        if proj.rotate_spd <= 0.01  && proj.rotate_spd >= -0.01
            let proj.rotate_spd =  0.01
        endif
        let proj.radius  = s:random(17,30) + 0.0
        let proj.fadef = 0.39
        let proj.spdf  = 0.02
        let proj.maxobj = 15
        let proj.spdf  = 0.03
        let proj.rndmf    = 4
        let proj.rndxf    = 7
        call add(self.objs,proj)
    endfunction "}}}
    function! starsys.addrand() dict "{{{
        let randproj = s:particlesys()
        let r = s:random(-40,40)
        let s = s:random(0,1)
        let v = s:random(1,s:screen.width)
        if r <=0 && s == 0
            let x  = [abs(r)+1,1]
            let p  = [v, s:screen.height]
        elseif r<=0 && s == 1
            let x  = [abs(r)+1,s:screen.height]
            let p  = [v, 1]
        elseif r>0 && s == 0
            let x  = [1,r]
            let p  = [s:screen.width, v]
        elseif r>0 && s == 1
            let x  = [s:screen.width,r]
            let p  = [1, v]
        endif
        " let x = [s:screen.width/2,s:screen.height/2]
        let c  = s:random(1,4)
        let randproj.charn = c
        let randproj.obj.rect = [[s:chars{c}[4]]]
        let randproj.life = 10
        let randproj.fadespd = 0.05
        let randproj.rndmf = 7
        let randproj.rndxf = 9
        let randproj.pos = x
        let randproj.spd = [(p[0]-x[0])*0.03,(p[1]-x[1])*0.03] 
        let randproj.maxobj = 40
        let randproj.spdf = 0.04
        let randproj.fadef = 0.13
        let randproj.emission_rate = 0.2
        call add(self.randobjs,randproj)
    endfunction "}}}
    function! starsys.update() dict "{{{

        " let self.angle += self.rspd
        " let self.pos[0] = self.center[0] + self.radius * cos(self.angle)
        " let self.pos[1] = self.center[1] + self.radius * sin(self.angle)

        let self.tick += 1
        if self.tick >= 165 && len(self.randobjs) < self.maxrandobj
            call self.addrand()
            let self.tick = 0
        endif
        for obj in self.randobjs
            let obj.life   -= obj.fadespd
            if obj.life >= 0 
                let obj.pos[0] += obj.spd[0]
                let obj.pos[1] += obj.spd[1]
            else
                if obj.life <= -5
                    call remove(self.randobjs,index(self.randobjs,obj))
                endif
            endif
            cal obj.update()
        endfor

        let self.proj.pos[0] = self.pos[0] - self.size/2
        let self.proj.pos[1] = self.pos[1] - self.size/2
        cal self.proj.update()
        
        for obj in self.objs
            let  obj.angle  += obj.rotate_spd
            let  a           = obj.radius * sin(obj.angle)
            let  b           = obj.radius * cos(obj.angle)
            let  obj.spd[0]  = obj.rotate_spd * a
            let  obj.spd[1]  = obj.rotate_spd * b
            let  obj.pos[0]  = self.pos[0] + b
            let  obj.pos[1]  = self.pos[1] + a
            call obj.update()
        endfor
    endfunction "}}}
    function! starsys.receive_e(e) "{{{
        if      a:e =~? "a" | let self.center[0] -= 0.5
        elseif  a:e =~? "d" | let self.center[0] += 0.5
        elseif  a:e =~? "w" | let self.center[1] -= 0.5
        elseif  a:e =~? "s" | let self.center[1] += 0.5
        endif
    endfunction "}}}
    call starsys.init()
    return starsys
endfunction "}}}
function! s:dparticlesys() "{{{
    let dparticlesys = s:particlesys()
    let dparticlesys.obj   = s:object([["1"]])
    let dparticlesys.radius = 12
    let dparticlesys.emission_rate  = 0.4
    function! dparticlesys.add() dict "{{{
        let par = [0.0,0.0, 0.0,0.0, 9.0,0.0, 0]
        let angle  = ( 0.017453 ) * s:random(0,360)
        let a = self.radius * sin(angle)
        let b = self.radius * cos(angle)
        let par[0] = self.spd[0]/3.0 - b * 0.07
        let par[1] = self.spd[1]/3.0 - a * 0.07
        let par[2] = self.pos[0] + b
        let par[3] = self.pos[1] + a
        let c = s:random(self.rndmf,self.rndxf)
        let par[4] = c
        let par[5] = c / 5.1 * self.fadef
        let par[6] = s:random(0,4)
        call add(self.pars, par)
    endfunction "}}}
    function! dparticlesys.update() dict "{{{
        let self.emit += self.emission_rate
        for i in range(float2nr(self.emit))
            if len(self.pars) < self.maxobj
                call self.add()
            endif
            let self.emit -= 1
        endfor
        
        let self.obj.pos[0] = self.pos[0] - self.size/2
        let self.obj.pos[1] = self.pos[1] - self.size/2
        cal self.obj.update()

        for par in self.pars
            let par[2] += par[0]
            let par[3] += par[1]
            let par[4] -= par[5]
            if par[4] <= 0 
                    \|| par[2] > s:screen.width || par[2] < 0
                    \|| par[3] > s:screen.height || par[3] < 0
                let angle  = ( 0.017453 ) * s:random(0,360)
                let a = self.radius * sin(angle)
                let b = self.radius * cos(angle)
                let par[0] = self.spd[0]/3.0 - b * 0.08
                let par[1] = self.spd[1]/3.0 - a * 0.08
                let par[2] = self.pos[0] + b
                let par[3] = self.pos[1] + a
                let c = s:random(self.rndmf,self.rndxf)
                let par[4] = c
                let par[5] = c / 5.1 * self.fadef
                let par[6] = s:random(0,4)
            endif

            let c = s:chars{par[6]}[float2nr(par[4])]
            call s:screen.plot(float2nr(par[2]),float2nr(par[3]), c)
        endfor

    endfunction "}}}
    call dparticlesys.init()
    return dparticlesys
endfunction "}}}
function! s:particlesys() "{{{
    let particlesys = {}
    let particlesys       = {'pars':[], 'maxobj':30}
    let particlesys.charn = 0
    let particlesys.pos   = [30,30]
    let particlesys.spd   = [0.0,0.0]
    let particlesys.fadef = 0.20
    let particlesys.spdf  = 0.04
    let particlesys.rndmf = 2
    let particlesys.rndxf = 6
    let particlesys.obj   = s:object([["6"]])
    let particlesys.size  = 2
    let particlesys.emission_rate  = 0.01
    let particlesys.emit  = 0
    function! particlesys.init() dict "{{{
        for i in range(1)
            call self.add()
        endfor
    endfunction "}}}
    function! particlesys.add() dict "{{{
        let c = s:random(self.rndmf,self.rndxf)
        let par = [0.0,0.0,0.0,0.0,10.0,0.0,0]
        let par[0] = s:random(-35,35) * self.spdf - self.spd[0]/3.0
        let par[1] = s:random(-35,35) * self.spdf - self.spd[1]/3.0
        let par[2] = self.pos[0]
        let par[3] = self.pos[1]
        let par[4] = c
        let par[5] = c /5.1 * self.fadef
        let par[6] = self.charn
        call add(self.pars, par)
    endfunction "}}}
    function! particlesys.update() dict "{{{
        
        let self.emit +=self.emission_rate
        for i in range(float2nr(self.emit))
            if len(self.pars) < self.maxobj
                call self.add()
            endif
            let self.emit -= 1
        endfor

        let self.obj.pos[0] = self.pos[0] - self.size/2
        let self.obj.pos[1] = self.pos[1] - self.size/2
        cal self.obj.update()

        for par in self.pars
            let par[2] += par[0]
            let par[3] += par[1]
            let par[4] -= par[5]
            if par[4] <= 0 
                    \|| par[2] > s:screen.width || par[2] < 0
                    \|| par[3] > s:screen.height || par[3] < 0
                let par[0] = s:random(-35,35) * self.spdf - self.spd[0]/3.0
                let par[1] = s:random(-35,35) * self.spdf - self.spd[1]/3.0
                let par[2] = self.pos[0]
                let par[3] = self.pos[1]
                let c = s:random(self.rndmf,self.rndxf)
                let par[4] = c
                let par[5] = c /5.1 * self.fadef
            endif

            let c = s:chars{par[6]}[float2nr(par[4])]
            call s:screen.plot(float2nr(par[2]),float2nr(par[3]), c)
        endfor

    endfunction "}}}
    call particlesys.init()
    return particlesys
endfunction "}}}
function! s:object(...) "{{{
    let rect           = a:0 ? a:1 : [["6"]]
    let object         = s:particle()
    unl object.rect
    let object.rect    = rect
    function! object.draw() dict "{{{
        for i in range(len(self.rect))
            for j in range(len(self.rect[i]))
                if self.rect[i][j] != " "
                    call s:screen.plot(float2nr(self.pos[0])+j
                            \,float2nr(self.pos[1])+i
                            \,self.rect[i][j])
                endif
            endfor
        endfor
    endfunction "}}}
    function! object.setrect() "{{{
        let o = self.life
        let self.life -= self.fadespd
        let k = float2nr(o) - float2nr(self.life)
        if k >= 1
            for i in range(len(self.rect))
                for j in range(len(self.rect[i]))
                    let idx = stridx(s:chars{self.charn}, self.rect[i][j])
                    if idx-k >= 0
                        let self.rect[i][j] = s:chars{self.charn}[idx-k]
                    endif
                endfor
            endfor
        endif
    endfunction "}}}
    return object
endfunction "}}}
function! s:particle(...) "{{{
    let rect             = a:0 ? a:1 : "6"
    let particle         = {}
    let particle.pos     = [1.0,1.0]
    let particle.rect    = rect
    let particle.spd     = [0.0,0.0]
    let particle.maxspd  = 2
    let particle.fadespd = 0.0
    let particle.life    = 10.0
    let particle.size    = 1
    let particle.charn   = 0
    function! particle.setrect() "{{{
        let self.life -= self.fadespd
        let self.rect = s:chars{self.charn}[float2nr(self.life)]
    endfunction "}}}
    function! particle.draw() "{{{
        call s:screen.plot(float2nr(self.pos[0])
                \,float2nr(self.pos[1]), self.rect)
    endfunction "}}}
    function! particle.update() dict "{{{
        if self.life <= 0
            return
        endif
        call self.setrect()

        let self.pos = [self.pos[0]+self.spd[0] , 
                \self.pos[1] + self.spd[1] ]
        if self.pos[0] >= s:screen.width || self.pos[0] <= 0
            let self.spd[0] = -self.spd[0]/1.8
        endif
        if self.pos[1] >= s:screen.height || self.pos[1] <= 0
            let self.spd[1] = -self.spd[1]/1.8
        endif
        call self.draw()
    endfunction "}}}
    return particle
endfunction "}}}
function! s:event() "{{{
    let event = {'receiver':[]}
    function! event.register(obj) "{{{
        call add(self.receiver, a:obj)
    endfunction "}}}
    function! event.listen() "{{{
        let c = getchar(0) 
        if c != 0
            let e = nr2char(c)
            if e == "\<ESC>" || e == "q"
                let s:screen.run = 0
            elseif e =~? '[H?]' || e == "\<CR>" || e == "\<Space>"
                call s:echo("Press '<ESC>/q' to stop")
            endif
            for obj in self.receiver
                call obj.receive_e(e)
            endfor
        endif
    endfunction "}}}
    return event
endfunction "}}}

let s:chars0 = "0123456789"
let s:chars1 = "abcdefghij"
let s:chars2 = "klmnopqrst"
let s:chars3 = "uvwxyzABCD"
let s:chars4 = "EFGHIJKLMN"
function! s:screen.hi_sav() "{{{

    for i in range(10)
        call s:hi_list([['Galaxy'.0.i, s:hbgdclr{i},s:hbgdclr{i},'n']])
        exec "syn match Galaxy".0.i.' /'. s:chars0[i] .'/'
    endfor

    let hex0 = s:bgdclr0
    let h  = s:random(0,360)
    for c in range(1,4)
        let hex1 = s:hmsgclr{c*2}
        let hexlist = colorv#list_gen2(hex0,hex1)
        for i in range(10)
            call s:hi_list([['Galaxy'.c.i, hexlist[i],hexlist[i],'n']])
            exec "syn match Galaxy".c.i.' /'. s:chars{c}[i] .'/'
        endfor
    endfor

   hi! link Cursor Galaxy00
   call matchadd("DiffDelete" , '\%'.self.height.'l\D')
   call matchadd("Todo" , '\%'.self.height.'l\d')
endfunction "}}}
function! s:screen.update() dict "{{{
        setl ma lz
        for i in range(len(self.lines))
            if getline(i+1) != self.lines[i]
                call setline(i+1, self.lines[i])
            endif
        endfor
        setl noma nolz
        redraw
endfunction "}}}
function! s:screen.plot(x,y,c) dict "{{{
    " let x = a:x>=self.width  ? self.width  : a:x<=1 ? 1 : a:x
    " let y = a:y>=self.height ? self.height : a:y<=1 ? 1 : a:y
    let [x,y] = [a:x,a:y]
    if x > self.width || x < 1 || y > self.height || y < 1
        return
    endif
    let line = self.lines[y-1]
    " "NOTE: idx = x-1 ; 
    " "  join is 20% faster than substitute. but a bit slow with a condition
    " if x == 1
    "     let self.lines[y-1] = a:c . line[ x :]
    " else
    "     let self.lines[y-1] = line[: x-2 ] . a:c . line[ x :]
    " endif
    let self.lines[y-1] = substitute(line,'\%'.x.'c.',a:c,'')
endfunction "}}}
function! s:screen.window(width,height) dict "{{{
    let win = []
    for i in range(a:height)
        call add(win, repeat(" ", a:width))
    endfor
    let self.lines = win
    let self.height = a:height
    let self.width  = a:width
    call s:screen.hi_sav()
endfunction "}}}
function! s:screen.clock() "{{{
    let time = localtime()
    let self.lines[self.height-1] = printf("%".self.width."s"
                \,"A little galaxy: "
                \. (time - s:screen.time) . " seconds.")
endfunction "}}}
function! s:screen.nomap() "{{{
    sil! unmap <buffer> e
    sil! unmap <buffer> <CR>
    sil! unmap <buffer> <Space>
    sil! unmap <buffer> <Kenter>
    sil! unmap <buffer> <2-Leftmouse>
    map <silent><buffer>q   :call galaxy#screen.exit()<CR>
endfunction "}}}
function! s:screen.re_hi() "{{{
   call clearmatches()
   hi! link Cursor CursorS
endfunction "}}}
function! s:screen.clear() "{{{
    for i in range(len(self.lines))
        let self.lines[i] = repeat(" ",len(self.lines[0]))
    endfor
endfunction "}}}
function! s:screen.clean() "{{{
    if s:check_win(s:screen.name)
        setl ma
            %d_
        setl noma
    endif
    call s:screen.nohi()
    call s:screen.nomap()
endfunction "}}}
function! s:screen.nohi() "{{{
    match none
    2match none
    3match none
    call clearmatches()
    aug galaxy#screen_cursor_move
        au!
    aug END
endfunction "}}}
function! s:screen.line(p1,p2,c) dict "{{{
    let [x1,y1] = a:p1
    let [x2,y2] = a:p2
    let dx = x2 - x1
    let dy = y2 - y1
    let err = 0
    if dx == 0 
        if dy > 0   | let s = 1
        else        | let s = -1
        endif
        for i in range(y1,y2, s)
            call s:screen.plot(x1,y1+i,a:c)
        endfor
    else
        let delta = abs((dy+0.0)/dx)
        if dx > 0   | let s = 1
        else        | let s = -1
        endif
        let y = y1
        for i in range(x1,x2,s)
            call s:screen.plot(i,y,a:c)
            let err = err + delta
            if err >= 0.5
                let y += 1
                let err -= 1.0
            endif
        endfor
    endif
    
endfunction "}}}
" HELP "{{{1
"======================================================================
let s:seed = localtime() * (localtime() + 10) * 2012
function! s:random(num,...) "{{{
    if a:0 
        let min = a:num
        let max = a:1
    else
        let min = 0
        let max = a:num
    endif
    let s:seed = s:fmod((1097*s:seed+2713),10457)
    return float2nr(s:fmod(abs(s:seed),max-min+1) + min)
endfunction "}}}
function! s:echo(msg) "{{{
    redraw
    exe "echom \"[Galaxy] ".escape(a:msg,'"')."\""
endfunction "}}}
function! s:caution(msg) "{{{
    redraw
    echohl Modemsg
    exe "echom \"[Galaxy] ".escape(a:msg,'"')."\""
    echohl Normal
endfunction "}}}
function! s:warning(msg) "{{{
    redraw
    echohl Warningmsg
    exe "echo \"[Galaxy] ".escape(a:msg,'"')."\""
    echohl Normal
endfunction "}}}
function! s:error(msg) "{{{
    redraw
    echohl Errormsg
    redraw
    echom "[Galaxy] ".escape(a:msg,'"')." "
    echohl Normal
endfunction "}}}
function! s:debug(msg) "{{{
    if g:galaxy_debug!=1
        return
    endif
    redraw
    echohl Errormsg
    echom "[Galaxy] ".escape(a:msg,'"')
    echohl Normal
endfunction "}}}

function! s:get_cword_pos() "{{{
    let word = expand('<cword>')
    let len = len(word)
    let f = match(getline('.'), word , col('.')-len )
    if f == -1
        call s:debug("get_cword could not find correct position")
        return [1,1]
    else
        return [f+1, f+len]
    endif
endfunction "}}}
function! s:get_cWORD_pos() "{{{
    let word = expand('<cWORD>')
    let len = len(word)
    let f = match(getline('.'), word , col('.')-len )
    if f == -1
        call s:debug("get_cword could not find correct position")
        return [1,1]
    else
        return [f+1, f+len]
    endif

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
function! s:check_win(name) "{{{
    if bufnr('%') != bufnr(a:name)
        return 0
    else
        return 1
    endif
endfunction "}}}
function! s:clear_text() "{{{
    if !s:check_win(s:galaxy.name)
        call s:warning("Not [GALAXY] buffer")
        return
    else
        let cur=getpos('.')
        " silent! normal! ggVG"_x
        silent %delete _
        return cur
    endif
endfunction "}}}
function! s:echo_tips() "{{{
    for idx in range(len(s:tips_list))
        if s:fmod(s:seq_num,len(s:tips_list)) == idx
            call s:echo("[".idx."]".s:tips_list[idx])
            let s:seq_num += 1
            return
        endif
    endfor
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
    let x = type(a:x)==type("") ? str2float(a:x) : a:x+0.0
    return x
endfunction "}}}
" LOAD "{{{1
"======================================================================
function! s:get_upd_schemes_dict() "{{{
    cal s:load_default_schemes()
    cal s:load_file_schemes()

    let s:A_scheme_dict = deepcopy(s:d_scheme_dict)
    cal extend(s:A_scheme_dict, s:f_scheme_dict,"keep")
    return s:A_scheme_dict
endfunction "}}}
function! s:load_default_schemes() "{{{
    let s:d_scheme_dict = {}
    let scheme_list=deepcopy(s:default_schemes)
    let scheme = {}
    for items in scheme_list
        let scheme[items[0]] = items[1:5]
        cal extend(s:d_scheme_dict, scheme,"keep")
    endfor
endfunction "}}}
function! s:load_file_schemes() "{{{
    let s:f_scheme_dict = {}
    let file = expand(g:galaxy_scheme_file)
    if !filereadable(file)
        return
    endif
    let list = readfile(file)
    let scheme ={}
    for line in list
        let m = split(line)
        if len(m) != 6
            call s:debug("Not a valid line :".line)
            continue
        else
            " let scheme.name = m[0]
            " let scheme.colors = m[1:5]
            let scheme[m[0]] = m[1:5]
            cal extend(s:f_scheme_dict, scheme)
        endif
    endfor
endfunction "}}}
function! s:save_file_schemes() "{{{
    let schemes = s:f_scheme_dict
    let file = expand(g:galaxy_scheme_file)

    let lines = []
    for [name, colors] in items(s:f_scheme_dict)
        let lines += [printf("%-15.15s", name)."    ".join(colors)]
    endfor

    try
        call writefile(lines, file)
    catch /^Vim\%((\a\+)\)\=:E/
        call s:error("Could not write scheme files. ".v:exception)
    endtry
endfunction "}}}

function! s:retain_cache() "{{{
    " less hardware IO
    let name = s:scheme.name
    let style = s:scheme.style
    let syntax = g:galaxy_colorful_syntax ? "More" : "Less"
    let status = g:galaxy_statusline_style
    let indent = g:galaxy_enable_indent_hl ? "On" : "Off"
    if s:mode=="cterm"
        let s:_cache_term = ["TEM_OPT",name, style,syntax,status,indent ]
    else
        let s:_cache_gui  = ["GUI_OPT",name, style,syntax,status,indent ]
    endif
endfunction "}}}
function! s:take_cache() "{{{
    if exists("s:_cache_term") 
        return s:_cache_term
    elseif exists("s:_cache_gui")
        return s:_cache_gui
    else
        return galaxy#load_cache()
    endif
endfunction "}}}
function! galaxy#load_cache() "{{{
    let file = expand(g:galaxy_cache_file)

    try
        let lines = readfile(file)
        for line in lines
            if line =~ 'TEM_OPT'
                let cache = split(line)
                if len(cache) == 6
                    let s:cache_term = cache
                endif
            endif
            if line =~ 'GUI_OPT'
                let cache = split(line)
                if len(cache) == 6
                    let s:cache_gui = cache
                endif
            endif
        endfor
    catch /^Vim\%((\a\+)\)\=:E/
        call s:debug("Could not load cache. ".v:exception)
    endtry

    if s:mode=="cterm"
        return s:cache_term
    else
        return s:cache_gui
    endif
endfunction "}}}
function! galaxy#save_cache() "{{{
    let name = s:scheme.name
    let style = s:scheme.style
    let syntax = g:galaxy_colorful_syntax ? "More" : "Less"
    let status = g:galaxy_statusline_style
    let indent = g:galaxy_enable_indent_hl ? "On " : "Off"
    let file = expand(g:galaxy_cache_file)

    if s:mode=="cterm"
        let s:cache_term = ["TEM_OPT",name, style,syntax,status,indent ]
    else
        let s:cache_gui  = ["GUI_OPT",name, style,syntax,status,indent ]
    endif
    let lines = [join(s:cache_term,"\t") , join(s:cache_gui,"\t")]
    try
        call writefile(lines, file)
    catch /^Vim\%((\a\+)\)\=:E/
        call s:error("Could not caching-scheme. ".v:exception)
        return -1
    endtry
endfunction "}}}
" MAIN "{{{1
"======================================================================
function! s:get_scheme(name, style) "{{{
    let scheme_dict  = s:get_upd_schemes_dict()
    let scheme = {}

    if has_key(scheme_dict, a:name)
        let scheme.name = a:name
        let scheme.colors = scheme_dict[a:name]
    else
        let scheme.name = s:default_schemes[0][0]
        let scheme.colors = scheme_dict[scheme.name]
    endif
    if has_key(s:hl_styles, a:style)
        let scheme.style = a:style
    else
        let scheme.style = keys(s:hl_styles)[0]
    endif

    return scheme
endfunction "}}}
function! s:load(...) "{{{
    let cache = s:take_cache()
    let name  = (a:0 && a:1 !~ '^\s*$') ? a:1 : cache[1]
    let style = (a:0>1 && a:2 !~ '^\s*$') ? a:2 : cache[2]
    call s:set_option(cache)
    let scheme = s:get_scheme(name,style)
    let s:scheme = scheme

    call s:debug("load:".string(cache)." ".string(scheme))
    
    " get lumination and set background
    let [y,i,q] = colorv#hex2yiq(scheme.colors[0])
    if y <= 40  | let s:bgy="dark"
    else        | let s:bgy="light"
    endif

    call s:set_background()

    "generate base colors:bgd/fgd/syn/msg/dif
    call s:gen_base_colors(scheme.colors)

    if s:mode=="cterm" && &t_Co <=16
        if &t_Co == 16
            if s:bgy == "dark"
                call s:set_dark16_var()
                let s:scheme.Tstyle = "Dark16"
            else
                call s:set_light16_var()
                let s:scheme.Tstyle = "Light16"
            endif
        else
            if s:bgy == "dark"
                call s:set_dark8_var()
                let s:scheme.Tstyle = "Dark8"
            else
                call s:set_light8_var()
                let s:scheme.Tstyle = "Light8"
            endif
        endif
        call s:hi_list(s:term_hl)
    else
        " predefined highlights
        call s:hi_list(s:default_hl)
        if g:galaxy_colorful_syntax == 1
            call s:hi_list(s:syn_hl_1)
        else
            call s:hi_list(s:syn_hl_0)
        endif
        " predefined scheme style highlights
        cal s:hi_list(s:hl_styles[scheme.style])
        if g:galaxy_visual_hl_fg == 1
            call s:hi_list([["Visual",   "bgdclr1",  "bgdclr9",  "n"     ],
                        \["VisualNOS",   "bgdclr2",  "bgdclr8",  "n"     ]])
        endif
    endif
    
    " predefined filetype syntax highlights
    if g:galaxy_load_syn_dict==1
        for list in values(s:synlink_dict) + values(s:syn_hi_gui_dict)
            call s:hi_list(list)
        endfor
    endif
    if g:galaxy_load_syn_tuning==1
        call s:syntax_tuning()
    endif
    

    if g:galaxy_enable_statusline == 1
        " StatusLine
        call s:statusline_aug()
    endif
    
    " Indent Highlight
    if g:galaxy_enable_indent_hl == 1
        call s:indent_hl_aug()
    endif

    " restore cursor in term
    if s:mode=="cterm"
        call s:term_cursor()
    endif
    
    let g:colors_name = "galaxy"
    let g:galaxy.scheme = s:scheme

    call s:retain_cache()
    " silent start
    if a:0>2 && a:3=="s"
        "pass
    else
        call s:echo( "Scheme:[".s:scheme.name."] Loaded. "
            \."Style:[".s:scheme.style."].")
    endif

endfunction "}}}

function! galaxy#load(...) "{{{
    let name = a:0 ? a:1 : ""
    let style = a:0>1 ? a:2 : ""
    let option = a:0>2 ? a:3 : ""
    call s:load(name,style,option)
endfunction "}}}
function! galaxy#next_style() "{{{
    let k = keys(s:hl_styles)
    let l = k +  [k[0]]
    let i = index(l, s:scheme.style)
    call galaxy#load("",l[i+1],"s")
endfunction "}}}
function! galaxy#init() "{{{
    call galaxy#load("","","s")

    aug galaxy#cache
        au! VIMLEAVEPre * call galaxy#save_cache()
    aug END
endfunction "}}}
"}}}1
let &cpo = s:save_cpo
unlet s:save_cpo
" vim:tw=78:fdm=marker:
