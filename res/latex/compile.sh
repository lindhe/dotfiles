#!/bin/bash
MAINFILE=main
pdflatex -shell-escape $MAINFILE.tex &&\
bibtex $MAINFILE.aux;\
pdflatex -shell-escape $MAINFILE.tex &&\
pdflatex -shell-escape $MAINFILE.tex
