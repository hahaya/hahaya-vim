"============================================================
"============================================================
"
"		|   |     /\     |   |     /\     \   /    /\
"		|   |    /  \    |   |    /  \     \ /    /  \
"		|---|   /--- \   |---|   /----\     |    /----\
"		|   |  /      \  |   |  /      \    |   /      \
"		|   | /        \ |   | /        \   |  /        \
"
"    FileName:	.vimrc
"    Author: 	hahaya
"    Version:	1.0.0
"    Email:	hahayacoder@gmail.com
"    Blog:	http://hahaya.github.com
"    Date:	2013-7-23
"    Change: 2013-10-21
"============================================================
"============================================================



"=============================================================
"=============================================================
"
"    Vim基本配置
"
"=============================================================
"=============================================================

"关闭vi的一致性模式 避免以前版本的一些Bug和局限
set nocompatible
"配置backspace键工作方式
set backspace=indent,eol,start


"显示行号
set number
"设置在编辑过程中右下角显示光标的行列信息
set ruler
"当一行文字很长时取消换行
"set nowrap

"在状态栏显示正在输入的命令
set showcmd

"设置历史记录条数
set history=1000

"设置取消备份 禁止临时文件生成
set nobackup
set noswapfile

"突出现实当前行列、高亮当前行列
set cursorline
set cursorcolumn

"设置匹配模式 类似当输入一个左括号时会匹配相应的那个右括号
set showmatch

"设置C/C++方式自动对齐
set autoindent
set cindent

"开启语法高亮功能
syntax enable
syntax on

"指定配色方案为256色
set t_Co=256

"设置搜索时忽略大小写
set ignorecase

"设置在Vim中可以使用鼠标 防止在Linux终端下无法拷贝
set mouse=a

"设置Tab宽度
set tabstop=4
"设置自动对齐空格数
set shiftwidth=4
"设置按退格键时可以一次删除4个空格
set softtabstop=4
"设置按退格键时可以一次删除4个空格
set smarttab
"将Tab键自动转换成空格 真正需要Tab键时使用[Ctrl + V + Tab]
set expandtab

"设置编码方式
set encoding=utf-8
"自动判断编码时 依次尝试一下编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1



"检测文件类型
filetype on
"针对不同的文件采用不同的缩进方式
filetype indent on
"允许插件
filetype plugin on
"启动智能补全
filetype plugin indent on

"===================================================================
"===================================================================
"
"   自定义vim操作
"
"====================================================================
"====================================================================
map <F5> :call Do_OneFileMake()<CR>
map <F2> :call Do_FileSave()<CR>
map <F3> :call Do_FileSaveAndQuit()<CR>

" === 当前文件保存 ===
function Do_FileSave()
    let source_file_name=expand("%:t")
    if source_file_name==""
        echoh1 WarningMsg | echo "The file name is empty." | echoh1 None
        return
    endif

    execute "w"
endfunction

" === 当前文件保存退出 ===
function Do_FileSaveAndQuit()
    let source_file_name=expand("%:t")
    if source_file_name==""
        echoh1 WarningMsg | echo "The file name is empty." | echoh1 None
        return
    endif

    execute "wq"
endfunction



" === 单文件编译 仅支持c、cc、cpp、go文件 ===
function Do_OneFileMake()
    if expand("%:p:h")!=getcwd()
        echoh1 WarningMsg | echo "Failed to make. This's file is not in the current dir." | echoh1 None
        return
    endif

    let source_file_name=expand("%:t")

    if source_file_name==""
        echoh1 WarningMsg | echo "The file name is empty." | echoh1 None
        return
    endif

    if ( (&filetype!="c")&&(&filetype!="cc")&&(&filetype!="cpp")&&(&filetype!="go") )
    echoh1 WarningMsg | echo "Please just make c、cc、cpp and go file." | echoh1 None
        return
    endif

    if &filetype=="c"
        set makeprg=gcc\ %\ -o\ %<
    endif

    execute "w"
    execute "silent make"
    execute "q"
endfunction


"==============================================================
"==============================================================
"
"   Vundle插件管理和配置项
"
"==============================================================
"==============================================================

"开始使用Vundle的必须配置
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"=== 使用Vundle来管理Vundle ===
Bundle 'gmarik/vundle'

"=== PowerLine插件 状态栏增强展示 ===
Bundle 'Lokaltog/vim-powerline'
"vim有一个状态栏 加上powline则有两个状态栏
set laststatus=2
set t_Co=256
let g:Powline_symbols='fancy'

"=== The-NERD-tree 目录导航插件 ===
Bundle 'vim-scripts/The-NERD-tree'
"开启目录导航快捷键映射成n键
nnoremap <silent> n :NERDTreeToggle<CR>
"高亮鼠标所在的当前行
let NERDTreeHighlightCursorline=1

"=== Tagbar 标签导航 ===
Bundle 'majutsushi/tagbar'
"标签导航快捷键
nmap <F9> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

"=== A 头文件和实现文件自动切换插件 ===
Bundle 'vim-scripts/a.vim'
"将切换的快捷键映射成<F4> Qt中使用该快捷键习惯了
nnoremap <silent> <F4> :A<CR>

"=== ctrlp 文件搜索插件 不需要外部依赖包 ===
Bundle 'kien/ctrlp.vim'
"设置开始文件搜索的快捷键
let g:ctrlp_map = '<leader>p'
"设置默认忽略搜索的文件格式
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$'
"设置搜索时显示的搜索结果最大条数
let g:ctrlp_max_height=15

"=== YouCompleteMe 自动补全插件 迄今为止用到的最好的自动VIM自动补全插件===
Bundle 'Valloric/YouCompleteMe'
"自动补全配置插件路径
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
"youcompleteme 默认tab s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
"let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
"let g:ycm_key_list_previous_completion = ['<Up>']"

"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
"let g:UltiSnipsExpandTrigger="<c-j>"
"当选择了一项后自动关闭自动补全提示窗口
"let g:ycm_autoclose_preview_window_after_completion=1

"=== 自动补全单引号、双引号、括号等 ===
Bundle 'Raimondi/delimitMate'


"=== 主题solarized ===
Bundle 'altercation/vim-colors-solarized'
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"

"=== 主题 molokai ===
Bundle 'tomasr/molokai'
"设置主题
colorscheme molokai
set background=dark
set t_Co=256

"=== indentLine代码排版缩进标识 ===
Bundle 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
"缩进的显示标识|
let g:indentLine_char = '¦'

"=== vim-trailing-whitespace将代码行最后无效的空格标红 ===
Bundle 'bronson/vim-trailing-whitespace'

"=== markdown编辑插件 ===
Bundle 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled=1

"=== golang编辑插件 ===
Bundle 'jnwhiteh/vim-golang'


"Vundle配置必须 开启插件
filetype plugin indent on

"====================================================================
"====================================================================
"   vim配色
"
"====================================================================
"====================================================================
