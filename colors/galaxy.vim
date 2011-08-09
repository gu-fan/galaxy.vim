" Description:	Galaxy, A colour scheme generate system
" Author:	Rykka.Krin <Rykka.krin@gmail.com>
"=============================================================

"  GALAXY PRECHECKING "{{{
"=============================================================
if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif


" XXX: there is no g:ColorV while loading colorscheme 
" if !exists("g:ColorV_loaded")
"     echoe "Galaxy depends on ColorV.vim. Please install it first"
"     finish
" endif
"}}}
" FORMTATOR PREDEF "{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let s:gui             = "gui"
" let s:term            = "term"
" let s:cterm           = "cterm"
let s:nocolor         = "NONE"
" let s:nulldef         = ""
let s:n               = "NONE"
let s:c               = ",undercurl"
let s:r               = ",reverse"
let s:s               = ",standout"
let s:b               = ",bold"
let s:u               = ",underline"
let s:i               = ",italic"
if has("gui_running")
    let s:mode="gui"
else
    let s:mode="cterm"
endif
"}}}
" VARIABLE PREDEF "{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:galaxy_cache_File = expand('$HOME') . '/.vim_galaxy_cache'
if has("win32") || has("win64") "{{{
    if exists('$HOME')
        let g:galaxy_store_Folder = expand('$HOME') . 'vimfiles/colors/galaxy/'
    else
        let g:galaxy_store_Folder = expand('$VIM') . 'vimfiles/colors/galaxy/'
    endif
else
    let g:galaxy_store_Folder = expand('$HOME') . '/.vim/colors/galaxy/'
endif "}}}

let g:galaxy_term_check=0
let g:galaxy_term_color=0
" DONE: 110808  pcterm/xterm/cygwin... support
"  XXX:Don't know how to get these Terminal's color actual support
if !has("gui_running") && g:galaxy_term_check == "1" "{{{
    if &term == "win32" 
        \ || &term =="ansi" 
        \ || &term =="os2ansi" || &term=="vt52"
        set t_Co=16
    elseif &term=="linux" || &term == "pcterm" 
        set t_Co=8
    else
    	set t_Co=256
    endif
elseif !has("gui_running") && g:galaxy_term_color > 0
    let &t_Co=g:galaxy_term_color
endif "}}}

let g:galaxy={}
let g:galaxy.name="[GALAXY]"
let g:galaxy.version="1.0.1"
let g:galaxy.win_pos="bot"
let s:clr_txt=[
            \"Foreground Color(Normal Foreground)",
            \"Syntax Color(Vars,Functions,...)",
            \"Echo Color(ErrorMsg,ModeMsg,...)",
            \"Background(Normal Background)",
            \"Diff(DiffAdd,DiffChange,... Background)"]
" s:built_in_schemes "{{{
let s:built_in_schemes=[
            \{"name":"Paper_And_Pen",
            \"colors":["3B3C40","3F5D73","7F1C1C","CACCC2","CC9085"],
            \},
            \{"name":"Ubuntu",
            \"colors":["99918A","A6573A","BF2A2A","2E1722","384766"]},
            \{"name":"Bsm_simple",
            \"colors":["979799","637EA6","A62424","2D2D2D","263B40"]},
            \{"name":"Spring",
            \"colors":["575759","31568C","7F1C1C","CBE5A1","66CCC2"]},
            \{"name":"SlateGray",
            \"colors":["8F8FA6","5BA65E","A62424","475059","57D9CA"]},
            \{"name":"Darker",
            \"colors":["7E7E7F","4268A6","A62424","191919","1E444D"]},
            \{"name":"Butterscream",
            \"colors":["3D4E66","547799","992222","FFFFD9","D9C8B8"]},
            \{"name":"Village",
            \"colors":["402020","2E4873","437317","BAE5AC","F2D530"],
            \"style":"COLOUR"},
            \{"name":"SkyBlue",
            \"colors":["333317","7F4654","990808","B6F2F2","E58ADE"],
            \},
            \]
"}}}
"{{{s:style_hllist
let s:style_hllist=
\[
    \{"name":"SHADOW",
    \"highlights":[
        \]
    \},
    \{"name":"COLOUR",
    \"highlights":[
        \["Wildmenu",       "bgrhue2",  "fgdclr2",  "b"     ],
        \["Pmenu",          "bgdclr0",  "fgdclr2",  "n"     ],
        \["PmenuSel",       "fgdclr2",  "bgrhue0",  "rb"    ],
        \["PmenuSbar",      "bgdclr1",  "fgdclr0",  "n"     ],
        \["PmenuThumb",     "bgdclr2",  "fgdclr0",  "n"     ],
        \["Folded",         "bgdclr0",  "bgdclr3",  "n"     ],
        \["tabline",        "bgdclr2",  "bgdclr6",  "n"     ],
        \["tablinesel",     'difclr0',  "fgdclr2",  "b"     ],
        \["tablinefill",    "fgdclr2",  "bgdclr3",  "n"     ],
        \["StatusLine",     "bgrhue0",  "fgdclr2",  "b"     ],
        \["StatusLineNC",   "bgdclr2",  "fgdclr2",  "n"     ],
        \["User1",          "bgrhue1",  "fgdclr2",  "b"     ],
        \["User2",          "bgrhue2",  "fgdclr2",  "b"     ],
        \["User3",          "bgrhue3",  "fgdclr2",  "b"     ],
        \["User4",          "bgrhue4",  "fgdclr2",  "b"     ],
        \["User5",          "bgrhue5",  "fgdclr2",  "b"     ],
        \["User6",          "bgrhue6",  "fgdclr2",  "b"     ],
        \["User7",          "bgrhue7",  "fgdclr2",  "b"     ],
        \["User8",          "bgrhue8",  "fgdclr2",  "b"     ],
        \["User9",          "bgrhue9",  "fgdclr2",  "b"     ],
        \["MoreMsg",        "echclr5",  "nocolor",  "b"     ],
        \["Question",       "echclr4",  "nocolor",  "b"     ],
        \["ModeMsg",        "echclr3",  "nocolor",  "b"     ],
        \["MatchParen",     "echclr2",  "nocolor",  "br"    ],
        \["WarningMsg",     "echclr1",  "nocolor",  "br"    ],
        \["ErrorMsg",       "echclr0",  "nocolor",  "br"    ],
        \["Error",          "echclr0",  "nocolor",  "br"    ],
        \["Todo",           "echclr2",  "nocolor",  "br"    ],
        \["Title",          "echclr2",  "nocolor",  "b"     ],
        \]  
    \}
\] 
"}}}
"{{{ default hl lists
"gui "{{{
let s:default_hl_list=[
            \["Normal",         "fgdclr0",  "bgdclr0",  "n"     ],
            \["Cursor",         "fgdclr0",  "bgdclr0",  "r"     ],
            \["CursorLine",     "nocolor",  "bgdclr1",  "n"     ],
            \["CursorColumn",   "CursorLine"    ],
            \["Visual",         "nocolor",  "bgrhue0",  "n"     ],
            \["VisualNOS",      "nocolor",  "bgrhue2",  "n"     ],
            \["Search",         "nocolor",  "nocolor",  "u"     ],
            \["IncSearch",      "nocolor",  "echclr2",  "b"     ],
            \["Wildmenu",       "echclr1",  "bgdclr2",  "b"     ],
            \["Pmenu",          "fgdclr1",  "bgdclr1",  "n"     ],
            \["PmenuSel",       "fgdclr0",  "bgdclr0",  "rb"    ],
            \["PmenuSbar",      "fgdclr1",  "bgdclr1",  "n"     ],
            \["PmenuThumb",     "bgdclr0",  "bgdclr2",  "n"     ],
            \["DiffAdd",        "nocolor",  "difclr2",  "n"     ],
            \["DiffChange",     "nocolor",  "difclr1",  "n"     ],
            \["DiffDelete",     "bgdclr4",  "difclr0",  "n"     ],
            \["DiffText",       "nocolor",  "difclr0",  "n"     ],
            \["Folded",         "fgdclr1",  "bgdclr1",  "n"     ],
            \["FoldColumn",     "Folded"        ],
            \["LineNr",         "Folded"        ],
            \["SignColumn",     "Folded"        ],
            \["ColorColumn",    "Folded"        ],
            \["tabline",        "bgdclr0",  "bgdclr3",  "n"     ],
            \["tablinesel",     'synclr0',  "bgdclr0",  "b"     ],
            \["tablinefill",    "bgdclr0",  "bgdclr2",  "n"     ],
            \["StatusLine",     "synclr0",  "bgdclr3",  "b"     ],
            \["StatusLineNC",   "bgdclr0",  "bgdclr3",  "n"     ],
            \["VertSplit",      "StatusLineNC"  ],
            \["User1",          "echclr0",  "bgdclr3",  "b"     ],
            \["User2",          "echclr1",  "bgdclr3",  "b"     ],
            \["User3",          "echclr2",  "bgdclr3",  "b"     ],
            \["User4",          "echclr3",  "bgdclr3",  "b"     ],
            \["User5",          "echclr4",  "bgdclr3",  "b"     ],
            \["User6",          "echclr5",  "bgdclr3",  "b"     ],
            \["User7",          "echclr6",  "bgdclr3",  "b"     ],
            \["User8",          "echclr7",  "bgdclr3",  "b"     ],
            \["User9",          "echclr8",  "bgdclr3",  "b"     ],
            \["MoreMsg",        "echclr5",  "nocolor",  "b"     ],
            \["Question",       "echclr4",  "nocolor",  "b"     ],
            \["ModeMsg",        "echclr3",  "nocolor",  "b"     ],
            \["MatchParen",     "echclr2",  "nocolor",  "br"    ],
            \["WarningMsg",     "echclr1",  "nocolor",  "br"    ],
            \["SpellLocal",     "WarningMsg"    ],
            \["SpellRare",      "WarningMsg"    ],
            \["ErrorMsg",       "echclr0",  "nocolor",  "br"    ],
            \["SpellBad",       "ErrorMsg"      ],
            \["SpellCap",       "ErrorMsg"      ],
            \["Error",          "echclr0",  "nocolor",  "br"    ],
            \["Todo",           "echclr1",  "nocolor",  "br"    ],
            \["Title",          "fgdclr0",  "nocolor",  "b"     ],
            \["Conceal",        "fgdclr1",  "nocolor",  "n"     ],
            \["Comment",        "bgdclr3",  "nocolor",  "n"     ],
            \["NonText",        "Comment"       ],
            \["Ignore",         "Comment"       ],
            \["SpecialComment", "bgdclr4",  "nocolor",  "b"     ],
            \["Underlined",     "synclr0",  "nocolor",  "u"     ],
            \["Keyword",        "synclr0",  "nocolor",  "b"     ],
            \["Statement",      "synclr0",  "nocolor",  "n"     ],
            \["Conditional",    "Statement"     ],
            \["Operator",       "Statement"     ],
            \["Repeat",         "Statement"     ],
            \["Exception",      "synclr1",  "nocolor",  "bi"    ],
            \["PreCondit",      "Exception"     ],
            \["Debug",          "Exception"     ],
            \["SpecialChar",    "synclr1",  "nocolor",  "b"     ],
            \["SpecialKey",     "SpecialChar"   ],
            \["Tag",            "SpecialChar"   ],
            \["PreProc",        "synclr1",  "nocolor",  "b"     ],
            \["Define",         "PreProc"       ],
            \["Macro",          "PreProc"       ],
            \["Include",        "PreProc"       ],
            \["Special",        "synclr1",  "nocolor",  "n"     ],
            \["Delimiter",      "Special"       ],
            \["Type",           "synclr2",  "nocolor",  "n"     ],
            \["Directory",      "Type"          ],
            \["Structure",      "Type"          ],
            \["Identifier",     "synclr2",  "nocolor",  "b"     ],
            \["StorageClass",   "Identifier"    ],
            \["Constant",       "synclr3",  "nocolor",  "n"     ],
            \["Boolean",        "Constant"      ],
            \["Float",          "Constant"      ],
            \["Number",         "Constant"      ],
            \["Function",       "synclr4",  "nocolor",  "b"     ],
            \["String",         "synclr4",  "nocolor",  "n"     ],
            \["Character",      "String"        ],
            \["Label",          "synclr4",  "nocolor",  "b"     ],
            \] 
"}}}
"term16 "{{{
let s:term16_hl_list=[
            \["Normal",         "Black",  "LightGray",  "n"     ],
            \["Cursor",         "Black",  "LightGray",  "r"     ],
            \["CursorLine",     "nocolor",  "DarkGray",  "n"     ],
            \["Visual",         "nocolor",  "Green",  "n"     ],
            \["VisualNOS",      "nocolor",  "Green",  "n"     ],
            \["Search",         "Yellow",  "DarkGray",  "u"     ],
            \["IncSearch",      "nocolor",  "Yellow",  "b"     ],
            \["Wildmenu",       "Yellow",  "Black",  "r"     ],
            \["Pmenu",          "Black",  "DarkGray",  "n"     ],
            \["PmenuSel",       "Black",  "DarkGray",  "rb"    ],
            \["PmenuSbar",      "Black",  "DarkGray",  "n"     ],
            \["PmenuThumb",     "Black",  "DarkGray",  "n"     ],
            \["DiffAdd",        "nocolor",  "DarkGreen",  "n"     ],
            \["DiffChange",     "nocolor",  "DarkBlue",  "n"     ],
            \["DiffDelete",     "DarkGray",  "DarkRed",  "n"     ],
            \["DiffText",       "nocolor",  "DarkRed",  "n"     ],
            \["Folded",         "LightGray",  "DarkGray",  "n"     ],
            \["tabline",        "DarkGray",  "Black",  "n"     ],
            \["tablinesel",     'Blue',  "LightGray",  "b"     ],
            \["tablinefill",    "DarkGray",  "Black",  "n"     ],
            \["StatusLine",     "Yellow",  "Black",  "b"     ],
            \["StatusLineNC",   "DarkGray",  "Black",  "n"     ],
            \["User1",          "Red",  "Black",  "b"     ],
            \["User2",          "Magenta",  "Black",  "b"     ],
            \["User3",          "Cyan",  "Black",  "b"     ],
            \["User4",          "Green",  "Black",  "b"     ],
            \["User5",          "Blue",  "Black",  "b"     ],
            \["User6",          "Yellow",  "Black",  "b"     ],
            \["User7",          "DarkRed",  "Black",  "b"     ],
            \["User8",          "DarkMagenta",  "Black",  "b"     ],
            \["User9",          "DarkCyan",  "Black",  "b"     ],
            \["MoreMsg",        "Cyan",  "LightGray",  "b"     ],
            \["Question",       "Magenta",  "LightGray",  "b"     ],
            \["ModeMsg",        "Green",  "LightGray",  "b"     ],
            \["MatchParen",     "DarkGray",  "Green",  "b"    ],
            \["WarningMsg",     "DarkGray",  "Yellow",  "b"    ],
            \["ErrorMsg",       "Black",  "Red",  "b"    ],
            \["Error",          "Black",  "Red",  "b"    ],
            \["Todo",           "Black",  "Yellow",  "b"    ],
            \["Title",          "Yellow",  "bg",  "b"     ],
            \["Conceal",        "White",  "bg",  "n"     ],
            \["Comment",        "DarkGray",  "bg",  "n"     ],
            \["SpecialComment", "DarkCyan",  "bg",  "b"     ],
            \["Underlined",     "DarkBlue",  "bg",  "bu"     ],
            \["Keyword",        "Blue",  "bg",  "b"     ],
            \["Statement",      "DarkBlue",  "bg",  "n"     ],
            \["Exception",      "Magenta",  "bg",  "bi"    ],
            \["SpecialChar",    "Magenta",  "bg",  "b"     ],
            \["PreProc",        "Magenta",  "bg",  "b"     ],
            \["Special",        "DarkMagenta",  "bg",  "n"     ],
            \["Type",           "DarkYellow",  "bg",  "n"     ],
            \["Identifier",     "Yellow",  "bg",  "b"     ],
            \["Constant",       "DarkYellow",  "bg",  "n"     ],
            \["Function",       "Green",  "bg",  "b"     ],
            \["String",         "DarkGreen",  "bg",  "n"     ],
            \["Label",          "Green",  "bg",  "b"     ],
            \] 
"}}}
""{{{dark16
let s:term16_dark_hl_list=[
            \["Normal",         "LightGray",  "Black",  "n"     ],
            \["Cursor",         "LightGray",  "bg",  "r"     ],
            \["CursorLine",     "nocolor",  "DarkGray",  "n"     ],
            \["Visual",         "nocolor",  "Green",  "n"     ],
            \["VisualNOS",      "nocolor",  "Green",  "n"     ],
            \["Search",         "Yellow",  "Black",  "u"     ],
            \["IncSearch",      "nocolor",  "Yellow",  "b"     ],
            \["Wildmenu",       "Blue",  "DarkGray",  "r"     ],
            \["Pmenu",          "Black",  "DarkGray",  "n"     ],
            \["PmenuSel",       "DarkGray",  "Yellow",  "rb"    ],
            \["PmenuSbar",      "Black",  "DarkGray",  "n"     ],
            \["PmenuThumb",     "Black",  "DarkGray",  "n"     ],
            \["DiffAdd",        "nocolor",  "DarkGreen",  "n"     ],
            \["DiffChange",     "nocolor",  "DarkBlue",  "n"     ],
            \["DiffDelete",     "DarkGray",  "DarkRed",  "n"     ],
            \["DiffText",       "nocolor",  "DarkRed",  "n"     ],
            \["Folded",         "LightGray",  "DarkGray",  "n"     ],
            \["tabline",        "Black",  "DarkGray",  "n"     ],
            \["tablinesel",     'Yellow',  "Black",  "b"     ],
            \["tablinefill",    "DarkGray",  "DarkGray",  "n"     ],
            \["StatusLine",     "Yellow",  "DarkGray",  "b"     ],
            \["StatusLineNC",   "Black",  "DarkGray",  "n"     ],
            \["User1",          "Red",  "DarkGray",  "b"     ],
            \["User2",          "Magenta",  "DarkGray",  "b"     ],
            \["User3",          "Cyan",  "DarkGray",  "b"     ],
            \["User4",          "Green",  "DarkGray",  "b"     ],
            \["User5",          "Blue",  "DarkGray",  "b"     ],
            \["User6",          "Yellow",  "DarkGray",  "b"     ],
            \["User7",          "DarkRed",  "DarkGray",  "b"     ],
            \["User8",          "DarkMagenta",  "DarkGray",  "b"     ],
            \["User9",          "DarkCyan",  "DarkGray",  "b"     ],
            \["MoreMsg",        "Cyan",  "bg",  "b"     ],
            \["Question",       "Magenta",  "bg",  "b"     ],
            \["ModeMsg",        "Green",  "bg",  "b"     ],
            \["MatchParen",     "bg",  "Green",  "b"    ],
            \["WarningMsg",     "bg",  "Yellow",  "b"    ],
            \["ErrorMsg",       "bg",  "Red",  "b"    ],
            \["Error",          "bg",  "Red",  "b"    ],
            \["Todo",           "bg",  "Yellow",  "b"    ],
            \["Title",          "Yellow",  "bg",  "b"     ],
            \["Conceal",        "White",  "bg",  "n"     ],
            \["Comment",        "DarkGray",  "bg",  "n"     ],
            \["SpecialComment", "DarkCyan",  "bg",  "b"     ],
            \["Underlined",     "Blue",  "bg",  "b"     ],
            \["Keyword",        "DarkCyan",  "bg",  "b"     ],
            \["Statement",      "Blue",  "bg",  "n"     ],
            \["Exception",      "Magenta",  "bg",  "bi"    ],
            \["SpecialChar",    "Magenta",  "bg",  "b"     ],
            \["PreProc",        "Magenta",  "bg",  "b"     ],
            \["Special",        "DarkMagenta",  "bg",  "n"     ],
            \["Type",           "DarkYellow",  "bg",  "n"     ],
            \["Identifier",     "Yellow",  "bg",  "b"     ],
            \["Constant",       "DarkYellow",  "bg",  "n"     ],
            \["Function",       "Green",  "bg",  "b"     ],
            \["String",         "DarkGreen",  "bg",  "n"     ],
            \["Label",          "Green",  "bg",  "b"     ],
            \] 
"}}}
"term8 "{{{
let s:term8_hl_list=[
            \["Normal",         "Black",  "White",  "n"     ],
            \["Cursor",         "Black",  "Yellow",  "r"     ],
            \["CursorLine",     "nocolor",  "Cyan",  "n"     ],
            \["Visual",         "nocolor",  "Green",  "n"     ],
            \["VisualNOS",      "nocolor",  "Green",  "n"     ],
            \["Search",         "nocolor",  "nocolor",  "u"     ],
            \["IncSearch",      "nocolor",  "Yellow",  "b"     ],
            \["Wildmenu",       "Yellow",  "Black",  "r"     ],
            \["Pmenu",          "Black",  "Gray",  "n"     ],
            \["PmenuSel",       "Black",  "Yellow",  "rb"    ],
            \["PmenuSbar",      "Black",  "Gray",  "n"     ],
            \["PmenuThumb",     "Black",  "Gray",  "n"     ],
            \["DiffAdd",        "nocolor",  "DarkGreen",  "n"     ],
            \["DiffChange",     "nocolor",  "DarkBlue",  "n"     ],
            \["DiffDelete",     "Gray",  "DarkRed",  "n"     ],
            \["DiffText",       "nocolor",  "DarkRed",  "n"     ],
            \["Folded",         "Black",  "Cyan",  "n"     ],
            \["tabline",        "Lightgray",  "Black",  "n"     ],
            \["tablinesel",     'DarkBlue',  "LightGray",  "b"     ],
            \["tablinefill",    "LightGray",  "Black",  "n"     ],
            \["StatusLine",     "Yellow",  "Black",  "b"     ],
            \["StatusLineNC",   "LightGray",  "Black",  "n"     ],
            \["User1",          "Red",  "Black",  "b"     ],
            \["User2",          "Magenta",  "Black",  "b"     ],
            \["User3",          "Cyan",  "Black",  "b"     ],
            \["User4",          "Green",  "Black",  "b"     ],
            \["User5",          "Blue",  "Black",  "b"     ],
            \["User6",          "Yellow",  "Black",  "b"     ],
            \["User7",          "DarkRed",  "Black",  "b"     ],
            \["User8",          "DarkMagenta",  "Black",  "b"     ],
            \["User9",          "DarkCyan",  "Black",  "b"     ],
            \["MoreMsg",        "Cyan",  "nocolor",  "b"     ],
            \["Question",       "Magenta",  "nocolor",  "b"     ],
            \["ModeMsg",        "Green",  "nocolor",  "b"     ],
            \["MatchParen",     "Green",  "nocolor",  "br"    ],
            \["WarningMsg",     "Yellow",  "nocolor",  "br"    ],
            \["ErrorMsg",       "Red",  "nocolor",  "br"    ],
            \["Error",          "Red",  "nocolor",  "br"    ],
            \["Todo",           "Yellow",  "nocolor",  "br"    ],
            \["Title",          "Yellow",  "nocolor",  "b"     ],
            \["Conceal",        "Gray",  "nocolor",  "n"     ],
            \["Comment",        "Black",  "nocolor",  "b"     ],
            \["SpecialComment", "DarkBlue",  "nocolor",  "n"     ],
            \["Underlined",     "Blue",  "nocolor",  "u"     ],
            \["Keyword",        "Blue",  "nocolor",  "b"     ],
            \["Statement",      "Blue",  "nocolor",  "n"     ],
            \["Exception",      "Magenta",  "nocolor",  "bi"    ],
            \["SpecialChar",    "Magenta",  "nocolor",  "b"     ],
            \["PreProc",        "Magenta",  "nocolor",  "b"     ],
            \["Special",        "Magenta",  "nocolor",  "n"     ],
            \["Type",           "Brown",  "nocolor",  "b"     ],
            \["Identifier",     "Brown",  "nocolor",  "b"     ],
            \["Constant",       "Brown",  "nocolor",  "b"     ],
            \["Function",       "Green",  "nocolor",  "b"     ],
            \["String",         "Green",  "nocolor",  "n"     ],
            \["Label",          "Green",  "nocolor",  "b"     ],
            \] 
"}}}
"{{{dark8 
let s:term8_dark_hl_list=[
            \["Normal",         "Gray",  "Black",  "n"     ],
            \["Cursor",         "White",  "Yellow",  "r"     ],
            \["CursorLine",     "nocolor",  "Cyan",  "n"     ],
            \["Visual",         "nocolor",  "Green",  "n"     ],
            \["VisualNOS",      "nocolor",  "Green",  "n"     ],
            \["Search",         "Yellow",  "nocolor",  "b"     ],
            \["IncSearch",      "nocolor",  "Yellow",  "b"     ],
            \["Wildmenu",       "Blue",  "Gray",  "r"     ],
            \["Pmenu",          "Black",  "Gray",  "n"     ],
            \["PmenuSel",       "Black",  "Yellow",  "rb"    ],
            \["PmenuSbar",      "Black",  "Gray",  "n"     ],
            \["PmenuThumb",     "Black",  "Gray",  "n"     ],
            \["DiffAdd",        "nocolor",  "Green",  "n"     ],
            \["DiffChange",     "nocolor",  "Blue",  "n"     ],
            \["DiffDelete",     "Gray",  "Red",  "n"     ],
            \["DiffText",       "nocolor",  "Red",  "n"     ],
            \["Folded",         "Black",  "Cyan",  "n"     ],
            \["tabline",        "Black",  "Gray",  "b"     ],
            \["tablinesel",     'Yellow',  "Black",  "b"     ],
            \["tablinefill",    "Gray",  "Gray",  "n"     ],
            \["StatusLine",     "Blue",  "Gray",  "b"     ],
            \["StatusLineNC",   "Black",  "Gray",  "n"     ],
            \["User1",          "Red",  "Gray",  "b"     ],
            \["User2",          "Magenta",  "Gray",  "b"     ],
            \["User3",          "Cyan",  "Gray",  "b"     ],
            \["User4",          "Green",  "Gray",  "b"     ],
            \["User5",          "Blue",  "Gray",  "b"     ],
            \["User6",          "Yellow",  "Gray",  "b"     ],
            \["User7",          "Red",  "Gray",  "b"     ],
            \["User8",          "Magenta",  "Gray",  "b"     ],
            \["User9",          "Cyan",  "Gray",  "b"     ],
            \["MoreMsg",        "Cyan",  "nocolor",  "b"     ],
            \["Question",       "Magenta",  "nocolor",  "b"     ],
            \["ModeMsg",        "Green",  "nocolor",  "b"     ],
            \["MatchParen",     "Green",  "nocolor",  "br"    ],
            \["WarningMsg",     "Yellow",  "nocolor",  "br"    ],
            \["ErrorMsg",       "Red",  "nocolor",  "r"    ],
            \["Error",          "Red",  "nocolor",  "r"    ],
            \["Todo",           "Yellow",  "nocolor",  "br"    ],
            \["Title",          "Yellow",  "nocolor",  "b"     ],
            \["Conceal",        "White",  "nocolor",  "n"     ],
            \["Comment",        "Black",  "nocolor",  "b"     ],
            \["SpecialComment", "Cyan",  "nocolor",  "b"     ],
            \["Underlined",     "Blue",  "nocolor",  "u"     ],
            \["Keyword",        "Blue",  "nocolor",  "b"     ],
            \["Statement",      "Blue",  "nocolor",  "n"     ],
            \["Exception",      "Magenta",  "nocolor",  "i"    ],
            \["SpecialChar",    "Magenta",  "nocolor",  "n"     ],
            \["PreProc",        "Magenta",  "nocolor",  "n"     ],
            \["Special",        "Magenta",  "nocolor",  "n"     ],
            \["Type",           "Yellow",  "nocolor",  "n"     ],
            \["Identifier",     "Yellow",  "nocolor",  "b"     ],
            \["Constant",       "Yellow",  "nocolor",  "n"     ],
            \["Function",       "Green",  "nocolor",  "b"     ],
            \["String",         "Green",  "nocolor",  "n"     ],
            \["Label",          "Green",  "nocolor",  "b"     ],
            \] 
"}}} 
"lnk_list "{{{
let s:link_list=[
            \["CursorColumn",   "CursorLine"    ],
            \["FoldColumn",     "Folded"        ],
            \["LineNr",         "Folded"        ],
            \["SignColumn",     "Folded"        ],
            \["ColorColumn",    "Folded"        ],
            \["VertSplit",      "StatusLineNC"  ],
            \["SpellLocal",     "WarningMsg"    ],
            \["SpellRare",      "WarningMsg"    ],
            \["SpellBad",       "ErrorMsg"      ],
            \["SpellCap",       "ErrorMsg"      ],
            \["NonText",        "Comment"       ],
            \["Ignore",         "Comment"       ],
            \["Conditional",    "Statement"     ],
            \["Operator",       "Statement"     ],
            \["Repeat",         "Statement"     ],
            \["PreCondit",      "Exception"     ],
            \["Debug",          "Exception"     ],
            \["SpecialKey",     "SpecialChar"   ],
            \["Tag",            "SpecialChar"   ],
            \["Define",         "PreProc"       ],
            \["Macro",          "PreProc"       ],
            \["Include",        "PreProc"       ],
            \["Delimiter",      "Special"       ],
            \["Directory",      "Type"          ],
            \["Structure",      "Type"          ],
            \["StorageClass",   "Identifier"    ],
            \["Boolean",        "Constant"      ],
            \["Float",          "Constant"      ],
            \["Number",         "Constant"      ],
            \["Character",      "String"        ],
            \] "}}}
"}}}
"}}}
" SYNTAX PREDEF"{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:synlink_dict={}
let s:synlink_term_dict={}
"{{{SYNTAX
let s:synlink_dict.ada=[
            \["adaBegin",   "Type"    ],
            \["adaEnd",     "Type"        ],
            \["adaKeyword",         "Keyword"        ],
            \]
let s:synlink_dict.cpp=[
            \["cppAccess",   "Type"    ],
            \["cppStatement",   "Special"    ],
            \]
let s:synlink_dict.hs=[
            \["ConId                ",   "Type          "    ],
            \["hsPragma             ",   "PreProc       "    ],
            \["hsConSym             ",   "Operator      "    ],
            \]
let s:synlink_dict.html=[
            \["htmlArg              ",   "Statement     "    ],
            \["htmlEndTag           ",   "Special       "    ],
            \["htmlItalic           ",   "Underlined    "    ],
            \["htmlLink             ",   "Underlined    "    ],
            \["htmlSpecialTagName   ",   "PreProc       "    ],
            \["htmlTag              ",   "Special       "    ],
            \["htmlTagName          ",   "Type          "    ],
            \]
let s:synlink_dict.lisp=[
            \["lispAtom             ",   "Type          "    ],
            \["lispAtomMark         ",   "Type          "    ],
            \["lispConcat           ",   "Type          "    ],
            \["lispDecl             ",   "Type          "    ],
            \["lispFunc             ",   "Special       "    ],
            \["lispKey              ",   "PreProc       "    ],
            \]
let s:synlink_dict.netrw=[
            \["netrwDir             ",   "Special       "    ],
            \["netrwExe             ",   "Wildmenu      "    ],
            \["netrwSymLink         ",   "Statement     "    ],
            \]
let s:synlink_dict.pascal=[
            \["pascalAsmKey         ",   "Statement     "    ],
            \["pascalDirective      ",   "PreProc       "    ],
            \["pascalModifier       ",   "PreProc       "    ],
            \["pascalPredefined     ",   "Special       "    ],
            \["pascalStatement      ",   "Type          "    ],
            \["pascalStruct         ",   "Type          "    ],
            \]
let s:synlink_dict.php=[
            \["phpComparison        ",   "Special       "    ],
            \["phpDefine            ",   "Type          "    ],
            \["phpIdentifier        ",   "Normal        "    ],
            \["phpMemberSelector    ",   "Special       "    ],
            \["phpRegion            ",   "Special       "    ],
            \["phpVarSelector       ",   "Special       "    ],
            \]
let s:synlink_dict.python=[
            \["pythonStatement      ",   "Type          "    ],
            \]
let s:synlink_dict.ruby=[
            \["rubyConstant         ",   "Special       "    ],
            \["rubyDefine           ",   "Type          "    ],
            \["rubyRegexp           ",   "Special       "    ],
            \]
let s:synlink_dict.scm=[
            \["schemeSyntax         ",   "Special       "    ],
            \]
let s:synlink_dict.sh=[
            \["shArithRegion        ",   "Normal        "    ],
            \["shDerefSimple        ",   "Normal        "    ],
            \["shDerefVar           ",   "Normal        "    ],
            \["shFunction           ",   "Type          "    ],
            \["shLoop               ",   "Statement     "    ],
            \["shStatement          ",   "Special       "    ],
            \["shVariable           ",   "Normal        "    ],
            \]
let s:synlink_dict.sql=[
            \["sqlKeyword           ",   "Statement     "    ],
            \]
let s:synlink_dict.tex=[
            \["texDocType           ",   "PreProc       "    ],
            \["texLigature          ",   "Constant      "    ],
            \["texMatcher           ",   "Normal        "    ],
            \["texNewCmd            ",   "PreProc       "    ],
            \["texOnlyMath          ",   "Constant      "    ],
            \["texRefZone           ",   "Constant      "    ],
            \["texSection           ",   "Type          "    ],
            \["texSectionMarker     ",   "Type          "    ],
            \["texSectionModifier   ",   "Constant      "    ],
            \["texTypeSize          ",   "Special       "    ],
            \["texTypeStyle         ",   "Special       "    ],
            \]
let s:synlink_dict.vim=[
            \["vimFuncKey           ",   "Function      "    ],
            \["vimOption            ",   "Keyword       "    ],
            \["vimCommand           ",   "Statement     "    ],
            \["vimHiCTerm           ",   "Statement     "    ],
            \["vimHiCtermFgBg       ",   "Statement     "    ],
            \["vimHighlight         ",   "Statement     "    ],
            \["vimHiGui             ",   "Statement     "    ],
            \["vimHiGuiFgBg         ",   "Statement     "    ],
            \["vimHiAttrib          ",   "Constant      "    ],
            \["vimCommentTitle      ",   "SpecialComment"    ],
            \["vimCommentTitleLeader",   "SpecialComment"    ],
            \["vimEnvVar            ",   "Special       "    ],
            \["vimSyntax            ",   "Special       "    ],
            \["vimSynType           ",   "Special       "    ],
            \["vimUserAttrb         ",   "Special       "    ],
            \]
let s:synlink_term_dict.vimwiki2=[
            \["VimwikiHeader1",          "Red",  "bg",  "b"     ],
            \["VimwikiHeader2",          "magenta",  "bg",  "b"     ],
            \["VimwikiHeader3",          "blue",  "bg",  "b"     ],
            \["VimwikiHeader4",          "cyan",  "bg",  "b"     ],
            \["VimwikiHeader5",          "green",  "bg",  "b"     ],
            \["VimwikiHeader6",          "yellow",  "bg",  "b"     ],
            \]
let s:synlink_dict.vimwiki2=[
            \["VimwikiHeader1",          "echclr2",  "bgdclr0",  "b"     ],
            \["VimwikiHeader2",          "echclr4",  "bgdclr0",  "b"     ],
            \["VimwikiHeader3",          "echclr6",  "bgdclr0",  "b"     ],
            \["VimwikiHeader4",          "echclr8",  "bgdclr0",  "b"     ],
            \["VimwikiHeader5",          "echclrA",  "bgdclr0",  "b"     ],
            \["VimwikiHeader6",          "echclrC",  "bgdclr0",  "b"     ],
            \["VimwikiHeader6",          "echclrE",  "bgdclr0",  "b"     ],
            \["Vimwiki_Posit9",          "echclr0",  "bgdclr0",  "b"     ],
            \["Vimwiki_Posit8",          "echclr1",  "bgdclr0",  "b"     ],
            \["Vimwiki_Posit7",          "echclr2",  "bgdclr0",  "b"     ],
            \["Vimwiki_Posit6",          "echclr3",  "bgdclr0",  "b"     ],
            \["Vimwiki_Posit5",          "echclr4",  "bgdclr0",  "b"     ],
            \["Vimwiki_Posit4",          "echclr5",  "bgdclr0",  "b"     ],
            \["Vimwiki_Posit3",          "echclr6",  "bgdclr0",  "b"     ],
            \["Vimwiki_Posit2",          "echclr7",  "bgdclr0",  "b"     ],
            \["Vimwiki_Posit1",          "echclr8",  "bgdclr0",  "b"     ],
            \["Vimwiki_minus1",          "echclr9",  "bgdclr0",  "b"     ],
            \["Vimwiki_minus2",          "echclrA",  "bgdclr0",  "b"     ],
            \["Vimwiki_minus3",          "echclrB",  "bgdclr0",  "b"     ],
            \["Vimwiki_minus4",          "echclrC",  "bgdclr0",  "b"     ],
            \["Vimwiki_minus5",          "echclrD",  "bgdclr0",  "b"     ],
            \["Vimwiki_minus6",          "echclrE",  "bgdclr0",  "b"     ],
            \["Vimwiki_minus7",          "echclrF",  "bgdclr0",  "b"     ],
            \["Vimwiki_minus8",          "echclrG",  "bgdclr0",  "b"     ],
            \["Vimwiki_minus9",          "echclrH",  "bgdclr0",  "b"     ],
            \["Vimwiki_minus0",          "fgdclr3",  "bgdclr0",  "b"     ],
            \["Vimwiki_Posit0",          "fgdclr4",  "bgdclr0",  "b"     ],
            \]
let s:synlink_dict.vimwiki=[
            \["VimwikiLIst",   "Keyword     "    ],
            \["vimwikibold",   "Title     "    ],
            \["VimwikiTimeStamp",   "SpecialComment"    ],
            \]
let s:synlink_dict.xml=[
            \["xmlAttrib            ",   "Special       "    ],
            \["xmlCdata             ",   "Normal        "    ],
            \["xmlCdataCdata        ",   "Statement     "    ],
            \["xmlCdataEnd          ",   "PreProc       "    ],
            \["xmlCdataStart        ",   "PreProc       "    ],
            \["xmlDocType           ",   "PreProc       "    ],
            \["xmlDocTypeDecl       ",   "PreProc       "    ],
            \["xmlDocTypeKeyword    ",   "PreProc       "    ],
            \["xmlEndTag            ",   "Statement     "    ],
            \["xmlProcessingDelim   ",   "PreProc       "    ],
            \["xmlNamespace         ",   "PreProc       "    ],
            \["xmlTagName           ",   "Statement     "    ],
            \] 
"}}}
"}}}
"LOADING VAR"{{{
"======================================================================
" TODO: color changing with time
" TODO: random color scheme generator
" TODO: blue color brighteness compensate +
function! s:generate_colors() "{{{

let s:fgdclr_list=ColorV#gen_list(s:scheme_dict.colors[0],"Value",7,(-s:v_step*8))
for i in range(7)
    if has("gui_running")
        let s:fgdclr{i} = s:fgdclr_list[i]
    else
    	let s:fgdclr{i} = ColorV#hex2term(s:fgdclr_list[i],"CHECK_TERMCO")
    endif
endfor
" " DONE: 110805  Monochromatic foreground color
" " DONE: 110805  use saturation - instead
" " XXX: Not very nice looking 
" let s:monocr_list=ColorV#gen_list(s:scheme_dict.colors[0],"LessSatur",9,(-s:v_step*10))
" for i in range(9)
"     if has("gui_running")
"         let s:monocr{i} = s:monocr_list[i]
"     else
"     	let s:monocr{i} = ColorV#hex2term(s:monocr_list[i])
"     endif
" endfor

let s:synclr_list=ColorV#gen_list(s:scheme_dict.colors[1],"Hue",9,72)
for i in range(9)
    if has("gui_running")
        let s:synclr{i} = s:synclr_list[i]
    else
    	let s:synclr{i} = ColorV#hex2term(s:synclr_list[i],"CHECK_TERMCO")
    endif
endfor

"                                                 ^ position
let char_list="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let s:echclr_list=ColorV#gen_list(s:scheme_dict.colors[2],"Neutral",36)
for i in range(36)
    let char=char_list[i]
    if has("gui_running")
        let s:echclr{char} = s:echclr_list[i]
    else
    	let s:echclr{char} = ColorV#hex2term(s:echclr_list[i],"CHECK_TERMCO")
    endif
endfor
" TODO: error of background lightness output 000000
let s:bgdclr_list=ColorV#gen_list(s:scheme_dict.colors[3],"Value",7,s:v_step*7)
for i in range(7)
    if has("gui_running")
        let s:bgdclr{i} = s:bgdclr_list[i]
    else
    	let s:bgdclr{i} = ColorV#hex2term(s:bgdclr_list[i],"CHECK_TERMCO")
    endif
endfor
" TODO: the background-colored color is too little.
let s:difclr_list=ColorV#gen_list(s:scheme_dict.colors[4],"Tetradic",4)
for i in range(4)
    if has("gui_running")
        let s:difclr{i} = s:difclr_list[i]
    else
    	let s:difclr{i} = ColorV#hex2term(s:difclr_list[i],"CHECK_TERMCO")
    endif
endfor

" TODO: the background-colored color is too little. add bgrhue
" let char_list="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let s:bgrhue_list=ColorV#gen_list(s:scheme_dict.colors[4],"Hue",12,35)
for i in range(12)
    let char=char_list[i]
    if has("gui_running")
        let s:bgrhue{char} = s:bgrhue_list[i]
    else
    	let s:bgrhue{char} = ColorV#hex2term(s:bgrhue_list[i],"CHECK_TERMCO")
    endif
endfor

endfunction "}}}

function! s:high_list(list,...) "{{{ 
    let list=a:list
    for item in list
        if len(item) == 4 
            let [hl_grp,hl_fg,hl_bg,hl_fm]=item

            if empty(hl_fm)
                let fm_txt=""
            else
            endif
            let fm_txt = "NONE"
            let fm_txt .= hl_fm=~'u' ? ",underline"   : ""
            let fm_txt .= hl_fm=~'c' ? ",undercurl"   : ""
            let fm_txt .= hl_fm=~'r' ? ",reverse"     : ""
            let fm_txt .= hl_fm=~'b' ? ",bold"        : ""
            let fm_txt .= hl_fm=~'i' ? ",italic"      : ""
            let fm_txt .= hl_fm=~'s' ? ",standout"    : ""
            
            if exists("a:1") && a:1=="NOCHECK"
            	if hl_fg =="nocolor"
                    let fg_txt = s:{hl_fg} 
                else
                    let fg_txt = hl_fg 
                endif
            	if hl_bg =="nocolor"
                    let bg_txt = s:{hl_bg} 
                else
                    let bg_txt = hl_bg 
                endif
            else
                let fg_txt = hl_fg =~ '\x\{6}' || empty(hl_fg) 
                            \|| '\(fg\|bg\)' ? hl_fg :
                            \ exists("s:{hl_fg}") ? s:{hl_fg} : s:fgdclr0
                let bg_txt = hl_bg =~ '\x\{6}' || empty(hl_bg) 
                            \|| '\(fg\|bg\)' ? hl_bg :
                            \ exists("s:{hl_bg}") ? s:{hl_bg} : s:bgdclr0
            endif

            
            if has("gui_running")
                let fg_txt = fg_txt =~ '^\x\{6}$' ? "#".fg_txt : fg_txt
                let bg_txt = bg_txt =~ '^\x\{6}$' ? "#".bg_txt : bg_txt
            else
                let fg_txt= fg_txt =~ '\x\{6}$' ? ColorV#hex2term(fg_txt) : fg_txt
                let bg_txt= bg_txt =~ '\x\{6}$' ? ColorV#hex2term(bg_txt) : bg_txt
            endif

            let fg_txt = empty(fg_txt) ? "" : s:mode."fg=".fg_txt." "
            let bg_txt = empty(bg_txt) ? "" : s:mode."bg=".bg_txt." "
            let fm_txt = empty(fm_txt) ? "" : s:mode."=".fm_txt
            if !empty(fg_txt) || !empty(bg_txt) || !empty(fm_txt)
                exec "hi! ".hl_grp." ".fg_txt.bg_txt.fm_txt
            endif

        elseif len(item) == 2 
            let [hl_from,hl_to]=item
            exec "hi! link ".hl_from." ".hl_to
        endif
    endfor
endfunction "}}} 
function! s:set_miscs() "{{{

    if s:v<=50
    	if exists("g:colors_name")
            unlet g:colors_name 
        endif
        set background=dark
        let s:v_step=1
    else
    	if exists("g:colors_name")
            unlet g:colors_name 
        endif
        set background=light
        let s:v_step=-1
    endif
endfunction "}}}
function! s:get_style_hl(style) "{{{
    let s:hl_scheme=deepcopy(s:default_hl_list)
    for hl_list in s:style_hllist
        if a:style == hl_list.name
            let s:hl_scheme += hl_list.highlights
        endif
    endfor
endfunction "}}}
" DONE: 110808  set with presistence file
function! s:set_scheme_list() "{{{
    let s:scheme_list=deepcopy(s:built_in_schemes)

" " DONE: 110805  deprecating using g:. using serialzd file instead.
    " if exists("g:galaxy_scheme_list") && !empty(g:galaxy_scheme_list)

    "     for i in range(len(g:galaxy_scheme_list))
    "         if exists("g:galaxy_scheme_list[".i."].name") 
    "                     \ && exists("g:galaxy_scheme_list[".i."].colors")
    "                     \ && len(g:galaxy_scheme_list[i].colors)==5
    "             
    "             call add(s:scheme_list, g:galaxy_scheme_list[i])
    "         else
    "             continue
    "         endif
    "     endfor
    " elseif exists("s:cached_theme_list") &&  !empty(s:cached_theme_list)

    "     for i in range(len(s:cached_theme_list))
    "         if exists("s:cached_theme_list[".i."].name") 
    "                     \ && exists("s:cached_theme_list[".i."].colors")
    "                     \ && len(s:cached_theme_list[i].colors)==5
    "             
    "             call add(s:scheme_list, s:cached_theme_list[i])
    "         else
    "             continue
    "         endif
    "     endfor
    " endif
    " if exists("g:galaxy_load_store") && g:galaxy_load_store ==1
    let s:stored_theme_list = s:load_store()
    if !empty(s:stored_theme_list)
        let s:scheme_list=deepcopy(s:built_in_schemes)
        for i in range(len(s:stored_theme_list))
            if exists("s:stored_theme_list[".i."].name") 
                        \ && exists("s:stored_theme_list[".i."].colors")
                        \ && len(s:stored_theme_list[i].colors)==5
                
                call add(s:scheme_list, s:stored_theme_list[i])
            else
                continue
            endif
        endfor
    endif
    " endif
    " TODO: internet color/scheme server 
    " upload/download
    " random
    " rating/comment
    " Kuler access?
endfunction "}}}
function! s:statusline_aug() "{{{
if version >= 700 "{{{
    if s:style_name=="COLOUR"
        let s:list_insert_enter=[
            \["Cursor",         "difclr0",  "bgdclr0",  "r"     ],
            \["StatusLine",     "fgdclr3",  "difclr0",  "b"     ],
            \["User1",          "bgrhue1",  "difclr0",  "b"     ],
            \["User2",          "bgrhue2",  "difclr0",  "b"     ],
            \["User3",          "bgrhue3",  "difclr0",  "b"     ],
            \["User4",          "bgrhue4",  "difclr0",  "b"     ],
            \["User5",          "bgrhue5",  "difclr0",  "b"     ],
            \["User6",          "bgrhue6",  "difclr0",  "b"     ],
            \["User7",          "bgrhue7",  "difclr0",  "b"     ],
            \["User8",          "bgrhue8",  "difclr0",  "b"     ],
            \["User9",          "bgrhue9",  "difclr0",  "b"     ],
            \]
    else
        let s:list_insert_enter=[
            \["Cursor",         "echclr0",  "bgdclr0",  "r"     ],
            \["StatusLine",     "bgdclr3",  "synclr0",  "b"     ],
            \["User1",          "echclr0",  "synclr0",  "b"     ],
            \["User2",          "echclr1",  "synclr0",  "b"     ],
            \["User3",          "echclr2",  "synclr0",  "b"     ],
            \["User4",          "echclr3",  "synclr0",  "b"     ],
            \["User5",          "echclr4",  "synclr0",  "b"     ],
            \["User6",          "echclr5",  "synclr0",  "b"     ],
            \["User7",          "echclr6",  "synclr0",  "b"     ],
            \["User8",          "echclr7",  "synclr0",  "b"     ],
            \["User9",          "echclr8",  "synclr0",  "b"     ],
            \]
    endif
        let s:list_insert_leave =[]
        let hl_grp = ["Cursor","StatusLine","User1","User2","User3",
                    \"User4","User5","User6","User7","User8","User9",]
        for item in  s:hl_scheme
            for grp in hl_grp
                if item[0] == grp
                    call add(s:list_insert_leave,item)
                endif
            endfor
        endfor
            
    aug insertenter_color
        au!
        au InsertEnter * call s:high_list(s:list_insert_enter)
        au InsertLeave * call s:high_list(s:list_insert_leave)
    aug END
    call s:term_cursor()
endif "}}}
endfunction "}}}
function! s:term_cursor() "{{{
    " TODO: terminal cursor color changing
    
    if &term =~ "xterm"
        silent !echo -ne "\e]12;Grey\007"
        if s:v <=50
            let &t_SI="\e]12;Yellow\007"
            let &t_EI="\e]12;Grey\007"
        else
            let &t_SI="\e]12;RoyalBlue1\007"
            let &t_EI="\e]12;Black\007"
        endif
        
        aug term_cursor
            au!
            autocmd VimLeave * :!echo -ne "\e]12;green\007"
        aug
    endif
endfunction "}}}
function! s:statusline_term16_aug() "{{{
if version >= 700 "{{{
    if s:v <=50
        let s:list_insert_enter=[
            \["Cursor",         "Blue",  "Gray",  "r"     ],
            \["StatusLine",     "Gray",  "Blue",  "n"     ],
            \["User1",          "Red",  "Blue",  "n"     ],
            \["User2",          "Magenta",  "Blue",  "n"     ],
            \["User3",          "Cyan",  "Blue",  "n"     ],
            \["User4",          "Green",  "Blue",  "n"     ],
            \["User5",          "Blue",  "Blue",  "n"     ],
            \["User6",          "Yellow",  "Blue",  "n"     ],
            \["User7",          "Red",  "Blue",  "b"     ],
            \["User8",          "Magenta",  "Blue",  "b"     ],
            \["User9",          "Cyan",  "Blue",  "b"     ],
            \]
    else
        let s:list_insert_enter=[
            \["Cursor",         "Yellow",  "Black",  "r"     ],
            \["StatusLine",     "Black",  "Yellow",  "n"     ],
            \["User1",          "Red",  "Yellow",  "n"     ],
            \["User2",          "Magenta",  "Yellow",  "n"     ],
            \["User3",          "Cyan",  "Yellow",  "n"     ],
            \["User4",          "Green",  "Yellow",  "n"     ],
            \["User5",          "Blue",  "Yellow",  "n"     ],
            \["User6",          "Yellow",  "Yellow",  "n"     ],
            \["User7",          "Red",  "Yellow",  "b"     ],
            \["User8",          "Magenta",  "Yellow",  "b"     ],
            \["User9",          "Cyan",  "Yellow",  "b"     ],
            \]
    endif
        let s:list_insert_leave =[]
        let hl_grp = ["Cursor","StatusLine","User1","User2","User3",
                    \"User4","User5","User6","User7","User8","User9",]
        for item in  s:hl_scheme
            for grp in hl_grp
                if item[0] == grp
                    call add(s:list_insert_leave,item)
                endif
            endfor
        endfor
            
    aug insertenter_color
        au!
        au InsertEnter * call s:high_list(s:list_insert_enter,"NOCHECK")
        au InsertLeave * call s:high_list(s:list_insert_leave,"NOCHECK")
    aug END
    call s:term_cursor()
endif "}}}
endfunction "}}}
"}}}
" WINDOW "{{{
"======================================================================
" DONE: 110805  show scheme list
function! galaxy#scheme_window() "{{{
    " window check "{{{
    if bufexists(g:galaxy.name) 
    	let nr=bufnr('\[GALAXY\]')
    	let winnr=bufwinnr(nr)
        if winnr>0 && bufname(nr)==g:galaxy.name
            if bufwinnr('%') ==winnr
            	" if g:galaxy.win_pos=~'bo\%[tright]'
                "     exec winnr."wincmd J"
                " elseif g:galaxy.win_pos=~'to\%[pleft]'
                "     exec winnr."wincmd K"
                " endif
                if expand('%') !=g:galaxy.name
                    call s:warning("Not [galaxy] buffer")
                    return
                else
                    call s:echo("All ready in [galaxy] window.")
                endif
            else
            	"Becareful
                exec winnr."wincmd w"
                "Always get the max bottom or top
            	if g:galaxy.win_pos=~'bo\%[tright]'
                    exec winnr."wincmd J"
                elseif g:galaxy.win_pos=~'to\%[pleft]'
                    exec winnr."wincmd K"
                endif
                if expand('%') !=g:galaxy.name
                    call s:warning("Not [galaxy] buffer")
                    return
                else
                    call s:echo("[galaxy] all ready exists.")
                endif
            endif
        else
            " call s:echo("Open a new [galaxy]")
            " execute "botright" 'new' 
            if g:galaxy.win_pos =~ 'vert\%[ical]\|lefta\%[bove]\|abo\%[veleft]
                \\|rightb\%[elow]\|bel\%[owright]\|to\%[pleft]\|bo\%[tright]'
                execute  g:galaxy.win_pos 'new' 
            else
                execute  'bo' 'new' 
            endif
            silent! file [GALAXY]
        endif
    else
        " call s:echo("Open a new [galaxy]")
        " execute  "botright" 'new' 
        if g:galaxy.win_pos =~ 'vert\%[ical]\|lefta\%[bove]\|abo\%[veleft]
             \\|rightb\%[elow]\|bel\%[owright]\|to\%[pleft]\|bo\%[tright]'
            execute  g:galaxy.win_pos 'new' 
        else
            execute  'bo' 'new' 
        endif
        silent! file [GALAXY]
    endif 
    "}}}
    "{{{local setting 
    " 
    setl ma
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

    augroup plugin-galaxy
        autocmd CursorMoved,CursorMovedI <buffer>  call s:on_cursor_moved()
    aug END
    "}}}
    "{{{ maps
    nmap <silent><buffer> q :call galaxy#exit_win()<cr>
    nmap <silent><buffer> Q :call galaxy#exit_win()<cr>
    " nmap <silent><buffer> n :call <SID>win_scheme_new()<cr>
    nmap <silent><buffer> n :call <SID>win_scheme_easy_gen()<cr>
    " nmap <silent><buffer> e :call <SID>win_scheme_edit()<cr>
    nmap <silent><buffer> e :call <SID>win_scheme_edit_colorv()<cr>
    nmap <silent><buffer> dd :call <SID>win_scheme_del()<cr>
    nmap <silent><buffer> D :call <SID>win_scheme_del()<cr>
    map <silent><buffer> <enter> :call <SID>win_load_scheme()<cr>
    map <silent><buffer> <space> :call <SID>win_load_scheme()<cr>
    map <silent><buffer> <2-leftmouse> :call <SID>win_load_scheme()<cr>
    "}}}
    let StringList = []
    let m = "Galaxy Manager v".g:galaxy.version."  [<F1>:help q:quit n:new e:edit dd:delete]"
    call add(StringList,m)
    let m = "NAME"
    let m = s:line_sub(m,"FG",20)
    let m = s:line_sub(m,"SYN",27)
    let m = s:line_sub(m,"MSG",34)
    let m = s:line_sub(m,"BG",41)
    let m = s:line_sub(m,"DIF",48)
    let m = s:line_sub(m,"STYLE",60)
    call add(StringList,m)
    call s:set_scheme_list()
    for scheme in s:scheme_list
        let colors=""
        for color in scheme.colors
            let colors .= color." "
        endfor
        let name = scheme.name
        let style = exists("scheme.style") ? scheme.style : ""
        let m = strpart(name,0,16)
        let m = s:line_sub(m,colors,20)
        let m = s:line_sub(m,style,60)
        call add(StringList,m)
    endfor
    let l:win_h = len(StringList)
    if winnr('$') != 1
        execute 'resize' l:win_h
        redraw
    endif
    if !empty(StringList)
        for i in range(len(StringList))
            call setline(i+1,StringList[i])
        endfor
    endif
    call ColorV#preview("noname")
    setl noma
endfunction "}}}
function! s:on_cursor_moved()  "{{{
    execute 'match' (line('.') > 2 ? "ErrorMsg".' /\%'.line('.').'l\%<17c/' : 
                \ 'Title /\%'.line('.').'l/' )
endfunction "}}}
function! s:win_load_scheme() "{{{
    let linenum=line('.')
    if linenum<=2
    	call s:echo("Please move down to choose a scheme.")
    	return
    else
        let line = getline(linenum)
        let line_lst=split(line,'\s\+')
        let name=line_lst[0]
        if !has("gui_running") && (&t_Co==8 || &t_Co==16)
            call galaxy#load_scheme16(name)
        else
            " let s:cached_theme_list=galaxy#load_file(g:galaxy_cache_File)
            call galaxy#load_scheme(name)
        endif
    endif

endfunction "}}}
function! s:win_scheme_easy_gen() "{{{
    let scheme={}
    let name=input("Please Input your Scheme name ([a-zA-Z0-9_]):\n")
    if !empty(name) && name =~ '^[a-zA-Z0-9_]*$'
        let scheme.name= substitute(name,'\s',"_","g")
    else
        call s:echo("Not a Valid Name. Stopped.")
        return
    endif
    let colors=[]
    let fg_txt="Foreground"
    let bg_txt="Background"
    let fg=s:input_clr("333333",fg_txt)
    let [synh,syns,synv]=ColorV#hex2hsv(fg)
    " let synl=
    if synv <=50
        let syn = ColorV#hsv2hex([(synh+240.0),(syns+50.0),(synv+30.0)])
        let [echh,echs,echv]=ColorV#hex2hsv(fg)
        let ech = ColorV#hsv2hex([(echh+20.0),(echs+70.0),(echv+50.0)])
        let bg =s:input_clr("cccccc",bg_txt)
        let [difh,difs,difv]=ColorV#hex2hsv(bg)
        let dif = ColorV#hsv2hex([(difh+120.0),(difs+50.0),(difv+5.0)])
    else
        let syn = ColorV#hsv2hex([(synh+240.0),(syns+50.0),(synv+5)])
        let [echh,echs,echv]=ColorV#hex2hsv(fg)
        let ech = ColorV#hsv2hex([(echh+20.0),(echs+70.0),(echv+5.0)])
        let bg =s:input_clr("cccccc",bg_txt)
        let [difh,difs,difv]=ColorV#hex2hsv(bg)
        let dif = ColorV#hsv2hex([(difh+120.0),(difs+50.0),(difv+20.0)])
    endif
    call add(colors,fg)
    call add(colors,syn)
    call add(colors,ech)
    call add(colors,bg)
    call add(colors,dif)
    let scheme.colors=colors
    let scheme.name=name
    call s:write_store(scheme)
    call galaxy#scheme_window()

endfunction "}}}
function! s:win_scheme_new() "{{{
" TODO: 2! color => 5 color
" bg / fg
    let scheme={}
    let name=input("Please Input your scheme name ([a-zA-Z0-9_]):\n")
    if !empty(name) && name =~ '^[a-zA-Z0-9_]*$'
        let scheme.name= substitute(name,'\s',"_","g")
    else
        call s:echo("Not a Valid Name. Stopped.")
        return
    endif
    let colors=[]
    let clr_txt=s:clr_txt
    for i in range(5)
    	let color =s:input_clr("808080",clr_txt[i])
        call add(colors,color)
    endfor
    let scheme.colors=colors
    let style=input("Please Input your scheme's style ('SHADOW|COLOUR'):\n","SHADOW")
    let scheme.style = style
    
    call s:write_store(scheme)
    " TODO: Test this theme first
    " call galaxy#load_scheme(scheme.name)
    call galaxy#scheme_window()
endfunction "}}}
function! s:win_scheme_edit() "{{{
    let linenum=line('.')
    let col = col('.')
    let s:win_txtline=2
    let s:win_builtin_line=len(s:built_in_schemes)
    if linenum<=s:win_txtline
    	call s:echo("Please move down to choose a scheme.")
    	return
    endif
    if linenum <= s:win_txtline + s:win_builtin_line
    	call s:echo("You Could not modify the built-in Schemes.")
    	return
    endif
    let line = getline(linenum)
    let line_lst=split(line,'\s\+')
    " echoe string(line_lst)
    let scheme={}
    let scheme.name=line_lst[0]
    let scheme.colors=line_lst[1:5]
    let scheme.style=exists("line_lst[6]") ? line_lst[6] : ""

    let clr_txt=s:clr_txt
    if col >= 20 && col <=25
    	let scheme.colors[0]  = s:input_clr(scheme.colors[0],clr_txt[0])
    elseif col >= 27 && col <=32
    	let scheme.colors[1]  = s:input_clr(scheme.colors[1],clr_txt[1])
    elseif col >= 34 && col <=39
    	let scheme.colors[2]  = s:input_clr(scheme.colors[2],clr_txt[2])
    elseif col >= 41 && col <=46
    	let scheme.colors[3]  = s:input_clr(scheme.colors[3],clr_txt[3])
    elseif col >= 48 && col <=53
    	let scheme.colors[4]  = s:input_clr(scheme.colors[4],clr_txt[4])
    elseif col >= 60
    	let scheme.style = input("Please Input your scheme's style ('SHADOW(default)|COLOUR'):\n",scheme.style)
    else
    	call s:echo("Pleae put cursor on the colors or styles.")
    endif
    call s:write_store(scheme)
    call galaxy#scheme_window()

endfunction "}}}
function! s:input_clr(color,txt) "{{{
    let txt=a:txt
    let color = input("Please Input scheme ".txt.
                \" Color('000000~ffffff'):\n")
    while color !~'^\x\{6}$'
        " s:echo("Not a Valid Color. Please reinput('000000~ffffff').")
        let color = input("InValid. Please Input scheme ".txt.
                    \" Color('000000~ffffff'):\n")
        if empty(color)
            s:echo("Nothing changed")
            let color = a:color
            break
        endif
    endwhile
    return color
endfunction "}}}
function! s:win_scheme_edit_colorv() "{{{
    let linenum=line('.')
    let col = col('.')
    let s:win_txtline=2
    let s:win_builtin_line=len(s:built_in_schemes)
    if linenum<=s:win_txtline
    	call s:echo("Please move down to choose a scheme.")
    	return
    endif
    if linenum <= s:win_builtin_line
    	call s:echo("You Could not modify the built-in Schemes.")
    	return
    endif
    let line = getline(linenum)
    let line_lst=split(line,'\s\+')
    let scheme={}
    let scheme.name=line_lst[0]
    let scheme.colors=line_lst[1:5]
    let scheme.style=exists("line_lst[6]") ? line_lst[6] : ""
    let clr_txt=s:clr_txt
    " let s:edit_linenum = linenum
    let s:edit_scheme =deepcopy(scheme)
    if col >= 20 && col <=25
    	call s:input_colorv(scheme.colors[0],clr_txt[0])
    	let s:edit_clr=0
    elseif col >= 27 && col <=32
    	call s:input_colorv(scheme.colors[1],clr_txt[1])
    	let s:edit_clr=1
    elseif col >= 34 && col <=39
    	call s:input_colorv(scheme.colors[2],clr_txt[2])
    	let s:edit_clr=2
    elseif col >= 41 && col <=46
    	call s:input_colorv(scheme.colors[3],clr_txt[3])
    	let s:edit_clr=3
    elseif col >= 48 && col <=53
    	call s:input_colorv(scheme.colors[4],clr_txt[4])
    	let s:edit_clr=4
    elseif col >= 60
    	let scheme.style = input("Please Input your scheme's style ('SHADOW(default)|COLOUR'):\n",scheme.style)
        call s:write_store(scheme)
        call galaxy#scheme_window()
    	let s:edit_clr=-1
    else
    	call s:echo("Pleae put cursor on the colors or styles.")
    	let s:edit_clr=-1
    endif
endfunction "}}}
function! s:input_colorv(color,txt) "{{{
    " TODO: use ColorV color chooser
    " XXX: could not get the correct state of ColorV
    " should be there a callback function?
    " let s:changefunc=function("s:len")
    " set callback=[[line,col],s:changefunc]
    " call ColorV#Win_call(a:color,callback)
    " call ColorV#cursor_change(4,"galaxy#changed")
    call ColorV#Win("min",a:color,1,"galaxy#changed",['g:ColorV.HEX'])
    call s:echo("Choose your color for ".a:txt)
    " Can not get the state of finish or not
    " return g:ColorV.HEX
endfunction "}}}
function! galaxy#changed(color) "{{{
    let color=a:color
    let scheme=s:edit_scheme
    if s:edit_clr == -1
    	return
    endif
    let scheme.colors[s:edit_clr]=eval(color)
    call s:write_store(scheme)
    call galaxy#scheme_window()
endfunction "}}}
function! s:win_scheme_del() "{{{
    " get the name
    let linenum=line('.')
    let col = col('.')
    let s:win_txtline=2
    let s:win_builtin_line=len(s:built_in_schemes)
    if linenum<=s:win_txtline
    	call s:echo("Please move down to choose a scheme.")
    	return
    endif
    if linenum <= s:win_builtin_line
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
    let input=input("Are you sure to delete the file ".file."?\n(yes/no):")
    if filereadable(file) && input=="yes"
    	call delete(file)
    	call s:echo("File deleted.")
    elseif !filereadable(file) 
    	call s:echo("Error:file not readable.")
    	return
    else
    	call s:echo("File deleting quited.")
    	return
    endif
    " redraw window
    call galaxy#exit_win()
    call galaxy#scheme_window()
endfunction "}}}
function! galaxy#exit_win() "{{{
    if bufexists(g:galaxy.name) 
    	let nr=bufnr('\[GALAXY\]')
    	let winnr=bufwinnr(nr)
        if winnr>0 && bufname(nr)==g:galaxy.name
            if bufwinnr('%') == winnr && expand('%') ==g:galaxy.name
                " call s:echo("Close [GALAXY].")
                bd
            else
            	"Becareful
                exec winnr."wincmd w"
                if expand('%') ==g:galaxy.name
                    " call s:echo("Close existing [GALAXY].")
                    bd
                endif
            endif
        endif    
    endif
    redraw
endfunction "}}}
"}}}
"HELPER "{{{
"======================================================================
function! s:echo(msg) "{{{
    if g:ColorV_silent_set==0
        exe "echom \"[Note] ".escape(a:msg,'"')."\""
    else
    	echom ""
    endif
endfunction "}}}
function! s:caution(msg) "{{{
    echohl Modemsg
    exe "echom \"[Caution] ".escape(a:msg,'"')."\""
    echohl Normal
endfunction "}}}
function! s:warning(msg) "{{{
    echohl Warningmsg
    exe "echom \"[Warning] ".escape(a:msg,'"')."\""
    echohl Normal
endfunction "}}}
function! s:error(msg) "{{{
    echohl Errormsg
    exe "echom \"[Error] ".escape(a:msg,'"')."\""
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
"}}}
"STORE "{{{
"======================================================================
" DONE: 110809  presistence files write with command
" TODO: the file sequence maybe different
" and should remove the cache
function! s:write_store(scheme) "{{{
    
    let scheme=a:scheme
    let CacheStringsList = []
    if !isdirectory(expand(g:galaxy_store_Folder))
        call mkdir(expand(g:galaxy_store_Folder))
    endif
    " TODO: let scheme_list_list became the editing variable
    " if !empty(a:scheme)
    "     for scheme in a:scheme
            if exists("scheme.colors") && len(scheme.colors)==5
                call add(CacheStringsList,"GALAXY_NAME\t".scheme.name)
                call add(CacheStringsList,
                            \"GALAXY_COLORS\t" 
                            \.scheme.colors[0]." "
                            \.scheme.colors[1]." "
                            \.scheme.colors[2]." "
                            \.scheme.colors[3]." "
                            \.scheme.colors[4])

                if exists("scheme.style") 
                    call add(CacheStringsList,"GALAXY_STYLE\t".scheme.style)
                endif

                if exists("scheme.highlights") 
                    for i in range(len(scheme.highlights))
                    	if len(scheme.highlights[i]) == 4 
                            call add(CacheStringsList,
                                        \"GALAXY_HIGH\t" 
                                        \.scheme.highlights[i][0]." "
                                        \.scheme.highlights[i][1]." "
                                        \.scheme.highlights[i][2]." "
                                        \.scheme.highlights[i][3])
                        elseif len(scheme.highlights[i]) == 2 
                            call add(CacheStringsList,
                                        \"GALAXY_HIGH\t" 
                                        \.scheme.highlights[i][0]." "
                                        \.scheme.highlights[i][1])
                        endif
                    endfor
                endif

                call add(CacheStringsList,"GALAXY_END")
                call add(CacheStringsList,"")

                let file = g:galaxy_store_Folder . scheme.name. ".galaxy"
                call writefile(CacheStringsList, file)
            endif
        " endfor
    " endif
endfunction "}}}
function! s:load_store() "{{{
    let folder =  expand(g:galaxy_store_Folder)
    let s:file_list=split(globpath(folder, '*.galaxy'), '\n')
    " echoe folder isdirectory(folder) string(s:file_list)
    let l:stored_theme_list= []
    if isdirectory(folder)
        for file in s:file_list
            let l:stored_theme_list +=  galaxy#load_file(file)
        endfor
    endif
    return l:stored_theme_list
endfunction "}}}

function! galaxy#write_cache(...) "{{{
    let CacheStringsList = []
    let file = g:galaxy_cache_File
    call add(CacheStringsList,"CACHE_NAME\t".s:scheme_dict.name)
    call add(CacheStringsList,"CACHE_NUM\t".s:cache_num)
    call add(CacheStringsList,"")
    call writefile(CacheStringsList, file)
endfunction "}}}
function! galaxy#load_file(file) "{{{
    let file = a:file
    let s:cache_num = exists("s:cache_num") ? s:cache_num : 0
    let s:cache_name = exists("s:cache_name") ? s:cache_name : ""
    if filereadable(file)
        let CacheStringsList = readfile(file)
        " if !exists("s:cached_theme_list") 
            let l:cached_theme_list=[]
        " endif
        " let l:color_exists=0
        for i in CacheStringsList
            if i =~ 'CACHE_NAME' 
            	let name = matchstr(i,'CACHE_NAME\s*\zs.*\ze\s*')
                let s:cache_name = name
            endif
            if i =~ 'CACHE_NUM' 
            	let num = matchstr(i,'CACHE_NUM\s*\zs.*\ze\s*')
                let s:cache_num = num
            endif

            "the color cache
            if !exists("l:tmp_dict") 
                let l:tmp_dict={}
            endif
            if i =~ 'GALAXY_NAME'
                let l:tmp_dict.name = 
                            \matchstr(i,'GALAXY_NAME\s*\zs.*\ze\s*')
            endif
            if i =~ 'GALAXY_COLORS'
            	let colors=matchstr(i,'GALAXY_COLORS\s*\zs.*\ze\s*')
                let l:tmp_dict.colors = split(colors,'\s')
                if len(l:tmp_dict.colors)==5
                    let l:color_exists=1
                else
                    let l:color_exists=0
                endif
            endif
            if i =~ 'GALAXY_STYLE'
                let l:tmp_dict.style = 
                            \matchstr(i,'GALAXY_STYLE\s*\zs.*\ze\s*')
                            
            endif
            if i =~ 'GALAXY_HIGH' 
            	let highlights = matchstr(i,'GALAXY_HIGH\s*\zs.*\ze\s*')
            	let l:tmp_dict.highlights = []
            	call add(l:tmp_dict.highlights,split(highlights,'\s'))
            endif
            if i =~ 'GALAXY_END' 
            	if exists("l:color_exists") && l:color_exists==1
                    call add(l:cached_theme_list,deepcopy(l:tmp_dict))
                endif
            	unlet l:tmp_dict
            endif
        endfor
        return l:cached_theme_list
    else
    	return 0
    endif
endfunction "}}}
"}}}
"MAIN "{{{
"======================================================================
" TODO: load by s:cache_name 
" TODO: load theme with specified name
function! galaxy#load_scheme(name,...) "{{{
    let s:cache_name=a:name
    " let s:cache_num=a:num
    call s:set_scheme_list()
    " if s:cache_num >= len(s:scheme_list)
    "     let s:cache_num=0
    " endif
    if s:cache_name ==""
        let s:cache_name=s:scheme_list[0].name
    endif

    for scheme in s:scheme_list
    	if scheme.name == s:cache_name
            let s:scheme_dict=scheme
        endif
    endfor
    if !exists("s:scheme_dict") 
        " call s:error("Could not find scheme:".s:cache_name)
        let s:scheme_dict=s:scheme_list[0]
    endif
    let [s:h,s:s,s:v]=ColorV#hex2hsv(s:scheme_dict.colors[4])
    call s:set_miscs()
    call s:generate_colors()

    if exists("s:scheme_dict.style") && !empty(s:scheme_dict.style)
        let s:style_name=s:scheme_dict.style
    else
    	let s:style_name=""
    endif

    
    " predefined highlights + scheme theme highlights
    call s:get_style_hl(s:style_name)
    call s:high_list(s:hl_scheme)
    " predefined highlights
    " call s:high_list(s:lnk_list)
    " predefined syntax highlights
    for list in values(s:synlink_dict)
        call s:high_list(list)
    endfor
    " the scheme defined highlights
    if exists("s:scheme_dict.highlights")
        call s:high_list(s:scheme_dict.highlights)
    endif

    call s:statusline_aug()

    let g:colors_name = "galaxy"
    let g:galaxy_name = s:scheme_dict.name
    if !exists("a:1") || a:1!="START"
        call galaxy#write_cache()
        redraw
        if !empty(s:style_name)
            echom "Galaxy Scheme:\"".g:galaxy_name."\" loaded. With style:" .s:style_name."."
        else
            echom "Galaxy Scheme:\"".g:galaxy_name."\" loaded."
        endif
    endif
endfunction "}}}
function! galaxy#load_scheme16(name) "{{{
    let s:cache_name=a:name
    " let s:cache_num=a:num
    call s:set_scheme_list()
    " if s:cache_num >= len(s:scheme_list)
    "     let s:cache_num=0
    " endif
    for scheme in s:scheme_list
    	if scheme.name == s:cache_name
            let s:scheme_dict=scheme
        endif
    endfor
    if !exists("s:scheme_dict") 
        call s:error("Could not find scheme:".s:cache_name)
    	let s:scheme_dict=s:scheme_list[0]
    endif
    let [s:h,s:s,s:v]=ColorV#hex2hsv(s:scheme_dict.colors[4])
    call s:set_miscs()
    if &t_Co==16
        if s:v <=50
            let s:hl_scheme=s:term16_dark_hl_list+s:link_list
        else
            let s:hl_scheme=s:term16_hl_list+s:link_list
        endif
    else
        if s:v <=50
            let s:hl_scheme=s:term8_dark_hl_list+s:link_list
        else
            let s:hl_scheme=s:term8_hl_list+s:link_list
        endif
    endif
    call s:high_list(s:hl_scheme,"NOCHECK")

    call s:statusline_term16_aug()

    for [key,list] in items(s:synlink_dict)
    	if key != "vimwiki2"
            call s:high_list(list)
        endif
    endfor
    for [key,list] in items(s:synlink_term_dict)
        call s:high_list(list,"NOCHECK")
    endfor
    let g:colors_name = "galaxy"
    let g:galaxy_name = s:scheme_dict.name
endfunction "}}}
function! galaxy#next_scheme(...) "{{{
    if exists("a:1") && a:1 == "-"
    	let s:cache_num-=1
    else
        let s:cache_num+=1
    endif

    if s:cache_num >= len(s:scheme_list)
    	let s:cache_num=0
    elseif s:cache_num < 0
    	let s:cache_num  = len(s:scheme_list)-1
    endif
    let num=s:cache_num
    let name =s:scheme_list[num].name
    " let g:GALAXY_THEME_NUM=s:cache_num
    if !has("gui_running") && (&t_Co==8 || &t_Co==16)
        call galaxy#load_scheme16(name)
    else
        " let s:cached_theme_list=galaxy#load_file(g:galaxy_cache_File)
        call galaxy#load_scheme(name)
    endif
    " colorscheme galaxy
endfunction "}}}
"}}}
"INIT "{{{
"======================================================================
let s:cached_theme_list=galaxy#load_file(g:galaxy_cache_File)
if !has("gui_running") && &t_Co<=16
    call galaxy#load_scheme16(s:cache_name)
else
    call galaxy#load_scheme(s:cache_name,"START")
endif

"
aug galaxy_vim_leave "{{{
    au!
    au VIMLEAVEPre * call galaxy#write_cache()
aug END "}}}
"}}}
