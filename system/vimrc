

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set nocompatible
set showcmd		" Show (partial) cmmand in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set number
filetype on
filetype plugin on
let mapleader=";"
set fdm=marker		" 6 methods: manual,indent,syntax,marker,diff,expr
set tabstop=4
set shiftwidth=4
set autoindent
set cindent
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
"set mouse=a		" Enable mouse usage (all modes)
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8

syntax enable
set background=dark

if has('gui_running')
	colorscheme monokai-modified
	set guifont=Monospace\ 13
else
	colorscheme slate
endif




"auto_complete
set tags+=~/.vim/tags/code_complete_tags

"Press F5 to function the C,C++,Java script
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
         exec "!gcc % -o %<"
         exec "! %<"
    elseif &filetype == 'cpp'
         exec "!g++ % -o %<"
         exec "! ./%<"
    elseif &filetype == 'java' 
         exec "!javac %" 
         exec "!java %<"
    elseif &filetype == 'sh'
         :!./%
    endif
endfunc

"C,C++ test
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc

map <F3> :tabnew .<CR>  
map <C-F3> \be  



"auto
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
func SetTitle() 
	if &filetype == 'sh' 
	        call setline(1,"\#########################################################################") 
		call append(line("."), "\# File Name: ".expand("%")) 
	        call append(line(".")+1, "\# Author: Thomas") 
	        call append(line(".")+2, "\# mail: thomas.chen.au@gmail.com") 
	        call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
	        call append(line(".")+4, "\#########################################################################") 
	        call append(line(".")+5, "\#!/bin/bash") 
	        call append(line(".")+6, "") 
	else 
        	call setline(1, "/*************************************************************************") 
		call append(line("."), "    > File Name: ".expand("%")) 
	        call append(line(".")+1, "    > Author: Thomas") 
	        call append(line(".")+2, "    > Mail: thomas.chen.au@gmail.com ") 
		call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
	        call append(line(".")+4, " ************************************************************************/") 
	        call append(line(".")+5, "")
	endif
        if &filetype == 'cpp'
	        call append(line(".")+6, "#include<iostream>")
	        call append(line(".")+7, "using namespace std;")
	        call append(line(".")+8, "")
	endif
	if &filetype == 'c'
	        call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
	autocmd BufNewFile * normal G
endfunc 

autocmd InsertLeave * se nocul    
autocmd InsertEnter * se cul    

"Automatically add {} and format it.
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

function CloseBracket()
	if match(getline(line('.') + 1), '\s*}') < 0
		return "\<CR>}"
	else
		return "\<Esc>j0f}a"
	endif
endf

function QuoteDelim(char)
	let line = getline('.')
	let col = col('.')
	if line[col - 2] == "\\"
	"Inserting a quoted quotation mark into the string
		return a:char
	elseif line[col - 1] == a:char
	"Escaping out of the string
		return "\<Right>"
	else
	"Starting a string
		return a:char.a:char."\<Esc>i"
	endif
endf



