" vim:fdm=marker foldlevel=1

" this caused segfault {{{
"let g:rubycomplete_buffer_loading = 1  - this line causes segfault
"let g:rubycomplete_rails = 1           - this line causes segfault
"}}}
" must have defaults: color, number, mouse in term {{{

"activate pathogen
call pathogen#infect()

set nocompatible
colorscheme xoria256
set number
"source ~/.vim/vimrc

set guifont=Menlo\ Regular:h16
set t_Co=256
set cursorline
set wildmenu
set showcmd " show entered character on the bottom right
"set showmode    "show current mode - powerline replaces it
set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
"store lots of :cmdline history
set history=1000


set hidden

"display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅


"allow backspacing over everything in insert mode
set backspace=indent,eol,start

set wrap
set linebreak
set incsearch   "find the next match as we type the search

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2
" }}}
" shortcuts {{{

"make <c-l> clear the highlight as well as redraw

nnoremap <C-L> :nohls<CR><C-L>


noremap <c-d> <esc>ddi
"nnoremap <leader>sv :source $MYVIMRC<cr>

noremap <leader>d :redraw!<CR>
noremap <leader>] :sh<CR>
noremap - dd
set clipboard+=unnamed
imap jj <Esc>

nnoremap <left> :vertical resize -5<cr>
nnoremap <down> :resize +5<cr>
nnoremap <up> :resize -5<cr>
nnoremap <right> :vertical resize +5<cr>

nnoremap <leader>ws <c-w>s
nnoremap <leader>wv <c-w>v
nnoremap <leader>wc <c-w>c

nnoremap <leader>-  <c-w>_
nnoremap <leader>=  <c-w>=

noremap <silent> <f1> :wincmd h<CR>
noremap <silent> <f2> :wincmd j<CR>
noremap <silent> <f3> :wincmd k<CR>
noremap <silent> <f4> :wincmd l<CR>
noremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>


noremap <leader>s       :w<CR>
noremap <leader>t       :tabnew<CR>
noremap <C-N>           :!mvim &<CR><CR>
noremap <leader>r       :RunRuby<CR>
noremap <leader><tab>   :NERDTreeToggle<CR>
noremap  <leader>p      :CtrlP<CR>
noremap y "*y
noremap Y "*Y
noremap p "*p
noremap P "*P

noremap <leader>q :q!<CR>
noremap <leader>b :bd!<CR>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
"}}}
" Were here but currently disabled and not used {{{
"command! FR set filetype=ruby
":imap <tab> <c-x><c-o>
"set cpoptions+=$
" }}}
" ruby plugin - as written in the README {{{
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
compiler ruby         " Enable compiler support for rubyaa
"}}}
" don't highlight search result {{{
set hlsearch
"}}}
"default indent and folding settings {{{

set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

"folding settings
set foldmethod=marker   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels

" }}}
"Plugins {{{1
"nerdtree settings {{{2
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 40
" }}}
" }}}
" left overs from /.vim/vimrc {{{1

" undo files section
"if v:version >= 703
"    "undo settings
"    set undodir=~/.vim/undofiles
"    set undofile
"    set colorcolumn=+1 "mark the ideal max text width
"endif

"set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

" statusline settings used with powerline {{{2

"statusline setup
set statusline =%#identifier#
set statusline+=[%t]    "tail of the filename
set statusline+=%*
"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*
"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#identifier#
set statusline+=%*

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2


" }}}


" didn't touch taken as is {{{2
"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)
    let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
    return filter(line_lens, 'v:val > threshold')
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction



"source project specific config files
runtime! projects/**/*.vim

"dont load csapprox if we no gui support - silences an annoying warning
if !has("gui")
    let g:CSApprox_loaded = 1
endif

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell
"}}}

:set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" }}}



