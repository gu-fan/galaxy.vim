"=============================================================
"  Script: Galaxy 
"    File: plugin/galaxy.vim
" Summary: Generate your scheme with your fav color.
"  Author: Rykka.Krin <Rykka.Krin(at)gmail.com>
"=============================================================
let s:save_cpo = &cpo
set cpo&vim

if v:version < 700
    finish
endif

command! -nargs=0  GalaxyNext call galaxy#next_scheme()
command! -nargs=0  GalaxyPrev call galaxy#next_scheme("-")
command! -nargs=0  Galaxy call galaxy#win()
command! -nargs=0  GalaxyGen call galaxy#auto_gen()

if !hasmapto(':Galaxy<CR>')
  silent! nmap <unique> <silent> <Leader>gll :Galaxy<CR>
endif
if !hasmapto(':GalaxyNext<CR>')
  silent! nmap <unique> <silent> <Leader>gln :GalaxyNext<CR>
endif
if !hasmapto(':GalaxyPrev<CR>')
  silent! nmap <unique> <silent> <Leader>glp :GalaxyPrev<CR>
endif

if !hasmapto(':GalaxyGen<CR>')
  silent! nmap <unique> <silent> <Leader>gla :GalaxyGen<CR>
endif

let &cpo = s:save_cpo
unlet s:save_cpo
