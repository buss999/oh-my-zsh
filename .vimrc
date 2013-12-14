colorscheme darkblue
set background=dark
" .vimrc
"
" Smylers's .vimrc
" http://www.stripey.com/vim/
" 
" 2000 Jun  1: for `Vim' 5.6
" 
" This vimrc is divided into these sections:
" 
" * Terminal Settings
" * User Interface
" * Text Formatting -- General
" * Text Formatting -- Specific File Formats
" * Search & Replace
" * Spelling
" * Keystrokes -- Moving Around
" * Keystrokes -- Formatting
" * Keystrokes -- Toggles
" * Keystrokes -- Insert Mode
" * Keystrokes -- For HTML Files
" * `SLRN' Behaviour
" * Functions Referred to Above
" 
" This file contains no control codes and no `top bit set' characters above the
" normal Ascii range, and all lines contain a maximum of 79 characters.  With a
" bit of luck, this should make it resilient to being uploaded, downloaded,
" e-mailed, posted, encoded, decoded, transmitted by morse code, or whatever.


" first clear any existing autocommands:
autocmd!


" * Terminal Settings

" `XTerm', `RXVT', `Gnome Terminal', and `Konsole' all claim to be "xterm";
" `KVT' claims to be "xterm-color":
if &term =~ 'xterm'

  " `Gnome Terminal' fortunately sets $COLORTERM; it needs <BkSpc> and <Del>
  " fixing, and it has a bug which causes spurious "c"s to appear, which can be
  " fixed by unsetting t_RV:
  if $COLORTERM == 'gnome-terminal'
    execute 'set t_kb=' . nr2char(8)
    " [Char 8 is <Ctrl>+H.]
    fixdel
    set t_RV=

  " `XTerm', `Konsole', and `KVT' all also need <BkSpc> and <Del> fixing;
  " there's no easy way of distinguishing these terminals from other things
  " that claim to be "xterm", but `RXVT' sets $COLORTERM to "rxvt" and these
  " don't:
  elseif $COLORTERM == ''
    execute 'set t_kb='
    fixdel

  " The above won't work if an `XTerm' or `KVT' is started from within a `Gnome
  " Terminal' or an `RXVT': the $COLORTERM setting will propagate; it's always
  " OK with `Konsole' which explicitly sets $COLORTERM to "".

  endif
endif


" * User Interface

" have syntax highlighting in terminals which can display colours:
if has('syntax') && (&t_Co > 2)
  syntax on
endif

" have fifty lines of command-line (etc) history:
set history=50
" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't remember
" marks in files, don't rehighlight old search patterns, and only save up to
" 100 lines of registers; including @10 in there should restrict input buffer
" but it causes an error for me:
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

" use "[RO]" for "[readonly]" to save space in the message line:
set shortmess+=r

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

" when using list, keep tabs at their full width and display `arrows':
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)
" (Character 187 is a right double-chevron, and 183 a mid-dot.)

" have the mouse enabled all the time:
set mouse=a

" don't have files trying to override this .vimrc:
" set nomodeline


" * Text Formatting -- General

" don't make it look like there are line breaks where there aren't:
set wrap lbr

" use indents of 2 spaces, and have them copied down lines:
set shiftwidth=2
set shiftround
set expandtab
set autoindent

" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions-=t
set textwidth=79

" get rid of the default style of C comments, and define a style with two stars
" at the start of `middle' rows which (looks nicer and) avoids asterisks used
" for bullet lists being treated like C comments; then define a bullet list
" style for single stars (like already is for hyphens):
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:**,ex:*/
set comments+=fb:*

" treat lines starting with a quote mark as comments (for `Vim' files, such as
" this very one!), and colons as well so that reformatting usenet messages from
" `Tin' users works OK:
set comments+=b:\"
set comments+=n::


" * Text Formatting -- Specific File Formats

" enable filetype detection:
filetype on

" recognize anything in my .Postponed directory as a news article, and anything
" at all with a .txt extension as being human-language text [this clobbers the
" `help' filetype, but that doesn't seem to prevent help from working
" properly]:
"augroup filetype
"  autocmd BufNewFile,BufRead *.txt set filetype=human
"augroup END

" in human-language files, automatically format everything at 72 chars:
autocmd FileType mail,human set formatoptions+=t textwidth=72

" for C-like programming, have automatic indentation:
autocmd FileType c,cpp,slang set cindent

" for actual C (not C++) programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
autocmd FileType c set formatoptions+=ro

" for Perl programming, have things in braces indenting themselves:
autocmd FileType perl set smartindent

" for CSS, also have things in braces indented:
autocmd FileType css set smartindent

" for HTML, generally format text, but if a long line has been created leave it
" alone when editing:
autocmd FileType html set formatoptions+=tl

" for both CSS and HTML, use genuine tab characters for indentation, to make
" files a few bytes smaller:
autocmd FileType html,css set noexpandtab tabstop=2

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8


" * Search & Replace

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault


" * Keystrokes -- Moving Around

" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ covert case over line breaks; also have the cursor keys
" wrap in insert mode:
set whichwrap=h,l,~,[,]

" Space open+closes code folds
vnoremap <space> zf<CR>
nnoremap <space> zd<CR>


" scroll the window (but leaving the cursor in the same place) by a couple of
" lines up/down with <Ins>/<Del> (like in `Lynx'):
noremap <Ins> 2<C-Y>
noremap <Del> 2<C-E>
" [<Ins> by default is like i, and <Del> like x.]

" use <F6> to cycle through split windows (and <Shift>+<F6> to cycle backwards,
" where possible):
nnoremap <F6> <C-W>w
nnoremap <S-F6> <C-W>W

" use <Ctrl>+N/<Ctrl>+P to cycle through files:
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>
" [<Ctrl>+N by default is like j, and <Ctrl>+P like k.]

" have % bounce between angled brackets, as well as t'other kinds:
set matchpairs+=<:>

" have <F1> prompt for a help topic, rather than displaying the introduction
" page, and have it do this from any mode:
nnoremap <F1> :help<Space>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>


" * Keystrokes -- Formatting

" have Q reformat the current paragraph (or selected text if there is any):
nnoremap Q gqap
vnoremap Q gq

" have the usual indentation keystrokes still work in visual mode:
vnoremap <C-T> >
vnoremap <C-D> <LT>
vmap <Tab> <C-T>
vmap <S-Tab> <C-D>

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$


" * Keystrokes -- Toggles

" Keystrokes to toggle options are defined here.  They are all set to normal
" mode keystrokes beginning \t but some function keys (which won't work in all
" terminals) are also mapped.

" have \tp ("toggle paste") toggle paste on/off and report the change, and
" where possible also have <F4> do this both in normal and insert mode:
nnoremap \tp :set invpaste paste?<CR>
nmap <F4> \tp
imap <F4> <C-O>\tp
set pastetoggle=<F4>

" have \tf ("toggle format") toggle the automatic insertion of line breaks
" during typing and report the change:
nnoremap \tf :if &fo =~ 't' <Bar> set fo-=t <Bar> else <Bar> set fo+=t <Bar>
  \ endif <Bar> set fo?<CR>
nmap <F3> \tf
imap <F3> <C-O>\tf

" have \tl ("toggle list") toggle list on/off and report the change:
nnoremap \tl :set invlist list?<CR>
nmap <F2> \tl

" have \th ("toggle highlight") toggle highlighting of search matches, and
" report the change:
nnoremap \th :set invhls hls?<CR>


" * Keystrokes -- Insert Mode

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" have <Tab> (and <Shift>+<Tab> where it works) change the level of
" indentation:
inoremap <Tab> <C-T>
inoremap <S-Tab> <C-D>
" [<Ctrl>+V <Tab> still inserts an actual tab character.]

" abbreviations:
iabbrev lfpg Llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch
iabbrev hse he/she
iabbrev sm Smylers


" * Keystrokes -- For HTML Files

" Some automatic HTML tag insertion operations are defined next.  They are
" allset to normal mode keystrokes beginning \h.  Insert mode function keys are
" also defined, for terminals where they work.  The functions referred to are
" defined at the end of this .vimrc.

" \hc ("HTML close") inserts the tag needed to close the current HTML construct
" [function at end of file]:
nnoremap \hc :call InsertCloseTag()<CR>
imap <F8> <Space><BS><Esc>\hca

" \hp ("HTML previous") copies the previous (non-closing) HTML tag in full,
" including attributes; repeating this straight away removes that tag and
" copies the one before it [function at end of file]:
nnoremap \hp :call RepeatTag(0)<CR>
imap <F9> <Space><BS><Esc>\hpa
" \hn ("HTML next") does the same thing, but copies the next tag; so \hp and
" \hn can be used to cycle backwards and forwards through the tags in the file
" (like <Ctrl>+P and <Ctrl>+N do for insert mode completion):
nnoremap \hn :call RepeatTag(1)<CR>
imap <F10> <Space><BS><Esc>\hna

" there are other key mappings that it's useful to have for typing HTML
" character codes, but that are definitely not wanted in other files (unlike
" the above, which won't do any harm), so only map these when entering an HTML
" file and unmap them on leaving it:
autocmd BufEnter * if &filetype == "html" | call MapHTMLKeys() | endif
function! MapHTMLKeys(...)
" sets up various insert mode key mappings suitable for typing HTML, and
" automatically removes them when switching to a non-HTML buffer

  " if no parameter, or a non-zero parameter, set up the mappings:
  if a:0 == 0 || a:1 != 0

    " require two backslashes to get one:
    inoremap \\ \

    " then use backslash followed by various symbols insert HTML characters:
    inoremap \& &amp;
    inoremap \< &lt;
    inoremap \> &gt;
    inoremap \. &middot;

    " em dash -- have \- always insert an em dash, and also have _ do it if
    " ever typed as a word on its own, but not in the middle of other words:
    inoremap \- &#8212;
    iabbrev _ &#8212;

    " hard space with <Ctrl>+Space, and \<Space> for when that doesn't work:
    inoremap \<Space> &nbsp;
    imap <C-Space> \<Space>

    " have the normal open and close single quote keys producing the character
    " codes that will produce nice curved quotes (and apostophes) on both Unix
    " and Windows:
    inoremap ` &#8216;
    inoremap ' &#8217;
    " then provide the original functionality with preceding backslashes:
    inoremap \` `
    inoremap \' '

    " curved double open and closed quotes (2 and " are the same key for me):
    inoremap \2 &#8220;
    inoremap \" &#8221;

    " when switching to a non-HTML buffer, automatically undo these mappings:
    autocmd! BufLeave * call MapHTMLKeys(0)

  " parameter of zero, so want to unmap everything:
  else
    iunmap \\
    iunmap \&
    iunmap \<
    iunmap \>
    iunmap \-
    iunabbrev _
    iunmap \<Space>
    iunmap <C-Space>
    iunmap `
    iunmap '
    iunmap \`
    iunmap \'
    iunmap \2
    iunmap \"

    " once done, get rid of the autocmd that called this:
    autocmd! BufLeave *

  endif " test for mapping/unmapping

endfunction " MapHTMLKeys()


" * `SLRN' Behaviour

" when using `SLRN' to compose a new news article without a signature, the
" cursor will be at the end of the file, the blank line after the header, so
" duplicate this line ready to start typing on; when composing a new article
" with a signature, `SLRN' includes an appropriate blank line but places the
" cursor on the following one, so move it up one line [if re-editing a
" partially-composed article, `SLRN' places the cursor on the top line, so
" neither of these will apply]:
autocmd VimEnter .article if line('.') == line('$') | yank | put |
  \ elseif line('.') != 1 | -

" when following up articles from people with long names and/or e-mail
" addresses, the `SLRN'-generated attribution line can have over 80 characters,
" which will then cause `SLRN' to complain when trying to post it(!), so if
" editing a followup for the first time, reformat the line (then put the cursor
" back):
autocmd VimEnter .followup if line('.') != 1 | normal gq${j


function! InsertCloseTag()
" inserts the appropriate closing HTML tag; used for the \hc operation defined
" above;
" requires ignorecase to be set, or to type HTML tags in exactly the same case
" that I do;
" doesn't treat <P> as something that needs closing;
" clobbers register z and mark z
" 
" by Smylers  http://www.stripey.com/vim/
" 2000 May 4

  if &filetype == 'html'

    " list of tags which shouldn't be closed:
    let UnaryTags = ' Area Base Br DD DT HR Img Input LI Link Meta P Param '

    " remember current position:
    normal mz

    " loop backwards looking for tags:
    let Found = 0
    while Found == 0
      " find the previous <, then go forwards one character and grab the first
      " character plus the entire word:
      execute "normal ?\<LT>\<CR>l"
      normal "zyl
      let Tag = expand('<cword>')

      " if this is a closing tag, skip back to its matching opening tag:
      if @z == '/'
        execute "normal ?\<LT>" . Tag . "\<CR>"

      " if this is a unary tag, then position the cursor for the next
      " iteration:
      elseif match(UnaryTags, ' ' . Tag . ' ') > 0
        normal h

      " otherwise this is the tag that needs closing:
      else
        let Found = 1

      endif
    endwhile " not yet found match

    " create the closing tag and insert it:
    let @z = '</' . Tag . '>'
    normal `z
    if col('.') == 1
      normal "zP
    else
      normal "zp
    endif

  else " filetype is not HTML
    echohl ErrorMsg
    echo 'The InsertCloseTag() function is only intended to be used in HTML ' .
      \ 'files.'
    sleep
    echohl None

  endif " check on filetype

endfunction " InsertCloseTag()

function! ToggleTextWrap()
  if &fo =~ 't'
    set fo-=t
  else
    set fo+=t
  endif
endfunction " ToggleTextWrap()


function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> j
    silent! nunmap <buffer> k 
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak 
    set virtualedit=all
    setlocal display+=lastline
    noremap  <buffer> <silent> k   gk
    noremap  <buffer> <silent> j gj
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction


function! RepeatTag(Forward)
" repeats a (non-closing) HTML tag from elsewhere in the document; call
" repeatedly until the correct tag is inserted (like with insert mode <Ctrl>+P
" and <Ctrl>+N completion), with Forward determining whether to copy forwards
" or backwards through the file; used for the \hp and \hn operations defined
" above;
" requires preservation of marks i and j;
" clobbers register z
" 
" by Smylers  http://www.stripey.com/vim/
" 
" 2000 May 4: for `Vim' 5.6

  if &filetype == 'html'

    " if the cursor is where this function left it, then continue from there:
    if line('.') == line("'i") && col('.') == col("'i")
      " delete the tag inserted last time:
      if col('.') == strlen(getline('.'))
        normal dF<x
      else
        normal dF<x
        if col('.') != 1
          normal h
        endif
      endif
      " note the cursor position, then jump to where the deleted tag was found:
      normal mi`j

    " otherwise, just store the cursor position (in mark i):
    else
      normal mi
    endif

    if a:Forward
      let SearchCmd = '/'
    else
      let SearchCmd = '?'
    endif

    " find the next non-closing tag (in the appropriate direction), note where
    " it is (in mark j) in case this function gets called again, then yank it
    " and paste a copy at the original cursor position, and store the final
    " cursor position (in mark i) for use next time round:
    execute "normal " . SearchCmd . "<[^/>].\\{-}>\<CR>mj\"zyf>`i"
    if col('.') == 1
      normal "zP
    else
      normal "zp
    endif
    normal mi

  else " filetype is not HTML
    echohl ErrorMsg
    echo 'The RepeatTag() function is only intended to be used in HTML files.'
    sleep
    echohl None

  endif

endfunction " RepeatTag()
" end of Smylers's .vimrc

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END



autocmd BufNewFile,BufRead *.pde setf arduino
set fo-=t
autocmd FileType py,cpp,c,php,perl,pl set fo-=t 
nmap <F6> :call ToggleWrap()<CR>
set bs=2
" Latex compiles, reverse search and auto-refresh
let g:Tex_ViewRule_dvi = 'xdvi &> /dev/null'
let g:Tex_CompileRule_dvi = 'latex --interaction=nonstopmode -src-specials $*; pkill -USR1 xdvi'
set fo+=l
autocmd FileType tex,bib :call ToggleTextWrap()
autocmd FileType tex,bib :set fo+=t
autocmd FileType tex,bib :set wrap
set nu
"set foldmethod=indent
set foldlevelstart=0
set foldlevel=0
" autocmd FileType tex,c,cpp,h,pl,perl,py,bib,php,sh,txt normal zR
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in setf cmake
autocmd BufRead,BufNewFile *.ctest,*.ctest.in setf cmake
set tabstop=2
hi Underlined ctermfg=6
autocmd FileType html vmap ;sp <Esc>`>a</sup><Esc>`<i<sup><Esc>l
autocmd FileType html vmap ;sb <Esc>`>a</sub><Esc>`<i<sub><Esc>l
autocmd FileType html vmap ;i <Esc>`>a</i><Esc>`<i<i><Esc>l
let html_no_rendering=1

filetype plugin indent on
set grepprg=grep\ -hH\ $*
let g:tex_flavor = "latex"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

set modeline

" for OmniCpp ?
autocmd FileType c,cpp set nocp

" Set up ctags for c/cpp
autocmd FileType c,cpp set tags+=~/.vim/tags/stl
autocmd FileType c,cpp map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr><cr>
autocmd FileType c,cpp noremap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr><cr>
autocmd FileType c,cpp inoremap <F12> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr><cr>

autocmd FileType tex map <C-F12> :!ctags --format=2 --fields=nks %<cr><cr>
autocmd FileType tex noremap <F12> :!ctags --format=2 --fields=nks %<cr><cr>
autocmd FileType tex inoremap <F12> <Esc>:!ctags --format=2 --fields=nks %<cr><cr>
autocmd FileType tex set iskeyword=45,48-58,a-z,A-Z,192-255


" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" Make tabs/trailing whitespace show up

exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

" remap semi-colon to colon
nnoremap ; :
nnoremap : ;

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
