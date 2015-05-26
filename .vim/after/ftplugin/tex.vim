""""" LaTeX
set wrap
set spell
noremap <C-s><C-s> :w \| ! pdflatex %<CR>

" res
nnoremap <C-i>new ggdG:.-1read ~/res/latex/templates/article.tex<CR>
nnoremap <C-i>it :.-1read ~/res/latex/snippets/itemize.tex<CR>jA
nnoremap <C-i>enu :.-1read ~/res/latex/snippets/enumerate.tex<CR>jA
nnoremap <C-i>lst :.-1read ~/res/latex/snippets/lstlisting.tex<CR>ji

nnoremap <C-i>fig :.-1read ~/res/latex/snippets/figure.tex<CR>2k$i
nnoremap <C-i>tab :.-1read ~/res/latex/snippets/table.tex<CR>2kf}f}
nnoremap <C-i>env :.-1read ~/res/latex/snippets/environment.tex<CR>Vk<C-n>$i

nnoremap <C-i>en :.-1read ~/res/latex/snippets/english.tex<CR>
nnoremap <C-i>sv :.-1read ~/res/latex/snippets/swedish.tex<CR>
