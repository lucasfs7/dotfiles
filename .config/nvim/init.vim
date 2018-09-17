call plug#begin('~/.config/nvim/bundle')

" vim interface
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'junegunn/limelight.vim'

" tools
Plug 'itchyny/vim-gitbranch'
Plug 'tpope/vim-unimpaired'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-surround'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'bronson/vim-trailing-whitespace'
Plug 'mbbill/undotree'
Plug 'danro/rename.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'

" languages
Plug 'tpope/vim-markdown'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'

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
set updatetime=100
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0
let g:indent_guides_guide_size = 1

" colorscheme
color dracula
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

" fzf binds
nmap <C-P> :GFiles<CR>

" fzf configs
let g:fzf_layout = { 'up': '20%' }

" allways show status bar
set laststatus=2

" configure lightline
let g:lightline = {
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
