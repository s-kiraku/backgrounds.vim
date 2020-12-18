" ============================================================================="
" Filename: autoload/backgrounds.vim
" Author: s-kiraku
" License: MIT License
" =============================================================================

" Table of color schemes and its type:
"   1: it supports only background=dark
"   2: it supports only background=light
"   3: both of 1 and 2
" bash:
" vim -u ~/.vimrc -es +"put=globpath(&rtp, 'colors/*.vim')" +'g/^\s*$/d' \
"     +'set nonumber' +%p +q! | \
"   while read f; do
"       grep -El '[: ]*set (bg|background) *= *dark' $f | tee -a /tmp/dark.txt
"       grep -El '[: ]*set (bg|background) *= *light' $f | tee -a /tmp/light.txt
"   done

let s:t = {
    \   'alduin': 'dark'
    \ , 'antares': 'dark'
    \ , 'apprentice': 'darklight'
    \ , 'blue': 'dark'
    \ , 'darkblue': 'dark'
    \ , 'default': 'dark'
    \ , 'delek': 'dark'
    \ , 'desert': 'dark'
    \ , 'elflord': 'dark'
    \ , 'elly': 'dark'
    \ , 'evening': 'dark'
    \ , 'gruvbox': 'darklight'
    \ , 'industry': 'dark'
    \ , 'kalisi': 'darklight'
    \ , 'koehler': 'dark'
    \ , 'moonshine': 'dark'
    \ , 'moonshine_lowcontrast': 'light'
    \ , 'moonshine_minimal': 'light'
    \ , 'morning': 'light'
    \ , 'murphy': 'dark'
    \ , 'pablo': 'dark'
    \ , 'peachpuff': 'light'
    \ , 'ron': 'dark'
    \ , 'seoul256': 'dark'
    \ , 'seoul256-light': 'light'
    \ , 'shine': 'light'
    \ , 'slate': 'dark'
    \ , 'sol': 'light'
    \ , 'sol-term': 'light'
    \ , 'solarized': 'darklight'
    \ , 'tender': 'dark'
    \ , 'torte': 'dark'
    \ , 'vice': 'dark'
    \ , 'zellner': 'light'
    \ }

function! s:get_key(key)
    return get(s:t, a:key, 'darklight')
endfunction

function! s:current_color()
    return exists('g:colors_name') ? g:colors_name :
        \ &background == 'dark' ?  'default' : g:default_light_colors_name
endfunction

function! s:colorschemepaths()
    return split(globpath(&runtimepath, 'colors/*.vim'))
endfunction

function! s:colorschemes()
    return sort(map(
                \   s:colorschemepaths(),
                \   {idx, f -> substitute(f,'^.*/\(.*\).vim$','\1','g')}
                \))
endfunction

function! backgrounds#currentcolor()
    return s:current_color()
endfunction

function! backgrounds#colorschemes() abort
    return s:colorschemes()
endfunction

function! backgrounds#changebg() abort
    if &background == 'dark'
        if !match(s:get_key(s:current_color()), 'light')
            execute('colorscheme ' . g:default_light_colors_name())
        endif
        set bg=light
    else
        set bg=dark
    endif
    syntax reset
    execute('colorscheme ' . s:current_color())
endfunction

" NOTE: current color scheme should be in colors
function! s:changecolor(colors, step)
    let s:current_color = s:current_color()
    let s:index         = index(a:colors, s:current_color)
    let s:new_index     = (s:index + a:step) % (len(a:colors))
    " I belive that every color scheme author resets syntax by 'syntax reset'
    " when changing the background option in the color scheme (usr_06: 06.2).
    execute('colorscheme ' . a:colors[s:new_index])
endfunction

function! backgrounds#shiftcolorscheme(step = rand()) abort
    let s:colors = filter(
                \    s:colorschemes(),
                \    'match(s:get_key(v:val), &background) != -1'
                \  )
    call s:changecolor(s:colors, a:step)
endfunction

function! backgrounds#shiftcolorscheme_force(step = rand()) abort
    call s:changecolor(s:colorschemes(), a:step)
endfunction
