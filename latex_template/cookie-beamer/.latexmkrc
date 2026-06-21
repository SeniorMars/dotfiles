$pdf_mode = 4;
$lualatex = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$biber = 'biber %O %S';
$bibtex_use = 2;
@default_files = ('demo.tex');
$clean_ext = 'nav out snm vrb listing run.xml bbl bcf blg';
$show_time = 1;
