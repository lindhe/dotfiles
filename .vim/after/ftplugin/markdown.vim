" Configs:
set spell

"""" MarkDown
noremap <C-s><C-s> :w \| ! pandoc % -s -o %:r.pdf --variable=geometry:a4paper<CR>

