" Install plug.vim if not already installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Intellisense like plugin
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Linting plugin
Plug 'neomake/neomake'

" Filebrowser sidebar
Plug 'scrooloose/nerdtree'

" Bottom status bar with useful infos
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" Base16 themes
Plug 'chriskempson/base16-vim'

" Languages support
" Rust
Plug 'rust-lang/rust.vim'
" Jsonnet
Plug 'google/vim-jsonnet'
" Terraform
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
" Graphql
Plug 'jparise/vim-graphql'

" Initialize plugin system
call plug#end()
