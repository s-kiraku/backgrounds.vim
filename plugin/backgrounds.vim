" =============================================================================
" Filename: plugin/backgrounds.vim
" Author: s-kiraku
" License: MIT License
" =============================================================================

if exists('g:loaded_backgrounds') || v:version < 801
  finish
endif
let g:loaded_backgrounds = 1

let g:default_light_colors_name = 'peachpuff'

command! ColorSchemes echo join(backgrounds#colorschemes(), "\n")
command! ChangeBG call backgrounds#changebg()
command! -nargs=? ShiftColorScheme call backgrounds#shiftcolorscheme(<args>)
command! -nargs=? ShiftColorSchemeForce call backgrounds#shiftcolorscheme_force(<args>)
