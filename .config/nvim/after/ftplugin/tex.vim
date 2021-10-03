" LaTeX
setlocal spell
setlocal tabstop=4
setlocal shiftwidth=4
setlocal textwidth=0
setlocal wrap
setlocal foldmethod=marker

" """"""""""""""""""""""""""""""     Shortcuts     """"""""""""""""""""""""""""""
noremap <F12> :w \| call Compile()<CR>

""""""""""""""""""""""""""""""     Templates     """"""""""""""""""""""""""""""
nnoremap <C-i>art ggdG:.-1read ~/res/latex/templates/article.tex<CR>
nnoremap <C-i>let ggdG:.-1read ~/res/latex/templates/letter.tex<CR>
nnoremap <C-i>rep ggdG:.-1read ~/res/latex/templates/report.tex<CR>
nnoremap <C-i>pro ggdG:.-1read ~/res/latex/templates/protocol.tex<CR>

"""""""""""""""""""""""""""""""     Snippets     """""""""""""""""""""""""""""""
nnoremap <C-i>en :.-1read ~/res/latex/snippets/english.tex<CR>
nnoremap <C-i>sv :.-1read ~/res/latex/snippets/swedish.tex<CR>
nnoremap <C-i>it :.-1read ~/res/latex/snippets/itemize.tex<CR>jA
nnoremap <C-i>enu :.-1read ~/res/latex/snippets/enumerate.tex<CR>jA
nnoremap <C-i>lst :.-1read ~/res/latex/snippets/lstlisting.tex<CR>ji
nnoremap <C-i>fig :.-1read ~/res/latex/snippets/figure.tex<CR>2j$i
nnoremap <C-i>subfig :.-1read ~/res/latex/snippets/subfigures.tex<CR>
nnoremap <C-i>tab :.-1read ~/res/latex/snippets/table.tex<CR>2jf}f}
nnoremap <C-i>env :.-1read ~/res/latex/snippets/environment.tex<CR>Vj<C-n>$i
nnoremap <C-i>eq :.-1read ~/res/latex/snippets/equation.tex<CR>jA
nnoremap <C-i>mini :.-1read ~/res/latex/snippets/minipage.tex<CR>jjA<tab>

""""""""""""""""""""""""""""""     Functions     """"""""""""""""""""""""""""""
" Smart compile function that checks if comile script exsists:
function! Compile()
    if filereadable("compile.sh")
        echo "Using compile script"
        execute '!./compile.sh'
    else
        echo "Compiling with pdflatex"
        execute '!pdflatex -shell-escape %'
    endif
endfunction

" `Smart` wordcount for LaTeX
let g:word_count="<unknown>"
function! WordCount()
    return g:word_count
endfunction

function! UpdateWordCount()
    let filename = expand("%")
    let cmd = "detex " . filename . " | wc -w | tr -d '[:space:]'"
    let result = system(cmd)
    let g:word_count = result
endfunction

setlocal updatetime=1000
augroup WordCounter
    au! CursorHold,CursorHoldI * call UpdateWordCount()
augroup END

""""""""""""""""""""""""""""     User Interface     """"""""""""""""""""""""""""
setlocal statusline+=\(%{WordCount()}\ w)

"""""""""""""""""""""""""""""""     Writing     """""""""""""""""""""""""""""""

inoremap .<space> .<CR>

""""""""""""""""""""""""""""     Proof reading     """"""""""""""""""""""""""""
nnoremap hn ]s
nnoremap hy [s
