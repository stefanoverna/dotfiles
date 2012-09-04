" Inhibit MacVim default shortcuts starting with Command and Option
let macvim_skip_cmd_opt_movement = 1

" Start without the toolbar
set guioptions-=T

" Command-][ to increase/decrease indentation
vmap <D-]> >gv
vmap <D-[> <gv

" Fullscreen takes up entire screen
set fuoptions=maxhorz,maxvert

" Command-T for CommandT
macmenu &File.New\ Tab key=<D-T>
map <D-t> :CtrlP<CR>
imap <D-t> <Esc>:CtrlP<CR>

" Move between buffers with Command+Arrows
map <D-Right> :bn!<CR>
map <D-Left> :bp!<CR>

" Bigger fonts, please
set gfn=Monaco:h13

" Color Picker shortcut
map <D-C> :ChooseColor<CR>
imap <D-C> <Esc>:ChooseColor<CR>

