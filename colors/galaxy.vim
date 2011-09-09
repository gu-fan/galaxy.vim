"=============================================================
"  Script: Galaxy 
"    File: colors/galaxy.vim
" Summary: Generate your scheme with your fav color.
"  Author: Rykka.Krin <Rykka.Krin(at)gmail.com>
" Last Update: 2011-09-10
"=============================================================
let s:save_cpo = &cpo
set cpo&vim
"INIT "{{{
"======================================================================
if !exists('g:galaxy_term_color') "{{{
    let g:galaxy_term_color=0
endif
if !exists('g:galaxy_term_check')
    let g:galaxy_term_check=1
endif "}}}
"  XXX:Don't know how to get these Terminal's color actual support
if !has("gui_running") && g:galaxy_term_color > 0  "{{{
    let &t_Co=g:galaxy_term_color
elseif !has("gui_running") && g:galaxy_term_check == 1 
    if &term == "win32" 
        \ || &term =="ansi" 
        \ || &term =="os2ansi" || &term=="vt52"
        set t_Co=16
    elseif &term=="linux" || &term == "pcterm" || 
                \ (&term=="xterm-color" && has("gui_mac"))
        set t_Co=8
    else
    	set t_Co=256
    endif
endif "}}}
"{{{load cache
if !has("gui_running") && &t_Co<=16
    call galaxy#load_scheme16("","START")
else
    call galaxy#load_scheme("","START")
endif
"}}}
"
aug galaxy_vim_leave "{{{
    au!
    au VIMLEAVEPre * call galaxy#write_cache()
aug END "}}}
"}}}
let &cpo = s:save_cpo
unlet s:save_cpo
" vim:tw=78:fdm=marker:
