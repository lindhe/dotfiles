" Configs:
setlocal spell

"""" MarkDown
noremap <F12> :w \| ! pandoc % -s -o %:r.pdf --variable=geometry:a4paper<CR>

