source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/theme.vim

" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
set completeopt=menuone,noselect,noinsert

" Automatically format code when saving
let g:rustfmt_autosave = 1

let g:LanguageClient_autoStart = 1

" Yaml configuration
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Terragrunt configuration
au! BufNewFile,BufRead terragrunt.hcl set filetype=terraform syntax=terraform

" Trigger linter
autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_open_list = 2
let g:neomake_ruby_rubocop_exe='cookstyle'
