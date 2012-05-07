"=============================================================
"  Script: Galaxy 
"    File: plugin/galaxy.vim
" Summary: A colorscheme to make colorscheming simpler 
"  Author: Rykka G.Forest <Rykka10(at)gmail.com>
" Last Update: 2012-05-07
"=============================================================
let s:save_cpo = &cpo
set cpo&vim

if v:version < 700
    echom "[Galaxy] Stoped as your vim version < 7.0."
    finish
elseif exists("g:galaxy_loaded") && g:galaxy_loaded == 1
    finish
else
    try 
        call colorv#hex2rgb("FF0000")
    catch //
        echom "[Galaxy] Stoped as ColorV.vim not installed."
        echom "Download it from http://github.com/Rykka/ColorV"
        finish
    endtry
    let g:galaxy_loaded = 1
endif

command! -nargs=0  Galaxy         call galaxy#win()
command! -nargs=1  GalaxyLoad     call galaxy#load(<q-args>)
command! -nargs=0  GalaxyAuto     call galaxy#auto_gen()
command! -nargs=0  GalaxyIndent   call galaxy#toggle_indent_hl()
command! -nargs=0  GalaxyScreen   call galaxy#screen.win()
command! -nargs=0  GalaxyLittle   call galaxy#screen.saver()

if !hasmapto(':Galaxy<CR>')
    silent! nmap <unique> <silent> <Leader>gll :Galaxy<CR>
endif
if !hasmapto(':GalaxyIndent<CR>')
    silent! nmap <unique> <silent> <Leader>glh :GalaxyIndent<CR>
endif
if !hasmapto(':GalaxyScreen<CR>')
    silent! nmap <unique> <silent> <Leader>gls :GalaxyScreen<CR>
endif
if !hasmapto(':GalaxyLittle<CR>')
    silent! nmap <unique> <silent> <Leader>glv :GalaxyLittle<CR>
endif
let &cpo = s:save_cpo
unlet s:save_cpo
