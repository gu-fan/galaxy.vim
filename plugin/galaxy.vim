"=============================================================
"  Script: Galaxy 
"    File: plugin/galaxy.vim
" Summary: A colorscheme that makes scheming colors easy.
"  Author: Rykka <Rykka10(at)gmail.com>
" Last Update: 2012-03-16
"=============================================================
let s:save_cpo = &cpo
set cpo&vim

if v:version < 700
    finish
endif

command! -nargs=0  GalaxyNext call galaxy#next_scheme()
command! -nargs=0  GalaxyPrev call galaxy#next_scheme("-")
command! -nargs=1  GalaxyLoad call galaxy#load(<q-args>)
command! -nargs=0  Galaxy call galaxy#win()
command! -nargs=0  GalaxyAuto call galaxy#auto_gen()
command! -nargs=0  GalaxyNew call galaxy#win_scheme_gen_colorv()
command! -nargs=0  GalaxyHigh call galaxy#toggle_indent_hl()

if !hasmapto(':Galaxy<CR>')
    silent! nmap <unique> <silent> <Leader>gll :Galaxy<CR>
endif
if !hasmapto(':GalaxyHigh<CR>')
    silent! nmap <unique> <silent> <Leader>glh :GalaxyHigh<CR>
endif
if !hasmapto(':GalaxyNext<CR>')
    silent! nmap <unique> <silent> <Leader>glt :GalaxyNext<CR>
endif
if !hasmapto(':GalaxyPrev<CR>')
    silent! nmap <unique> <silent> <Leader>glp :GalaxyPrev<CR>
endif

if !hasmapto(':GalaxyAuto<CR>')
    silent! nmap <unique> <silent> <Leader>gla :GalaxyAuto<CR>
endif
if !hasmapto(':GalaxyNew<CR>')
    silent! nmap <unique> <silent> <Leader>gln :GalaxyNew<CR>
endif

let &cpo = s:save_cpo
unlet s:save_cpo
