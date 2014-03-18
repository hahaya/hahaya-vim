"============================================================
"============================================================
"
"		|   |     /\     |   |     /\     \   /    /\
"		|   |    /  \    |   |    /  \     \ /    /  \
"		|---|   /--- \   |---|   /----\     |    /----\
"		|   |  /      \  |   |  /      \    |   /      \
"		|   | /        \ |   | /        \   |  /        \
"
"    FileName:  .vimrc
"    Author:    hahaya
"    Version:   1.0.0
"    Email:     hahayacoder@gmail.com
"    Blog:      http://hahaya.github.com
"    Date:      2013-7-23
"    Change:    2014-03-18
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
"配置主题后再开启该这两个功能(比如solarized) 否则会很难看
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
""==============================================================
"
"" Vundle插件管理和配置项
"
""==============================================================
"==============================================================
"
""开始使用Vundle的必须配置
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"=== 使用Vundle来管理Vundle ===
Bundle 'gmarik/vundle'
"
""=== PowerLine插件 状态栏增强展示 ===
Bundle 'Lokaltog/vim-powerline'
"vim有一个状态栏 加上powline则有两个状态栏
set laststatus=2
set t_Co=256
let g:Powline_symbols='fancy'


"=== YouCompleteMe 自动补全插件 迄今为止用到的最好的自动VIM自动补全插件===
Bundle 'Valloric/YouCompleteMe'
""自动补全配置插件路径
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
"youcompleteme 默认tab s-tab 和自动补全冲突
"自动补全时向下选择补全项
let g:ycm_key_list_select_completion = ['<Down>']
"自动补全时向上选择补全项
let g:ycm_key_list_previous_completion = ['<Up>']"
"在自动补全时 默认会在vim顶部出现一个提示窗口(preview窗口) 很扰乱视野
"这样设置从不出现preview窗口 可以试试加上和不加上此项的效果
"根据个人喜欢是否出现preview窗口
"即补全窗口不以分割窗口出现 只出现补全列表
set completeopt-=preview
"语法分析时 有警告时出现在左边的符号
let g:ycm_warning_symbol = '>>'
"语法分析时 有错误出现在左边的符号
let g:ycm_error_symbol = 'xx'
"设置在注释中 补全功能仍然有效
let g:ycm_complete_in_comments = 1

"=== 主题solarized ===
Bundle 'altercation/vim-colors-solarized'
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"

"设置当前使用的主题
colorscheme solarized
set background=dark
set t_Co=256

"Vundle配置必须 开启插件
filetype plugin indent on
