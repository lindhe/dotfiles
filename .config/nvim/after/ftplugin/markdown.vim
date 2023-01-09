" Configs:
setlocal spell
setlocal textwidth=0
setlocal wrap
setlocal shiftwidth=4
setlocal tabstop=4

" Looks
setlocal nocursorline
setlocal nocursorcolumn

"""" MarkDown
noremap <F12> :w \| ! pandoc % -s -o %:r.pdf --variable=geometry:a4paper<CR>

"""""""""""""""""""""""""""""""     Typing     """""""""""""""""""""""""""""""
inoremap .<space> .<CR>
inoremap <C-space>  
