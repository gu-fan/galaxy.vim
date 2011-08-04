" Description:	Galaxy, A colour scheme generate system
" Author:	Rykka.Krin <Rykka.krin@gmail.com>

if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

if !has("gui_running")
    " if &term == "xterm"
        let s:galaxy_t_co=256
        set t_Co=256
    " endif
endif
" if !exists("g:ColorV")
"     echoe "Galaxy depends on ColorV.vim. Please install it first"
"     finish
" endif

" VARIABLE INIT "{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:galaxy_cache_File = expand('$HOME') . '/.vim_galaxy_cache'
if has("win32") || has("win64")
    let g:galaxy_store_Folder = expand('$HOME') . '/vimfile/colors/galaxy/'
else
    let g:galaxy_store_Folder = expand('$HOME') . '/.vim/colors/galaxy/'
endif
let g:galaxy={}
let g:galaxy.name="[GALAXY]"
let g:galaxy.win_pos="bot"
" dif_v=bg_v+v_step
" syn_v=fg_v
" ech_v=fg_v+v_step
" name            bg       fg       dif      syn      ech
" DONE: 110804  change the sequence of  the colors
"               fg syn ech bg dif
" galaxy
" TODO: 2! color => 5 color
" DONE: 110804  color name with dict
" bg / fg
" 
let s:default_list=[
            \{"name":"Paper_And_Pen",
            \"colors":["3B3C40","3D5566","7F1C1C","CACCC2","CC9085"],
            \},
            \{"name":"Ubuntu",
            \"colors":["99918A","A6644B","BF2A2A","2E1722","261D23"]},
            \{"name":"Bsm_simple",
            \"colors":["979799","637EA6","A62424","2D2D2D","263B40"]},
            \{"name":"Spring",
            \"colors":["575759","31568C","7F1C1C","CBE5A1","B8D998"]},
            \{"name":"SlateGray",
            \"colors":["8F8FA6","5BA65E","A62424","475059","57D9CA"]},
            \{"name":"Darker",
            \"colors":["7E7E7F","4268A6","A62424","191919","1E444D"]},
            \{"name":"Butterscream",
            \"colors":["3D4E66","547799","992222","FFFFD9","D9C8B8"]},
            \{"name":"Village",
            \"colors":["402020","2E4873","234006","A1E58A","F2D530"],
            \"theme":"coloring"},
            \{"name":"SkyBlue",
            \"colors":["333317","7F4654","990808","B6F2F2","E58ADE"],
            \},
            \]

let s:scheme_theme_list=
\[
    \{"name":"shadowing",
    \"highlights":[
        \]
    \},
    \{"name":"coloring",
    \"highlights":[
        \["Wildmenu",       "echclr3",  "fgdclr3",  "b"     ],
        \["Pmenu",          "bgdclr0",  "fgdclr2",  "n"     ],
        \["PmenuSel",       "fgdclr2",  "echclr1",  "rb"    ],
        \["PmenuSbar",      "bgdclr1",  "fgdclr0",  "n"     ],
        \["PmenuThumb",     "bgdclr2",  "fgdclr0",  "n"     ],
        \["Folded",         "bgdclr2",  "bgdclr6",  "n"     ],
        \["tabline",        "bgdclr2",  "bgdclr6",  "n"     ],
        \["tablinesel",     'difclr0',  "fgdclr2",  "b"     ],
        \["tablinefill",    "fgdclr2",  "bgdclr6",  "n"     ],
        \["StatusLine",     "difclr0",  "fgdclr2",  "b"     ],
        \["StatusLineNC",   "bgdclr2",  "fgdclr2",  "n"     ],
        \["User1",          "echclr0",  "fgdclr2",  "b"     ],
        \["User2",          "echclr1",  "fgdclr2",  "b"     ],
        \["User3",          "echclr2",  "fgdclr2",  "b"     ],
        \["User4",          "echclr3",  "fgdclr2",  "b"     ],
        \["User5",          "echclr4",  "fgdclr2",  "b"     ],
        \["User6",          "echclr5",  "fgdclr2",  "b"     ],
        \["User7",          "echclr6",  "fgdclr2",  "b"     ],
        \["User8",          "echclr7",  "fgdclr2",  "b"     ],
        \["User9",          "echclr8",  "fgdclr2",  "b"     ],
        \["MoreMsg",        "echclr5",  "bgdclr4",  "b"     ],
        \["Question",       "echclr4",  "bgdclr4",  "b"     ],
        \["ModeMsg",        "echclr3",  "bgdclr4",  "b"     ],
        \["MatchParen",     "echclr2",  "bgdclr4",  "br"    ],
        \["WarningMsg",     "echclr1",  "bgdclr4",  "br"    ],
        \["ErrorMsg",       "echclr0",  "bgdclr4",  "br"    ],
        \["Error",          "echclr0",  "bgdclr4",  "br"    ],
        \["Todo",           "echclr2",  "nocolor",  "br"    ],
        \["Title",          "difclr1",  "nocolor",  "b"     ],
        \]  
    \}
\] 
 
"}}}

" DONE: 110803  " Quick switch style key mapping.
" TEXT FORMTATOR "{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:gui             = "gui"
let s:term            = "term"
let s:cterm           = "cterm"
let s:nocolor         = "NONE"
let s:nulldef         = ""
let s:n               = "NONE"
let s:c               = ",undercurl"
let s:r               = ",reverse"
let s:s               = ",standout"
let s:b               = ",bold"
let s:u               = ",underline"
let s:i               = ",italic"
"}}}
" UI HIGHLIGHTING "{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"input [["Normal","fg","bg","fmt"],...]
"" TODO: pcterm/xterm/cygwin... support
if has("gui_running")
    let s:mode=s:gui
else
    let s:mode=s:cterm
endif
" DONE: 110803  " one function with link and highlight
" function! s:link_list(list) "{{{
"     let list=a:list
"     for [hl_from,hl_to] in list
"     	exec "hi! link ".hl_from." ".hl_to
"     endfor
" endfunction "}}}

"{{{ clr_list
" TODO:
" hl Themes
" shadow and light
" colored grid

let s:clr_list=[
            \["Normal",         "fgdclr0",  "bgdclr0",  "n"     ],
            \["Cursor",         "fgdclr0",  "bgdclr0",  "r"     ],
            \["CursorLine",     "nocolor",  "bgdclr2",  "n"     ],
            \["Visual",         "nocolor",  "bgdclr2",  "n"     ],
            \["Wildmenu",       "echclr1",  "bgdclr2",  "b"     ],
            \["Pmenu",          "fgdclr1",  "bgdclr1",  "n"     ],
            \["PmenuSel",       "fgdclr0",  "bgdclr0",  "rb"    ],
            \["PmenuSbar",      "fgdclr1",  "bgdclr1",  "n"     ],
            \["PmenuThumb",     "bgdclr0",  "bgdclr2",  "n"     ],
            \["DiffAdd",        "nocolor",  "difclr2",  "n"     ],
            \["DiffChange",     "nocolor",  "difclr1",  "n"     ],
            \["DiffDelete",     "bgdclr0",  "difclr0",  "n"     ],
            \["DiffText",       "nocolor",  "difclr0",  "n"     ],
            \["Folded",         "fgdclr1",  "bgdclr1",  "n"     ],
            \["tabline",        "bgdclr0",  "bgdclr4",  "n"     ],
            \["tablinesel",     'fgdclr0',  "bgdclr0",  "b"     ],
            \["tablinefill",    "bgdclr0",  "bgdclr2",  "n"     ],
            \["StatusLine",     "synclr0",  "bgdclr3",  "b"     ],
            \["StatusLineNC",   "bgdclr0",  "bgdclr3",  "n"     ],
            \["User1",          "echclr0",  "bgdclr3",  "b"     ],
            \["User2",          "echclr1",  "bgdclr3",  "b"     ],
            \["User3",          "echclr2",  "bgdclr3",  "b"     ],
            \["User4",          "echclr3",  "bgdclr3",  "b"     ],
            \["User5",          "echclr4",  "bgdclr3",  "b"     ],
            \["User6",          "echclr5",  "bgdclr3",  "b"     ],
            \["User7",          "echclr6",  "bgdclr3",  "b"     ],
            \["User8",          "echclr7",  "bgdclr3",  "b"     ],
            \["User9",          "echclr8",  "bgdclr3",  "b"     ],
            \["Search",         "nocolor",  "nocolor",  "u"     ],
            \["IncSearch",      "nocolor",  "echclr2",  "b"     ],
            \["MoreMsg",        "echclr5",  "nocolor",  "b"     ],
            \["Question",       "echclr4",  "nocolor",  "b"     ],
            \["ModeMsg",        "echclr3",  "nocolor",  "b"     ],
            \["MatchParen",     "echclr2",  "nocolor",  "br"    ],
            \["WarningMsg",     "echclr1",  "nocolor",  "br"    ],
            \["ErrorMsg",       "echclr0",  "nocolor",  "br"    ],
            \["Error",          "echclr0",  "nocolor",  "br"    ],
            \["Todo",           "echclr1",  "nocolor",  "br"    ],
            \["Title",          "fgdclr0",  "nocolor",  "b"     ],
            \["Conceal",        "fgdclr1",  "nocolor",  "n"     ],
            \["Comment",        "bgdclr3",  "nocolor",  "n"     ],
            \["SpecialComment", "bgdclr4",  "nocolor",  "b"     ],
            \["Underlined",     "synclr0",  "nocolor",  "u"     ],
            \["Keyword",        "synclr0",  "nocolor",  "b"     ],
            \["Statement",      "synclr0",  "nocolor",  "n"     ],
            \["Exception",      "synclr1",  "nocolor",  "bi"    ],
            \["SpecialChar",    "synclr1",  "nocolor",  "b"     ],
            \["PreProc",        "synclr1",  "nocolor",  "b"     ],
            \["Special",        "synclr1",  "nocolor",  "n"     ],
            \["Type",           "synclr2",  "nocolor",  "n"     ],
            \["Identifier",     "synclr2",  "nocolor",  "b"     ],
            \["Constant",       "synclr3",  "nocolor",  "n"     ],
            \["Function",       "synclr4",  "nocolor",  "b"     ],
            \["String",         "synclr4",  "nocolor",  "n"     ],
            \["Label",          "synclr4",  "nocolor",  "b"     ],
            \] 
"}}}
"lnk_list "{{{
let s:lnk_list=[
            \["CursorColumn",   "CursorLine"    ],
            \["FoldColumn",     "Folded"        ],
            \["LineNr",         "Folded"        ],
            \["SignColumn",     "Folded"        ],
            \["ColorColumn",    "Folded"        ],
            \["VertSplit",      "StatusLineNC"  ],
            \["VisualNOS",      "Visual"        ],
            \["NonText",        "Comment"       ],
            \["Ignore",         "Comment"       ],
            \["Conditional",    "Statement"     ],
            \["Operator",       "Statement"     ],
            \["Repeat",         "Statement"     ],
            \["Delimiter",      "Special"       ],
            \["Boolean",        "Constant"      ],
            \["Float",          "Constant"      ],
            \["Number",         "Constant"      ],
            \["Character",      "String"        ],
            \["Define",         "PreProc"       ],
            \["Macro",          "PreProc"       ],
            \["Include",        "PreProc"       ],
            \["Directory",      "Type"          ],
            \["StorageClass",   "Identifier"    ],
            \["Structure",      "Type"          ],
            \["PreCondit",      "Exception"     ],
            \["Debug",          "Exception"     ],
            \["SpecialKey",     "SpecialChar"   ],
            \["Tag",            "SpecialChar"   ],
            \["SpellBad",       "ErrorMsg"      ],
            \["SpellCap",       "ErrorMsg"      ],
            \["SpellLocal",     "WarningMsg"    ],
            \["SpellRare",      "WarningMsg"    ],
            \] "}}}
" call s:high_list(s:clr_list)
" call s:link_list(s:lnk_list)
" theme light statusline
" 
"}}}
" VARIOUS SYNTAX "{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:synlink_dict={}
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

" settings
"======================================================================


" COLOR GENERATOR "{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"INCLUDE COLORV.vim
" DONE: 110728  cterm support with colormath python 
" TODO: blue color brighteness compensate +
"}}}
function! s:generate_colors() "{{{

let s:fgdclr_list=ColorV#gen_list(s:scheme_dict.colors[0],"Value",9,(-s:v_step*8))
for i in range(9)
    if has("gui_running")
        let s:fgdclr{i} = s:fgdclr_list[i]
    else
    	let s:fgdclr{i} = ColorV#hex2term(s:fgdclr_list[i])
    endif
endfor


let s:synclr_list=ColorV#gen_list(s:scheme_dict.colors[1],"Hue",9,72)
for i in range(9)
    if has("gui_running")
        let s:synclr{i} = s:synclr_list[i]
    else
    	let s:synclr{i} = ColorV#hex2term(s:synclr_list[i])
    endif
endfor

let char_list="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let s:echclr_list=ColorV#gen_list(s:scheme_dict.colors[2],"Neutral",20)
for i in range(20)
    let char=char_list[i]
    if has("gui_running")
        let s:echclr{char} = s:echclr_list[i]
    else
    	let s:echclr{char} = ColorV#hex2term(s:echclr_list[i])
    endif
endfor
" TODO: error of background lightness output 000000
let s:bgdclr_list=ColorV#gen_list(s:scheme_dict.colors[3],"Value",9,s:v_step*5)
for i in range(9)
    if has("gui_running")
        let s:bgdclr{i} = s:bgdclr_list[i]
    else
    	let s:bgdclr{i} = ColorV#hex2term(s:bgdclr_list[i])
    endif
endfor
let s:difclr_list=ColorV#gen_list(s:scheme_dict.colors[4],"Tetradic",4)
for i in range(4)
    if has("gui_running")
        let s:difclr{i} = s:difclr_list[i]
    else
    	let s:difclr{i} = ColorV#hex2term(s:difclr_list[i])
    endif
endfor
endfunction "}}}

function! s:high_list(list) "{{{ 
    let list=a:list
    for item in list
        if len(item) == 4 
            let [hl_grp,hl_fg,hl_bg,hl_fm]=item
        " for [hl_grp,hl_fg,hl_bg,hl_fm] in list

            "let fm_txt  = hl_fm=~'n' ? "NONE" : ""
            
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

            " let fg_txt = exists("s:{hl_fg}") ? s:{hl_fg} : s:fgdclr0
            let fg_txt = hl_fg =~ '\x\{6}' || empty(hl_fg) ? hl_fg :
                        \ exists("s:{hl_fg}") ? s:{hl_fg} : s:fgdclr0
            " echom hl_fg fg_txt
            " let bg_txt = exists("s:{hl_bg}") ? s:{hl_bg} : s:bgdclr0
            let bg_txt = hl_bg =~ '\x\{6}' || empty(hl_bg) ? hl_bg :
                        \ exists("s:{hl_bg}") ? s:{hl_bg} : s:bgdclr0

            
            if has("gui_running")
                let fg_txt = fg_txt =~ '^\x\{6}$' ? "#".fg_txt : fg_txt
                let bg_txt = bg_txt =~ '^\x\{6}$' ? "#".bg_txt : bg_txt
            else
                " DONE: 110728   calculate fg/bg_txt for terminal
                let fg_txt= fg_txt =~ '\x\{6}$' ? ColorV#hex2term(fg_txt) : fg_txt
                let bg_txt= bg_txt =~ '\x\{6}$' ? ColorV#hex2term(bg_txt) : bg_txt
        " echom hl_fg fg_txt
            endif

            let fg_txt = empty(fg_txt) ? "" : s:mode."fg=".fg_txt." "
            let bg_txt = empty(bg_txt) ? "" : s:mode."bg=".bg_txt." "
            let fm_txt = empty(fm_txt) ? "" : s:mode."=".fm_txt
            if !empty(fg_txt) || !empty(bg_txt) || !empty(fm_txt)
                exec "hi! ".hl_grp." ".fg_txt.bg_txt.fm_txt
                " echom hl_grp fg_txt fm_txt
            endif

        " endfor
        elseif len(item) == 2 
            let [hl_from,hl_to]=item
            exec "hi! link ".hl_from." ".hl_to
        endif
    endfor
endfunction "}}} 

" STATUSLINE BLINK "{{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"}}}
" TODO: color changing with time
" TODO: random color scheme generator
function! s:statusline_aug() "{{{
if version >= 700 "{{{
        " DONE: 110804  let the insert mode with themes
    if s:theme_name=="coloring"
        let s:list_insert_enter=[
            \["Cursor",         "difclr0",  "bgdclr0",  "r"     ],
            \["StatusLine",     "fgdclr3",  "difclr0",  "b"     ],
            \["User1",          "echclr0",  "difclr0",  "b"     ],
            \["User2",          "echclr1",  "difclr0",  "b"     ],
            \["User3",          "echclr2",  "difclr0",  "b"     ],
            \["User4",          "echclr3",  "difclr0",  "b"     ],
            \["User5",          "echclr4",  "difclr0",  "b"     ],
            \["User6",          "echclr5",  "difclr0",  "b"     ],
            \["User7",          "echclr6",  "difclr0",  "b"     ],
            \["User8",          "echclr7",  "difclr0",  "b"     ],
            \["User9",          "echclr8",  "difclr0",  "b"     ],
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
        " let s:list_insert_leave=[
        "     \["Cursor",         "fgdclr0",  "bgdclr0",  "r"     ],
        "     \["StatusLine",     "fgdclr0",  "bgdclr3",  "b"     ],
        "     \["User1",          "echclr0",  "bgdclr3",  "b"     ],
        "     \["User2",          "echclr1",  "bgdclr3",  "b"     ],
        "     \["User3",          "echclr2",  "bgdclr3",  "b"     ],
        "     \["User4",          "echclr3",  "bgdclr3",  "b"     ],
        "     \["User5",          "echclr4",  "bgdclr3",  "b"     ],
        "     \["User6",          "echclr5",  "bgdclr3",  "b"     ],
        "     \["User7",          "echclr6",  "bgdclr3",  "b"     ],
        "     \["User8",          "echclr7",  "bgdclr3",  "b"     ],
        "     \["User9",          "echclr8",  "bgdclr3",  "b"     ],
        "     \]
        " DONE: 110804  let s:list_insert_leave auto copy the current scheme
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
        " au InsertEnter <buffer> call s:hl_list(s:list_insert_enter)
        " au InsertLeave <buffer> call s:hl_list(s:list_insert_leave)
    aug END
    " TODO: terminal cursor color changing
    "terminal cursor is another thing
    " set t_fs=(B
    " set t_IE=(B
    " if &term =~ "xterm"
    "   silent !echo -ne "\e]12;Grey\007"
    "   let &t_SI="\e]12;RoyalBlue1\007"
    "   let &t_EI="\e]12;Grey\007"
    "   autocmd VimLeave * :!echo -ne "\e]12;green\007"
    " endif
endif "}}}
endfunction "}}}

" DONE: 110731  statusline color define in one place
" guifg=NONE and 'null' define of guifg(that will suceed previous value )
" TODO: change theme with specified name
function! s:set_miscs() "{{{
" set background after highlight Normal group

    if s:v<=50
    	"FIXED: 110803  reload error E127
    "seems set background will reload the colorscheme.
    	" unlet it or colorscheme will be reloaded.
    	if exists("g:colors_name")
            unlet g:colors_name 
        endif
        set background=dark
        " echoe "dark"
        let s:v_step=1
    else
    	if exists("g:colors_name")
            unlet g:colors_name 
        endif
        set background=light
        " echoe "light"
        let s:v_step=-1
    endif
" echo "theme of galaxy:".g:galaxy_name
    " set background
endfunction "}}}
" DONE: 110804  theme could use schemes 
function! s:get_theme_hl_list(theme) "{{{
    let s:hl_scheme=deepcopy(s:clr_list)
    for scheme in s:scheme_theme_list
        if a:theme == scheme.name
            let s:hl_scheme += scheme.highlights
        endif
    endfor
endfunction "}}}
   
" DONE: 110731  switch with usr list
" TODO: set with presistence file
function! s:set_scheme_list() "{{{
    "FIXED: 110803  next theme loading error repeating in the global list
    " hardcopy it 
    let s:scheme_list=deepcopy(s:default_list)

" DONE: 110804  add the g:galaxy_usr_dict and execute it
" " TODO: deprecate using g:. using serialzd file instead.
    if exists("g:galaxy_scheme_list") && !empty(g:galaxy_scheme_list)

        for i in range(len(g:galaxy_scheme_list))
            if exists("g:galaxy_scheme_list[".i."].name") 
                        \ && exists("g:galaxy_scheme_list[".i."].colors")
                        \ && len(g:galaxy_scheme_list[i].colors)==5
                
            " if !empty(g:galaxy_scheme_list[i].name)
            "             \ && len(g:galaxy_scheme_list[i].colors)==5
                call add(s:scheme_list, g:galaxy_scheme_list[i])
            else
                continue
            endif
        endfor
" DONE: 110803  presisitence of the s:num which will load it last time
" let s:num = exists("g:GALAXY_THEME_NUM") ? g:GALAXY_THEME_NUM : 0
" it's not defined when colorscheme loaded!
" use cache instead?
        " DONE: 110803  store it in cache or it would not load when starting
        " Don't let it be mixed with g:
    elseif exists("s:cached_theme_list") &&  !empty(s:cached_theme_list)

        for i in range(len(s:cached_theme_list))
            if exists("s:cached_theme_list[".i."].name") 
                        \ && exists("s:cached_theme_list[".i."].colors")
                        \ && len(s:cached_theme_list[i].colors)==5
                
                call add(s:scheme_list, s:cached_theme_list[i])
            else
                continue
            endif
        endfor
    endif
    if exists("g:galaxy_load_store") && g:galaxy_load_store ==1
    	if exists("s:stored_theme_list") &&  !empty(s:stored_theme_list)
    	    let s:scheme_list=deepcopy(s:default_list)
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
    endif
    " DONE: 110731  switch with keymapping
    " TODO: internet color/scheme server 
    " upload/download
    " random
    " rating/comment
    " Kuler access?
endfunction "}}}

" DONE: 110804  load cache and g: highlights and themes
" TODO: load by name here
function! galaxy#load_scheme(num,...) "{{{
    let s:num=a:num
    call s:set_scheme_list()
    if s:num >= len(s:scheme_list)
        let s:num=0
    endif
    " let g:GALAXY_THEME_NUM=s:num
    let s:scheme_dict=s:scheme_list[s:num]
    let [s:h,s:s,s:v]=ColorV#hex2hsv(s:scheme_dict.colors[4])
    " echoe h s v
        " set background
    " let colors_name = "galaxy".s:scheme_dict.name
    let g:colors_name = "galaxy"
    let g:galaxy_name = s:scheme_dict.name
    call s:set_miscs()
    call s:generate_colors()

    if exists("s:scheme_dict.theme") && !empty(s:scheme_dict.theme)
        let s:theme_name=s:scheme_dict.theme
    else
    	let s:theme_name=""
    endif

    
    " predefined highlights + scheme theme highlights
    call s:get_theme_hl_list(s:theme_name)
    call s:high_list(s:hl_scheme)
    " predefined highlights
    call s:high_list(s:lnk_list)
    " predefined syntax highlights
    for list in values(s:synlink_dict)
        call s:high_list(list)
    endfor
    " the scheme defined highlights
    if exists("s:scheme_dict.highlights")
        call s:high_list(s:scheme_dict.highlights)
    endif

    call s:statusline_aug()

    if !exists("a:1") || a:1!="NOWRITE"
        call galaxy#write_cache()
        redraw
        " WORKAROUND: will show mes box when vim start.
        if !empty(s:theme_name)
            echom "galaxy scheme:\"".g:galaxy_name."\" loaded with theme:"
                        \.s:theme_name."."
        else
            echom "galaxy scheme:\"".g:galaxy_name."\" loaded."
        endif
    endif
endfunction "}}}
function! galaxy#next_scheme(...) "{{{
    if exists("a:1") && a:1 == "-"
    	let s:num-=1
    else
        let s:num+=1
    endif

    " for x in range(len(s:scheme_list))

    " endfor
    if s:num >= len(s:scheme_list)
    	let s:num=0
    elseif s:num < 0
    	let s:num  = len(s:scheme_list)-1
    endif
    let num=s:num
    " let g:GALAXY_THEME_NUM=s:num
    call galaxy#load_scheme(num)
    " colorscheme galaxy
endfunction "}}}
" DONE: 110804  presistence file load
" TODO: the file sequence maybe different
nmap <leader>gll :call <SID>load_stored()<cr>
function! s:load_stored() "{{{
    let folder =  expand(g:galaxy_store_Folder)
    let s:file_list=split(globpath(folder, '*.galaxy'), '\n')
    " echoe folder isdirectory(folder) string(s:file_list)
    let s:stored_theme_list= []
    if isdirectory(folder)
        for file in s:file_list
            " echoe file
            " call galaxy#load_cache(file)
            " let tmp =
            let s:stored_theme_list +=  galaxy#load_cache(file)
            " call add(s:stored_theme_list,s:cached_theme_list)
            " echoe string(s:cached_theme_list)
        endfor
    endif
    " echoe string(s:stored_theme_list)
endfunction "}}}

" TODO: show scheme list
nmap <leader>glw :call <SID>scheme_window()<cr>
function! s:scheme_window()
    " window check "{{{
    if bufexists(g:galaxy.name) 
    	let nr=bufnr('\[GALAXY\]')
    	let winnr=bufwinnr(nr)
        if winnr>0 && bufname(nr)==g:galaxy.name
            if bufwinnr('%') ==winnr
            	if g:galaxy.win_pos=~'bo\%[tright]'
                    exec winnr."wincmd J"
                elseif g:galaxy.win_pos=~'to\%[pleft]'
                    exec winnr."wincmd K"
                endif
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
    " local setting 
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
    nmap <silent><buffer> q :call galaxy#exit_win()<cr>
    nmap <silent><buffer> Q :call galaxy#exit_win()<cr>
    map <silent><buffer> <enter> :call <SID>win_load_scheme()<cr>
    map <silent><buffer> <space> :call <SID>win_load_scheme()<cr>
    map <silent><buffer> <2-leftmouse> :call <SID>win_load_scheme()<cr>
    "}}}
    let StringList = []
    " echoe string(s:scheme_list)
    let m = "NAME"
    let m = s:line_sub(m,"FORE",20)
    let m = s:line_sub(m,"SYNTAX",27)
    let m = s:line_sub(m,"MSG",34)
    let m = s:line_sub(m,"BACK",41)
    let m = s:line_sub(m,"DIFF",48)
    let m = s:line_sub(m,"THEME",60)
    call add(StringList,m)
    for scheme in s:scheme_list
        " echoe string(scheme.colors)
        let colors=""
        for color in scheme.colors
            let colors .= color." "
        endfor
        let name = scheme.name
        let theme = exists("scheme.theme") ? scheme.theme : ""
        let m = strpart(name,0,16)
        let m = s:line_sub(m,colors,20)
        let m = s:line_sub(m,theme,60)
        call add(StringList,m)
    endfor
    " echoe StringList
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
endfunction
function! s:on_cursor_moved()  "{{{
    execute 'match' (line('.') > 1 ? "ErrorMsg".' /\%'.line('.').'l\%<17c/' : 
                \ 'Title /\%'.line('.').'l/' )
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
function! s:win_load_scheme() "{{{
    let linenum=line('.')
    if linenum==1
    	echo "Please move down your mouse."
    	return
    else
        call galaxy#load_scheme(linenum-2,"NOWRITE")
    endif

endfunction "}}}
function! galaxy#exit_win() "{{{
    if bufexists(g:galaxy.name) 
    	let nr=bufnr('\[GALAXY\]')
    	let winnr=bufwinnr(nr)
        if winnr>0 && bufname(nr)==g:galaxy.name
            if bufwinnr('%') == winnr && expand('%') ==g:galaxy.name
                call s:echo("Close [GALAXY].")
                bd
            else
            	"Becareful
                exec winnr."wincmd w"
                if expand('%') ==g:galaxy.name
                    call s:echo("Close existing [GALAXY].")
                    bd
                endif
            endif
        endif    
    endif
    redraw
endfunction "}}}
function! s:echo(msg) "{{{
    if g:ColorV_silent_set==0
        exe "echom \"[Note] ".escape(a:msg,'"')."\""
    else
    	echom ""
    endif
endfunction "}}}
function! galaxy#load_cache(...) "{{{
    if exists("a:1") && !empty(a:1)
    	let file = a:1
    else
        let s:num = 0
    	let file = g:galaxy_cache_File
    endif
    if filereadable(file)
        let CacheStringsList = readfile(file)
        " if !exists("s:cached_theme_list") 
            let l:cached_theme_list=[]
        " endif
        " let l:color_exists=0
        for i in CacheStringsList
            if i =~ 'CACHE_NUM' 
            	let num = matchstr(i,'CACHE_NUM\s*\zs.*\ze\s*')
                let s:num = num
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
                " echoe "colors:" len(l:tmp_dict.colors)
                    let l:color_exists=1
                else
                    let l:color_exists=0
                endif
                " echom c string(s:cached_theme_list[c].colors)
            endif
            if i =~ 'GALAXY_THEME'
                let l:tmp_dict.theme = 
                            \matchstr(i,'GALAXY_THEME\s*\zs.*\ze\s*')
                            
                " echom c string(s:cached_theme_list[c].colors)
            endif
            if i =~ 'GALAXY_HIGH' 
            	let highlights = matchstr(i,'GALAXY_HIGH\s*\zs.*\ze\s*')
            	let l:tmp_dict.highlights = []
            	call add(l:tmp_dict.highlights,split(highlights,'\s'))
            endif
            " TODO: it's loop in each line. need a stop for a galaxy structure
            if i =~ 'GALAXY_END' 
            	if exists("l:color_exists") && l:color_exists==1
            	    " echoe "!!!! tmp:" string(l:tmp_dict)
                    call add(l:cached_theme_list,deepcopy(l:tmp_dict))
                endif
            " echoe string(l:tmp_dict)
            " else
            	unlet l:tmp_dict
            endif
        endfor
        return l:cached_theme_list
    else
    	return 0
    endif
endfunction "}}}
" 
" TODO: presistence files write with command
" and should remove the cache
function! s:write_store()
    
    let CacheStringsList = []
    if !isdirectory(expand(g:galaxy_store_Folder))
        call mkdir(expand(g:galaxy_store_Folder))
    endif
    if exists("g:galaxy_scheme_list") && !empty(g:galaxy_scheme_list)
        for scheme in g:galaxy_scheme_list
            if len(scheme.colors)==5
                call add(CacheStringsList,"GALAXY_NAME\t".scheme.name)
                call add(CacheStringsList,
                            \"GALAXY_COLORS\t" 
                            \.scheme.colors[0]." "
                            \.scheme.colors[1]." "
                            \.scheme.colors[2]." "
                            \.scheme.colors[3]." "
                            \.scheme.colors[4])

                if exists("scheme.theme") 
                    call add(CacheStringsList,"GALAXY_THEME\t".scheme.theme)
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
                if exists("a:1") && a:1 =="galaxy"
                    let file = g:galaxy_store_Folder . scheme.name. ".galaxy"
                    call writefile(CacheStringsList, file)
                    let CacheStringsList=[]
                endif
            endif
        endfor
    endif
endfunction
function! galaxy#write_cache(...) "{{{

    let CacheStringsList = []
    if exists("a:1") && a:1 =="galaxy"
        if !isdirectory(expand(g:galaxy_store_Folder))
            call mkdir(expand(g:galaxy_store_Folder))
        endif
    	" if exists("g:galaxy_scheme_list") && !empty(g:galaxy_scheme_list)
            " let file = g:galaxy_store_Folder . g:galaxy_scheme_list[0].name
        " endif
        " TODO: each name with one file
    else
        call add(CacheStringsList,"CACHE_NUM\t".s:num)
        call add(CacheStringsList,"CACHE_NAME\t".s:scheme_dict.name)
        call add(CacheStringsList,"")
    endif
    " add g:galaxy_scheme_list to cache
    if !exists("a:1") || a:1 !="galaxy"
        let file = g:galaxy_cache_File
        call writefile(CacheStringsList, file)
    endif
endfunction "}}}



let s:cached_theme_list=galaxy#load_cache()
call galaxy#load_scheme(s:num,"NOWRITE")
nmap <leader>gln :call galaxy#next_scheme()<cr>
nmap <leader>glp :call galaxy#next_scheme("-")<cr>
nmap <leader>glx :call galaxy#write_cache("galaxy")<cr>
"
aug galaxy_vim_leave "{{{
    au!
    au VIMLEAVEPre * call galaxy#write_cache()
    " au VIMLEAVEPre * echoe "eee"

aug END "}}}

