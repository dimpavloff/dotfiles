" Don't use vi compatibility
set nocompatible

" Enable pathogen plugin
call pathogen#infect()
call pathogen#helptags()

syntax enable
filetype on
filetype plugin on
filetype indent on

set encoding=utf-8
set list listchars=trail:→

set hidden " hide instead of closing buffers

set updatetime=100  " freq of updating swap and status bar when cursor hovers

" Ultisnips
let g:UltiSnipsExpandTrigger = "<s-tab>"

" Pymode
let g:pymode = 1
let g:pymode_run = 0
let g:pymode_rope = 0
let g:pymode_python = 'python3'  " use a modern Python
let g:pymode_lint_checkers = ['pylint', 'pyflakes', 'pep8', 'mccabe']
let g:pymode_lint_ignore = "C0111"
let g:pymode_rope_goto_definition_bind = 'gd'
let g:pymode_rope_goto_definition_cmd = 'e'
" jedi-vim
" let g:jedi#goto_command = 'gd'
let g:jedi#force_py_version = 3
let g:jedi#goto_assignments_command = "gd"
let g:jedi#usages_command = "<leader>u"

" vim-go
let g:go_list_type = "quickfix"  " only use quickfix list for errors
let g:go_highlight_types = 1
let g:go_metalinter_autosave = 1  " run linters on autosave
let g:go_auto_type_info = 1

" rust.vim
let g:rustfmt_autosave = 1

" highlighting can be expensive and noisy
" let g:go_highlight_types = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_build_constraints = 1

" fzf
" complete entire line
" imap <c-x><c-l> <plug>(fzf-complete-line) 

" Tagbar Additional language support
let g:tagbar_type_rust = {
   \ 'ctagstype' : 'rust',
   \ 'kinds' : [
       \'T:types,type definitions',
       \'f:functions,function definitions',
       \'g:enum,enumeration names',
       \'s:structure names',
       \'m:modules,module names',
       \'c:consts,static constants',
       \'t:traits',
       \'i:impls,trait implementations',
   \]
   \}

let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'sro'       : '.',
    \ 'kinds'     : [
      \ 'p:packages',
      \ 'T:types:1',
      \ 't:traits',
      \ 'o:objects',
      \ 'O:case objects',
      \ 'c:classes',
      \ 'C:case classes',
      \ 'm:methods',
      \ 'V:values:1',
      \ 'v:variables:1'
    \ ]
\ }

let g:tagbar_autofocus = 1

" Low priority filename suffixes for filename completion {{{
set suffixes-=.h        " Don't give .h low priority
set suffixes+=.aux
set suffixes+=.log
set wildignore+=*.dvi
set suffixes+=.bak
set suffixes+=~
set suffixes+=.swp
set suffixes+=.o
set suffixes+=.class
" }}}

set showfulltag         " Get function usage help automatically
set showcmd             " Show current vim command in status bar
set showmatch           " Show matching parentheses/brackets
set showmode            " Show current vim mode

set background=dark
colorscheme solarized
set nu
set relativenumber

set bs=2                " allow backspacing over everything in insert mode
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=1000        " keep 1000 lines of command line history
set undolevels=1000     " 1000 undo
set ruler               " show the cursor position all the time
set hlsearch          " don't highlight search matches
set incsearch           " incremental (emacs-style) search
set vb t_vb=            " kill the beeps! (visible bell)
set wildmenu            " use a scrollable menu for filename completions
set ignorecase          " case-insensitive searching
set smartcase           " ignore ignorecase if there's capitals in the search

" Indentation / tab replacement stuff
set shiftwidth=4        " > and < move block by 4 spaces in visual mode
set sts=4
set et                  " expand tabs to spaces
set autoindent              " always set autoindenting on
set nowrap
set expandtab
set tabstop=4

" Write buffer before running make
set autowrite


" Color Scheme (only if GUI running) {{{
if has("gui_running")
    colorscheme solarized
endif
" }}}

" Key mappings {{{

let mapleader = ","

nmap <Leader>nt :NERDTreeToggle<CR>
nmap <Leader>t :TagbarToggle<CR>
nmap <Leader>d :GoDeclsDir<CR>
nnoremap <silent> <Leader>p :CtrlPTag<CR>

" Move text, but keep highlight
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" Use ; instead of :
nnoremap ; :

" Sudo write
cmap w!! w !sudo tee % > /dev/null

" Allow the . to execute once for each line in visual selection
vnoremap . :normal .<CR>

" Make ' function behave like ` usually does and then change ` to replay
" recorded macro a (as if @a was typed).  In visual mode, ` (which now acts
" like @a) should function on all selected lines.
noremap ' `
nnoremap ` @a
vnoremap ` :normal @a<CR>

" Make tab perform keyword/tag completion if we're not following whitespace
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" Make F7 spellcheck the buffer
noremap <F7> <Esc>:call IspellCheck()<CR><Esc>

" Programming Keys:
"   F9  = Dispatch which defaults to Make if no dispatcher is set, which
"   wraps make
"   F10 = Next Error
"   F11 = Prev Error
inoremap <F9> <Esc>:Dispatch<CR>
noremap <C-n> <Esc>:cnext<CR>
noremap <C-m> <Esc>:cprevious<CR>
nnoremap <leader>a :cclose<CR>
noremap <F9> <Esc>:Dispatch<CR>

" Buffer Switching:
"   F2 = next buffer
"   F3 = previous buffer
"   F4 = kill buffer
inoremap <F2> <Esc>:bn<CR>
inoremap <F3> <Esc>:bp<CR>
inoremap <F4> <Esc>:bd<CR>
noremap <F2> <Esc>:bn<CR>
noremap <F3> <Esc>:bp<CR>
noremap <F4> <Esc>:bd<CR>

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Key mappings }}}

" Autocommands {{{
if has("autocmd")

    " When vim is used in a console window, set the title bar to the
    " name of the buffer being editted.
    if !has("gui_running")
        auto BufEnter * let &titlestring="VIM - ".expand("%:p")
    endif

    " In text and LaTeX files, always limit the width of text to 76
    " characters.  Also perform logical wrapping/indenting.
    autocmd BufRead *.txt set tw=76 formatoptions=tcroqn2l
    autocmd BufRead *.tex set tw=76

    " Programming settings {{{
    augroup prog
        au!
        au BufRead *.c,*.cc,*.cpp,*.h,*.java set formatoptions=croql cindent nowrap nofoldenable foldmethod=syntax
        au BufEnter *.go set nolist

        " Don't expand tabs to spaces in Makefiles
        au BufEnter  [Mm]akefile*  set noet
        au BufLeave  [Mm]akefile*  set et

        " Set up folding for python
        " au FileType python set nofoldenable foldmethod=syntax
        " au FileType python set foldlevel=10
        " Enable SimpleFold instead
        au BufWinEnter *.py setlocal nofoldenable foldexpr=SimpylFold(v:lnum) foldmethod=expr
        au BufWinLeave *.py setlocal foldexpr< foldmethod<

        au FileType python syn keyword pythonStatement async await

        " Set dispatchers
        au FileType java let b:dispatch = 'javac %'
    augroup END
    " }}}


    " Reread configuration of Vim if .vimrc is saved {{{
    augroup VimConfig
        au!
        autocmd BufWritePost .vimrc       so .vimrc
        autocmd BufWritePost vimrc          so vimrc
    augroup END
    " }}}


"    " }}}

endif " has("autocmd")
" }}}

" Functions {{{

" IspellCheck() {{{
function! IspellCheck()
    let l:tmpfile = tempname()

    execute "normal:w!" . l:tmpfile . "\<CR>"
    if has("gui_running")
        execute "normal:!xterm -e ispell " . l:tmpfile . "\<CR>"
    else
        execute "normal:! ispell " . l:tmpfile . "\<CR>"
    endif
    execute "normal:%d\<CR>"
    execute "normal:r " . l:tmpfile . "\<CR>"
    execute "normal:1d\<CR>"
endfunction
" IspellCheck }}}

" InsertTabWrapper() {{{
" Tab completion of tags/keywords if not at the beginning of the
" line.  Very slick.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
" InsertTabWrapper() }}}

" Functions }}}

" Settings for specific syntax files {{{
let c_gnu=1
let c_comment_strings=1
let c_space_errors=1

"let perl_fold=1          " turn on perl folding capabilities
" }}}

if filereadable(glob("~/local/vim.vim"))
    so ~/local/vim.vim
endif
