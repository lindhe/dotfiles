" Configs:
setlocal spell
setlocal textwidth=0
setlocal wrap

" Looks
setlocal nocursorline
setlocal nocursorcolumn

"""" MarkDown
noremap <F12> :w \| ! pandoc % -s -o %:r.pdf --variable=geometry:a4paper<CR>
inoremap .<space> .<CR>
