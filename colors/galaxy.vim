"=============================================================
"  Script: Galaxy 
"    File: colors/galaxy.vim
" Summary: A colorscheme that thousands shemes within.
"  Author: Rykka <Rykka10(at)gmail.com>
" Last Update: 2012-01-22
"=============================================================
let s:save_cpo = &cpo
set cpo&vim

call galaxy#init()
 
let &cpo = s:save_cpo
unlet s:save_cpo
" vim:tw=78:fdm=marker:
