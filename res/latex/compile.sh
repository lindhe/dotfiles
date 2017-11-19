#!/bin/bash
MAINFILE=main
pdflatex -shell-escape -haltonerror $MAINFILE.tex &&\
bibtex8 $MAINFILE.aux;\
pdflatex -shell-escape -haltonerror $MAINFILE.tex &&\
pdflatex -shell-escape -haltonerror $MAINFILE.tex
