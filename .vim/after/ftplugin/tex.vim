""""" LaTeX
set wrap
set spell
noremap <C-s><C-s> :w \| ! pdflatex %<CR>

" res
nnoremap <C-i>new <Esc>ggdG:.-1read ~/res/latex/default.tex<CR>
nnoremap <C-i>it <Esc>:.-1read ~/res/latex/itemize.tex<CR>j$a
nnoremap <C-i>en <Esc>:.-1read ~/res/latex/enumerate.tex<CR>j$a
nnoremap <C-i>fig <Esc>:.-1read ~/res/latex/figure.tex<CR>2j$i
nnoremap <C-i>tab <Esc>:.-1read ~/res/latex/table.tex<CR>2jf}f}

" one liners
nnoremap <C-i>ip i\input{}<Esc>i
nnoremap <C-i>us <Esc>:.-1read ~/res/latex/usepackage.tex<CR>$i

