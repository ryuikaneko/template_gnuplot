#!/bin/bash

#==== subroutine ====
function make_fig
{

name=$1
dir=$2

gnuplot << EOF

set style line  1 lt 1 pt 4  lc rgbcolor "#ff0200"
set style line  2 lt 1 pt 6  lc rgbcolor "#d67519"
set style line  3 lt 1 pt 8  lc rgbcolor "#267e17"
set style line  4 lt 1 pt 10 lc rgbcolor "#0021d2"
set style line  5 lt 1 pt 12 lc rgbcolor "#8b2bd3"
set style line  6 lt 1 pt 14 lc rgbcolor "#2b3230"
set style line  7 lt 1 pt 2  lc rgbcolor "#000000"

set style line 11 lt 1 pt 4  lc rgbcolor "#000000"

do for [i=1:20] {
  set style line i linewidth 2
}

#set term pdf enhanced color
set term postscript eps enhanced color
set size 0.5
#set size ratio 1.0
set size ratio 0.75
#set key width -2
set key samplen 2
set key right bottom
set grid xtics ytics mxtics mytics

#set output "fig_${name}.pdf"
set output "fig_${name}.eps"

#----

set xlabel "x" offset 0,0.5
set ylabel "y" offset 0.5,0
set xrange [0:1]
set yrange [0:1]
#set xtics 1
#set ytics 1
#set mxtics 2
#set mytics 2

set label 1 "test" at graph 0.3,0.1

p \
1*x w lp ls 1 ti "1", \
2*x w lp ls 2 ti "2", \
3*x w lp ls 3 ti "3", \
4*x w lp ls 4 ti "4", \
5*x w lp ls 5 ti "5", \
6*x w lp ls 6 ti "6", \
7*x w lp ls 7 ti "7"

EOF

#----

#pdfcrop fig_${name}.pdf fig_${name}_1.pdf
#mv fig_${name}_1.pdf fig_${name}.pdf

./Rebb.sh fig_${name}.eps
ps2pdf -dEPSCrop fig_${name}.eps
rm fig_${name}.eps

}

#==== run ====
make_fig template ./
