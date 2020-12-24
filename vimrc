"======================================
" colorscheme and syntax highlight
"======================================
syntax on
set t_Co=256
"colorscheme darkblue
"colorscheme desert256
colorscheme desert

"highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\s\+$\| \+\ze\t/

" Show trailing whitepace and spaces before a tab:
"autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

autocmd BufNewFile,BufRead *.{wiki,py,pl,sh} :call CodingStyleQEMU()
autocmd BufNewFile,BufRead *.{xml,html,js,css} :call CodingStyleWeb()
"autocmd BufNewFile,BufRead * :call DetermineCodingStyle()

"syn sync fromstart
"syn sync minlines=1000

"set list
"set listchars=tab:>.,extends:#,nbsp:.

if has("gui_running")
        if has("gui_gtk2")
            set guifont=Courier\ New\ 18
        elseif has("gui_kde")
            echoerr "Sorry, please look into your kvim documentation"
        elseif has("x11")
            set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
        else
            set guifont=Courier_New:h14:cDEFAULT
	    au GUIEnter * simalt ~x
        endif
endif


"======================================
" basic settings
"======================================
"set cursorline
"set mouse=a
set showcmd
set showmatch
set number
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                      "    case-sensitive otherwise
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cindent
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
"set fmr={,}
"set fdm=syntax
set foldnestmax=2

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
"set title                " change the terminal's title
"set visualbell           " don't beep
set noerrorbells         " don't beep

set nobackup
set noswapfile
set nocompatible 
filetype plugin on 
syntax on
let c_space_errors = 1

"======================================
" hotkey mapping
"======================================
" QuickFix
nmap ,,n :cn<cr>
nmap ,,p :cp<cr>

nmap ,a :a<CR> 
"nmap ,e :Ex
nmap ,e :enew<CR>:Ex
nmap ,c :close<CR> 
nnoremap <silent> <F3> :Grep<CR>
nnoremap <silent> ,gr :Rgrep<CR>  
nnoremap <silent> ,gb :GrepBuffer<CR>  
nmap ,bd :bd!<CR>
nmap ,bo :Bonly<CR>
nmap ,so :so ~\.vimrc<CR>
nmap ,rc :e ~\.vimrc<CR>
nmap ,n :MBEbn<CR>
nmap ,p :MBEbp<CR>
nmap ,pp :set paste<CR>
nmap ,tt :TlistToggle<CR>
nmap ,te :so ~/.vim/plugin/tetris.vim<CR><Leader>te<CR>
nmap ,s5n :Sokoban<CR>
nmap ,gg :call GitGrepWord()<CR>
nmap ,csl :call CodingStyleLinux()<CR>
nmap ,csq :call CodingStyleQEMU()<CR>
nmap <silent> <C-N> :silent noh<CR>
nnoremap  <silent>  <space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr> 

"======================================
" plugin: MiniBufExplorer
"======================================
let g:miniBurExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1

"======================================
" plugin: taglist
"======================================
let g:Tlist_Use_Right_Window = 1
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

"======================================
" plugin: Grep
"======================================
let Grep_Default_Options = '-i'
let Grep_Skip_Dirs = 'CVS .hg .git .svn'
let Grep_Skip_Files = 'TAGS cscope.*'

func! DetermineCodingStyle()
    let output=system('is_linux')
    if !v:shell_error
        :call CodingStyleLinux()
    else
        :call CodingStyleQEMU()
    endif
endf

"======================================
" Large File
"======================================
" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 10M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
    augroup END
endif

func! CodingStyleLinux()
    set tabstop=8
    set shiftwidth=8
    set noexpandtab
endf

func! CodingStyleQEMU()
    set tabstop=4
    set shiftwidth=4
    set expandtab
endf

func! CodingStyleWeb()
    set tabstop=4
    set shiftwidth=4
    set noexpandtab
endf

"" Turn of syntax when vimdiff to make it more easy to read
if &diff
    syntax off
endif
