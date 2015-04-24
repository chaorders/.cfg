
"Configuration of Bundle{{{
"git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"Brief help of Bundle
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles

set nocompatible		"be iMproved, required
filetype off			"required
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" original repos on github
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-powerline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'crusoexia/vim-monokai'
Bundle 'mbbill/code_complete'
Bundle 'vim-latex/vim-latex'

" vim-scripts repos www.vim-scripts.org/vim/scripts.html
Bundle 'The-NERD-tree'
Bundle 'taglist.vim'
Bundle 'vimball'

" non github repos

filetype plugin indent on     " required!
"}}}

"Modify behavious of plugins{{{
"auto_complete
set tags+=~/.vim/tags/code_complete_tags

"vim-powerline configuration
set laststatus=2
set t_Co=256
let g:Powline_symbols='fancy'

"taglist
let Tlist_Use_Right_Window=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Auto_Open=1
let Tlist_Show_Menu=1					"Visibal in Gvim
"}}}

"Uncomment the following to have Vim jump to the last position when reopening a file{{{
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
"}}}
 
"General Settings{{{
set showcmd		" Show (partial) cmmand in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden			" Hide buffers when they are abandoned
set number
let mapleader=","
set fdm=marker		" 6 methods: manual,indent,syntax,marker,diff,expr
set tabstop=4
set softtabstop=8
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
	colorscheme solarized
	set guifont=Monospace\ 13
else
	colorscheme monokai
endif

autocmd InsertLeave * se nocul    
autocmd InsertEnter * se cul    
"}}}

"Press F5 to function the C,C++,Java script{{{
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
"}}}

"Auomaticly add file information for *.cpp *.ch *.sh *.java{{{
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
"}}}

"Automaticly add ({'""'}) and format it{{{
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
"}}}


