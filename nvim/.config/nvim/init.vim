" Install plug.vim if not already installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Base16 themes
Plug 'chriskempson/base16-vim'

" v2 of the nvim-completion-manager.
Plug 'ncm2/ncm2'
" dependency for ncm2
Plug 'roxma/nvim-yarp'

" Initialize plugin system
call plug#end()

" Access colors present in 256 colorspace
let base16colorspace=256
" Sets base16 color theme
colorscheme base16-eighties

" Enable completion for any buffer
autocmd BufEnter  *  call ncm2#enable_for_buffer()

" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
set completeopt=menuone,noselect,noinsert
