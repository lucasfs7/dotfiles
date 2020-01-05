call plug#begin('~/.config/nvim/bundle')

" vim interface
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'arcticicestudio/nord-vim'

" tools
Plug 'tpope/vim-unimpaired'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'bronson/vim-trailing-whitespace'
Plug 'mbbill/undotree'
Plug 'danro/rename.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'liuchengxu/vista.vim'
Plug 'wellle/context.vim'
Plug 'brooth/far.vim'

" languages
Plug 'tpope/vim-markdown'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'
Plug 'dbeniamine/todo.txt-vim'
Plug 'zah/nim.vim'

call plug#end()

" general
set ruler
set wildmenu
set ignorecase
set smartcase
set hlsearch
set encoding=utf8
set ffs=unix,dos,mac
set nobackup
set nowb
set noswapfile
set clipboard=unnamedplus
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0
set noshowmode

" colorscheme
colorscheme nord
let g:limelight_conceal_ctermfg = 240
hi Normal guibg=NONE
hi Normal ctermbg=NONE

" tabs
set smartindent
set autoindent
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" lines
set lbr
set tw=500
set wrap
set number relativenumber

" disable arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" toggle undo tree
nmap <A-u> :UndotreeToggle<cr>

" enter writing mode
nmap <A-w> :Goyo<cr>:Limelight<cr>

" javascript concealing characters
set conceallevel=1
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "ø"

" fzf
nmap <C-P> :GFiles<CR>
nmap <C-I> :Files<CR>
nmap <C-B> :Buffers<CR>
let g:fzf_layout = { 'up': '100%' }

" search tags/symbols
nmap <C-O> :Vista finder<CR>
nmap <A-o> :Vista!!<CR>

" context settings
let g:context_enabled = 0
nmap <A-c> :ContextToggle<CR>

" allways show status bar
set laststatus=2

" configure lightline
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ 'tab_component_function': {
      \   'filename': 'LightlineTabname',
      \ }
      \ }

" show filename with path relative
" to project root (using git)
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'gitbranch_path'), ':h:h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%') !=# '' ? expand('%') : '[No Name]'
endfunction

" show tabname with path relative
" to current file dir (dir/file.ext)
function! LightlineTabname(n) abort
  let bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  let fname = expand('#' . bufnr . ':t')
  let dname = expand('#' . bufnr . ':h:t')
  let fpath = dname.'/'.fname
  return fname !=# '' ? fpath : '[No Name]'
endfunction
