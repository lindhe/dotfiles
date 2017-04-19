" Configs:
set spell

""""" LaTeX
noremap <C-s><C-s> :w \| ! pdflatex -shell-escape %<CR>

" Templates
nnoremap <C-i>article ggdG:.-1read ~/res/latex/templates/article.tex<CR>
nnoremap <C-i>letter ggdG:.-1read ~/res/latex/templates/letter.tex<CR>
nnoremap <C-i>report ggdG:.-1read ~/res/latex/templates/report.tex<CR>

" Snippets
nnoremap <C-i>en :.-1read ~/res/latex/snippets/english.tex<CR>
nnoremap <C-i>sv :.-1read ~/res/latex/snippets/swedish.tex<CR>
nnoremap <C-i>it :.-1read ~/res/latex/snippets/itemize.tex<CR>jA
nnoremap <C-i>enu :.-1read ~/res/latex/snippets/enumerate.tex<CR>jA
nnoremap <C-i>lst :.-1read ~/res/latex/snippets/lstlisting.tex<CR>ji
nnoremap <C-i>fig :.-1read ~/res/latex/snippets/figure.tex<CR>2j$i
nnoremap <C-i>tab :.-1read ~/res/latex/snippets/table.tex<CR>2jf}f}
nnoremap <C-i>env :.-1read ~/res/latex/snippets/environment.tex<CR>Vj<C-n>$i
nnoremap <C-i>eq :.-1read ~/res/latex/snippets/equation.tex<CR>jA
nnoremap <C-i>mini :.-1read ~/res/latex/snippets/minipage.tex<CR>jjA<tab>

