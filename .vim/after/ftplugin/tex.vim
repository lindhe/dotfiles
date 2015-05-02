""""" LaTeX
set wrap
set spell
noremap <C-s><C-s> :w \| ! pdflatex %<CR>

" res
nnoremap <C-i>new <Esc>ggdG:.-1read ~/res/latex/default.tex<CR>
nnoremap <C-i>it <Esc>:.-1read ~/res/latex/itemize.tex<CR>k$a
nnoremap <C-i>enu <Esc>:.-1read ~/res/latex/enumerate.tex<CR>k$a
nnoremap <C-i>fig <Esc>:.-1read ~/res/latex/figure.tex<CR>2k$i
nnoremap <C-i>tab <Esc>:.-1read ~/res/latex/table.tex<CR>2kf}f}

" one liners
inoremap \inp \input{}<Esc>i
inoremap \usp \usepackage{}<Esc>i
