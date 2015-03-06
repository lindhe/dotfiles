""""" LaTeX
set wrap
noremap <C-s><C-s> :! pdflatex %<enter>

" res
nnoremap <C-i>new <Esc>ggdG:.-1read ~/res/latex/default.tex<Enter>
nnoremap <C-i>it <esc>:.-1read ~/res/latex/itemize.tex<enter>j$a
nnoremap <C-i>en <esc>:.-1read ~/res/latex/enumerate.tex<enter>j$a
nnoremap <C-i>fig <esc>:.-1read ~/res/latex/figure.tex<enter>jj$i

" one liners
nnoremap <C-i>ip i\input{}<esc>i


