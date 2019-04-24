" ============================================================================
" vim-pizza: Order pizza from within Vim.
"
" Author:     Arithran Thurairetnam
" Maintainer: https://github.com/arithran/vim-pizza
" Version:    0.1.0
" ============================================================================
if exists("g:pizza#loaded")
	finish
endif

let s:DEFAULT_PIZZA_URL = "https://www.pizzahut.com"

if !exists('g:pizza#url')
	let g:pizza#url = s:DEFAULT_PIZZA_URL
endif

function! OrderPizza() abort
	let haskdeinit = system("ps -e") =~ 'kdeinit'
	let hasdarwin = system("uname -s") =~ 'Darwin'


	if has("gui_running")
		let args = shellescape(g:pizza#url,1)." &"
	else
		let args = shellescape(g:pizza#url,1)." > /dev/null"
	end

	if has("unix") && executable("gnome-open") && !haskdeinit
		exe "silent !gnome-open ".args
	elseif has("unix") && executable("kde-open") && haskdeinit
		exe "silent !kde-open ".args
	elseif has("unix") && executable("open") && hasdarwin
		exe "silent !open ".args
	elseif has("unix") && executable("xdg-open")
		exe "silent !xdg-open ".args
	elseif has("win32") || has("win64")
		exe "silent !start explorer ".shellescape(g:pizza#url,1)
	end
	redraw!
endfunction

command! OrderPizza call OrderPizza()

nnoremap <silent> <Plug>(pizza#order) :call OrderPizza()<Return>

let g:pizza#loaded = 1
