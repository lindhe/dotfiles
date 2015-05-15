""""" LaTeX
set wrap
set spell
noremap <C-s><C-s> :w \| ! pdflatex %<CR>

" res
nnoremap <C-i>new ggdG:.-1read ~/res/latex/default.tex<CR>
nnoremap <C-i>it :.-1read ~/res/latex/itemize.tex<CR>jA
nnoremap <C-i>enu :.-1read ~/res/latex/enumerate.tex<CR>jA
nnoremap <C-i>lst :.-1read ~/res/latex/lstlisting.tex<CR>ji

nnoremap <C-i>fig :.-1read ~/res/latex/figure.tex<CR>2k$i
nnoremap <C-i>tab :.-1read ~/res/latex/table.tex<CR>2kf}f}
