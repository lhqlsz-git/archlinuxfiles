let mapleader=','
ino jj <esc>
ino <c-l> <right>
nno <leader>d :bd! <cr>
nno q :q!<cr>
nno w :w<cr>

syntax on
filetype plugin indent on
set nu
set rnu
set showcmd
set mouse=a
set autoindent
set tabstop=4
set shiftwidth=4
set wrap
set laststatus=2

au BufNewFile,BufRead *.lin                     setf linux

nno <leader>p :r ! xclip -selection primary -o<cr>

vno <leader>c :w !xclip -selection primary<cr> 
nno <leader>c :.w !xclip -selection primary<cr>

nno <F2> :exec "! " . getline('.')<cr>

so /home/lhq/.vim/coc.vim

function! Sdcv()
	let word = expand('<cword>')
	let cmd = "sdcv -n " . word
	let cleaned = system(cmd)
	
let cleaned = substitute(cleaned, '\[\[[0-9;]*m', '', 'g')
    let cleaned = substitute(cleaned, '\[0m', '', 'g')
    " 清理特殊字符
    let cleaned = substitute(cleaned, '\[@-->\|Leader.''0-->\|\[m', '', 'g')
    let cleaned = substitute(cleaned, '^\s*\[\?', '', 'g')
    let cleaned = substitute(cleaned, '\]\?$', '', 'g')
	let cleaned = substitute(cleaned, 'Found.*词典', ' ' ,'g')
	let cleaned = substitute(cleaned, '-->', ' ', 'g')

    " 规范化空格
	
	let cleaned = substitute(cleaned, '\n', ' ', '')
    let cleaned = substitute(cleaned, '\s\+', ' ', 'g')
    let cleaned = substitute(cleaned, '^\s*|\s*$', '', 'g')
     return split(cleaned, '\n')

	
endfunction

function! Showsdcv()
	let id = popup_atcursor(Sdcv(), {
				\'padding':  [1,2,1,2],
				\'border': [1,1,1,1]})
endfunction

nno <leader>t :call Showsdcv()<cr>


function! Runpac()
	let s = expand('<cWORD>')
	let cmd = "!sudo pacman -S " . s
	exec cmd
endfunction

function! Uninstall()
	let s = expand('<cWORD>')
	let cmd = "! sudo pacman -s " . s 
	exec  cmd
endfunction

