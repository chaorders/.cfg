" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
"runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible
set nocompatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set number
filetype on
filetype plugin on
let mapleader=";"

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) cmmand in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


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

"?
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
set guifont=Monospace\ 13



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



