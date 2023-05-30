#!/bin/bash

# This script is used to build the LaTeX document and create a badge
cd doc

# Build the pdf
pdflatex -interaction=nonstopmode -file-line-error -shell-escape $1.tex  # build the pdf just as you would on your computer
biber $1
makeglossaries-lite $1
pdflatex -interaction=nonstopmode -file-line-error -shell-escape $1.tex
pdflatex -interaction=nonstopmode -file-line-error -shell-escape $1.tex

printf "$1.pdf builded successfully\n"


# Create the bage
version=$(cat 00-settings/metadata.tex | awk -F '[{}]+' '/'$1'Version/{print $(NF-1)}')
curl https://img.shields.io/badge/$1-$version-blue > $1'.svg'

printf "Bage of version $version created successfully"
