"e""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic vimrc ----- Yang TianYu 
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","    " 比较习惯用;作为命令前缀，右手小拇指直接能按到

" 把空格键映射成:
nmap <space> :

" 快捷打开编辑vimrc文件的键盘绑定
map <silent> <leader>ee :e $HOME/.vimrc<cr>
autocmd! bufwritepost *.vimrc source $HOME/.vimrc

" ^z快速进入shell
nmap <C-Z> :shell<cr>
inoremap <leader>n <esc>

" 判断操作系统
if (has("win32") || has("win64") || has("win32unix"))
    let g:isWin = 1
else
    let g:isWin = 0
endif

" 判断是终端还是gvim
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

set nocompatible
syntax enable       
filetype plugin on  
filetype indent on
set shortmess=atI   
set autoindent
autocmd BufEnter * :syntax sync fromstart
autocmd BufWritePre *.c,*.h :%s/\s\+$//e
set nu              
set showcmd     
set lz          
set hid             
set backspace=eol,start,indent
set whichwrap+=<,>,h,l 
set incsearch   
set nohlsearch
set hlsearch    
"set ignorecase  
set magic       
set showmatch   
set nobackup    
set nowb
set noswapfile  
set lbr         
set ai          
set si      
set cindent     
set wildmenu
set nofen
set fdl=10

" tab转化为4个字符
set autoindent
set smarttab
set cindent 


autocmd BufRead,BufNewFile *.h setlocal filetype=c

" 编辑时按 Tab 键插入空格
"set expandtab          " 将 Tab 键转为空格
"set tabstop=4          " Tab 字符宽度设置为 4
"set shiftwidth=4       " 缩进宽度设置为 4
"set softtabstop=4      " 编辑时 Tab 的行为

"" 配置进入编辑模式时使用空格
"autocmd FileType * setlocal expandtab
"autocmd FileType * autocmd InsertEnter * setlocal expandtab
"autocmd FileType * autocmd InsertLeave * setlocal noexpandtab

"" 在保存和格式刷时调整缩进
"autocmd FileType * autocmd BufWritePre * setlocal noexpandtab
"autocmd FileType * autocmd BufWritePre * execute 'normal! gg=G' 
"autocmd FileType * autocmd BufWritePre * setlocal expandtab         
"autocmd FileType * autocmd BufWritePre * retab!                     

" 编辑时按 Tab 键插入空格
set expandtab           " 将 Tab 键转为空格
set tabstop=2           " Tab 字符宽度设置为 4
set shiftwidth=2        " 缩进宽度设置为 4
set softtabstop=2       " 编辑时 Tab 的行为

autocmd BufWritePre * retab!


" 不使用beep或flash 
set vb t_vb=

set history=400   " vim记住的历史操作的数量，默认的是20
set autoread      " 当文件在外部被修改时，自动重新读取
set mouse=a       " 在所有模式下都允许使用鼠标，还可以是n,v,i,c等
set fdm=syntax    " 开启折叠: 按语法折叠

set cinoptions+=L0

"setlocal indentexpr=GetCustomIndent()

"function! GetCustomIndent()
"let l:line = getline(v:lnum - 1)
"if l:line =~ '^#\s*define' && l:line !~ ';$'
"return indent(v:lnum - 1)
"else
"return cindent(v:lnum)
"endif
"endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
"set background=light
set t_Co=256
set cursorline            "高亮当前行
set cursorcolumn          "高亮当前列
if (g:isGUI)
    colorscheme wombat
    hi cursorline guibg=#333333
    hi CursorColumn guibg=#333333
    "set guifont=Consolas\ 10
    "set guifontwide=Consolas\ 10
    set guifont=DejaVu\ Sans\ Mono\ 10
    set gfw=DejaVu\ Sans\ Mono\ 10
    " 不显示toolbar
    set guioptions-=T
    " 不显示菜单栏
    "set guioptions-=m
else
    "colorscheme wombat256mod
    "colorscheme koehler
    "hi cursorline guibg=#333333
    "hi CursorColumn guibg=#333333
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""






" 设置字符集编码，默认使用utf8
if (g:isWin)
    let &termencoding=&encoding " 通常win下的encoding为cp936
    set fileencodings=utf8,cp936,ucs-bom,latin1
else
    set encoding=utf8
    set fileencodings=utf8,gb2312,gb18030,ucs-bom,latin1
endif

" 状态栏
set laststatus=2      " 总是显示状态栏
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
" 获取当前路径，将$HOME转化为~
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction
set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\ \".&fenc)}\ \|\ %{$USER}\ @\ %{hostname()}\



" 第80列往后加下划线
"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

" 根据给定方向搜索当前光标下的单词，结合下面两个绑定使用
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'b'
        execute "normal ?" . l:pattern . "<cr>"
    else
        execute "normal /" . l:pattern . "<cr>"
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
" 用 */# 向 前/后 搜索光标下的单词
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" 在文件名上按gf时，在新的tab中打开
"map gf :tabnew <cfile><cr>


" 用c-j,k在buffer之间切换
"nn <C-J> :bn<cr>
"nn <C-K> :bp<cr>

" Bash(Emacs)风格键盘绑定
imap <C-e> <END>
imap <C-a> <HOME>
"imap <C-u> <esc>d0i
"imap <C-k> <esc>d$i  " 与自动补全中的绑定冲突

"从系统剪切板中复制，剪切，粘贴
map <F7> "+y
map <F8> "+x
map <F9> "+p
"map taglist short key
map <silent> <F10> :TlistToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""
" 用 c-j,c-k 在 tab 之间切换
"""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <C-A> :tabnew

nn <C-J> :tabn<cr>
nn <C-K> :tabp<cr>

"nmap <F2> :%s///gc
nmap <F2> :.,$s///gc


" use ,. to copy a word quickly
nmap <leader>. wbvey
" use ,, to search "0 in shell
if executable('ag')
    map <leader><leader> wbvey:!ag <C-R>0 <cr>
else
    map <leader><leader> wbvey:!grep -rn <C-R>0 * <cr>
endif


nmap qq :q<cr>


" 恢复上次文件打开位置
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" 删除buffer时不关闭窗口
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction


" 快捷输入
" 自动完成括号和引号
inoremap <leader>1 ()<esc>:let leavechar=")"<cr>i
inoremap <leader>2 []<esc>:let leavechar="]"<cr>i
inoremap <leader>3 {}<esc>:let leavechar="}"<cr>i
inoremap <leader>4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap <leader>q ''<esc>:let leavechar="'"<cr>i
inoremap <leader>w ""<esc>:let leavechar='"'<cr>i


" 插件窗口的宽度，如TagList,NERD_tree等，自己设置
let s:PlugWinSize = 25

" taglist.vim
" http://www.vim.org/scripts/script.php?script_id=273
" <leader>t 打开TagList窗口，窗口在右边
"map <silent> <t> :TlistToggle<cr>
"let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_GainFocus_On_ToggleOpen = 0
let Tlist_WinWidth = s:PlugWinSize
let Tlist_Auto_Open = 0
let Tlist_Display_Prototype = 0
"let Tlist_Close_On_Select = 1


" OmniCppComplete.vim
" http://www.vim.org/scripts/script.php?script_id=1520
set completeopt=menu
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_DefaultNamespaces = ["std"]     " 逗号分割的字符串
let OmniCpp_MayCompleteScope = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_SelectFirstItem = 2
" c-j自动补全，当补全菜单打开时，c-j,k上下选择
imap <expr> <c-j>      pumvisible()?"\<C-N>":"\<C-X><C-O>"
imap <expr> <c-k>      pumvisible()?"\<C-P>":"\<esc>"
" f:文件名补全，l:行补全，d:字典补全，]:tag补全
imap <C-]>             <C-X><C-]>
imap <C-F>             <C-X><C-F>
imap <C-D>             <C-X><C-D>
imap <C-L>             <C-X><C-L>

" tag 跳转
nmap <leader>] <C-W>10]
nmap <leader>3 :tnext<cr>
nmap <leader>2 :tprev<cr>
nmap <leader>1 :tfirst<cr>
nmap <leader>4 :tlast<cr>


" NERD_commenter.vim
" http://www.vim.org/scripts/script.php?script_id=1218
" Toggle单行注释/“性感”注释/注释到行尾/取消注释
map <leader>cc ,c<space>
map <leader>cs ,cs
map <leader>c$ ,c$
map <leader>cu ,cu

" NERD tree
" http://www.vim.org/scripts/script.php?script_id=1658
let NERDTreeShowHidden = 1
let NERDTreeWinPos = "left"
let NERDTreeWinSize = s:PlugWinSize
let NERDTreeShowBookmarks = 1
" let loaded_netrwPlugin = 0
nmap <leader>n :NERDTreeToggle<cr>
nmap <leader>m :NERDTreeFind<cr>

" 更新ctags和cscope索引
" href: http://www.vimer.cn/2009/10/把vim打造成一个真正的ide2.html
" 稍作修改，提取出DeleteFile函数，修改ctags和cscope执行命令
map <F6> :call Do_CsTag()<cr>
function! Do_CsTag()
    let dir = getcwd()

    "先删除已有的tags和cscope文件，如果存在且无法删除，则报错。
    if ( DeleteFile(dir, "tags") ) 
        return 
    endif
    if ( DeleteFile(dir, "cscope.files") ) 
        return 
    endif
    if ( DeleteFile(dir, "cscope.out") ) 
        return 
    endif

    if(executable('ctags'))
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:isWin)
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        else
            silent! execute "!find . -iname '*.[ch]' -o -name '*.cpp' > cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
    " 刷新屏幕
    execute "redr!"
endfunction

function! DeleteFile(dir, filename)
    if filereadable(a:filename)
        if (g:isWin)
            let ret = delete(a:dir."\\".a:filename)
        else
            let ret = delete("./".a:filename)
        endif
        if (ret != 0)
            echohl WarningMsg | echo "Failed to delete ".a:filename | echohl None
            return 1
        else
            return 0
        endif
    endif
    return 0
endfunction

" cscope 绑定
if has("cscope")
    set csto=1
    set cst
    set nocsverb
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
    " s: C语言符号  g: 定义     d: 这个函数调用的函数 c: 调用这个函数的函数
    " t: 文本       e: egrep模式    f: 文件     i: include本文件的文件
    nmap <leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sc :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <leader>si :cs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap <leader>sd :cs find d <C-R>=expand("<cword>")<CR><CR>
    "    nmap <leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    "    nmap <leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>
    "    nmap <leader>sc :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    "    nmap <leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    "    nmap <leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
    "    nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
    "    nmap <leader>si :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
    "    nmap <leader>sd :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
endif

" Quick Fix 设置
map <F3> :cw<cr>
map <F4> :cp<cr>
map <F5> :cn<cr>

" 复制垂直分屏
nmap <leader>v <C-W>v

" 复制水平分屏
nmap <leader>h <C-W>s

" Buffers Explorer （需要genutils.vim）
" http://vim.sourceforge.net/scripts/script.php?script_id=42
" http://www.vim.org/scripts/script.php?script_id=197
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = s:PlugWinSize  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber
nmap <silent> <Leader>b :BufExplorer<CR>

" Vimwiki配置
let g:vimwiki_list = [{'path': '~/Dropbox/MyWiki/my_site/',
            \ 'path-html': '~/Dropbox/MyWiki/my_site_html/',
            \ 'html-header': '~/Dropbox/MyWiki/templates/header.tpl',
            \ 'html-footer': '~/Dropbox/MyWiki/templates/footer.tpl'}]
let g:vimwiki_camel_case=0

let wiki = {}
let wiki.path = '~/Dropbox/MyWiki/my_site/'
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
let g:vimwiki_list = [wiki]

"pythoncomplete配置
autocmd filetype python set omnifunc=pythoncomplete#Complete

set splitright

autocmd FileType terminal set splitright

nnoremap <silent> <leader>t :set splitright<CR>:vsp<CR>:terminal<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set runtimepath+=~/.vim/bundle/YouCompleteMe
"let g:ycm_collect_identifiers_from_tags_files = 1           " 开启 YCM 基于标签引擎
"let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释与字符串中的内容也用于补全
"let g:syntastic_ignore_files=[".*\.py$"]
"let g:ycm_seed_identifiers_with_syntax = 1                  " 语法关键字补全
"let g:ycm_complete_in_comments = 1
"let g:ycm_confirm_extra_conf = 0
"let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']  " 映射按键, 没有这个会拦截掉tab, 导致其他插件的tab不能用.
"let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
"let g:ycm_complete_in_comments = 1                          " 在注释输入中也能补全
"let g:ycm_complete_in_strings = 1                           " 在字符串输入中也能补全
"let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释和字符串中的文字也会被收入补全
"let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_show_diagnostics_ui = 0                           " 禁用语法检查
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" |            " 回车即选中当前项
"nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>|     " 跳转到定义处
"let g:ycm_min_num_of_chars_for_completion=2                 " 从第2个键入字符就开始罗列匹配项
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" 定义全局变量，用于记录当前使用的颜色索引
let g:current_color_index = 0


highlight MatchOne guifg=#FF0000 guibg=#FFFF80 ctermfg=Red ctermbg=Yellow
highlight MatchTwo guifg=#00FF00 guibg=#002200 ctermfg=Green ctermbg=Black
highlight MatchThree guifg=#0000FF guibg=#D0D0FF ctermfg=Blue ctermbg=White
highlight MatchFour guifg=#FFD700 guibg=#3F3F00 ctermfg=Yellow ctermbg=Brown
highlight MatchFive guifg=#FF1493 guibg=#FFE0F0 ctermfg=Red ctermbg=White
highlight MatchSix guifg=#00FFFF guibg=#001F1F ctermfg=Cyan ctermbg=Black
highlight MatchSeven guifg=#FF8C00 guibg=#302010 ctermfg=Yellow ctermbg=Red
highlight MatchEight guifg=#9400D3 guibg=#E6D6FF ctermfg=Magenta ctermbg=White
highlight MatchNine guifg=#1E90FF guibg=#001A4D ctermfg=Blue ctermbg=Black
highlight MatchTen guifg=#FFD700 guibg=#4D4D00 ctermfg=Yellow ctermbg=Brown


function! AddHighlight(...)
    " 获取传入的多个词汇
    let words = a:000
    let colors = ['MatchOne', 'MatchTwo', 'MatchThree', 'MatchFour', 'MatchFive',
                  \ 'MatchSix', 'MatchSeven', 'MatchEight', 'MatchNine', 'MatchTen']

    " 检查是否有传入词汇
    if len(words) == 0
        echo "No words provided"
        return
    endif

    " 遍历每个词汇并高亮
    for i in range(len(words))
        let word = words[i]

        " 如果词汇不为空
        if word != ''
            " 获取当前颜色
            let color = colors[g:current_color_index]

            " 使用 matchadd() 添加高亮
            call matchadd(color, '\<' . word . '\>')

            " 更新颜色索引，循环使用颜色
            let g:current_color_index = (g:current_color_index + 1) % len(colors)
        endif
    endfor
endfunction


" 定义命令来高亮多个词汇
command! -nargs=+ HighlightWords call AddHighlight(<f-args>)

" 光标单词高亮
nnoremap <leader>t :call AddHighlight(expand('<cword>'))<CR>

" 定义快捷键：手动输入多个词汇进行高亮
nnoremap <leader>T :call AddHighlight(input('Enter words to highlight (space separated): '))<CR>


" 定义快捷键：清除所有高亮
nnoremap <leader>c :call clearmatches()<CR>


