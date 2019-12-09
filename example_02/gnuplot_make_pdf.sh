#!/bin/bash

#==== subroutine ====
function make_fig
{

name=$1
dir=$2

gnuplot << EOF

## http://www.gnuplotting.org/matplotlib-colormaps/
set palette defined ( 0 '#000004', \
                      1 '#1c1044',\
                      2 '#4f127b',\
                      3 '#812581',\
                      4 '#b5367a',\
                      5 '#e55964',\
                      6 '#fb8761',\
                      7 '#fec287',\
                      8 '#fbfdbf')
#
unset colorbox
#
set style line  1 lt 1 pt 1  lc palette frac 5/6.0
set style line  2 lt 1 pt 2  lc palette frac 4/6.0
set style line  3 lt 1 pt 8  lc palette frac 3/6.0
set style line  4 lt 1 pt 6  lc palette frac 2/6.0
set style line  5 lt 1 pt 4  lc palette frac 1/6.0

set style line 101 lt 1 pt 4  lc rgbcolor "#aaeeaa"
set style line 102 lt 1 pt 4  lc rgbcolor "#ffffff"

do for [i=1:100] {
  set style line i linewidth 2
}

set pointsize 0.6
set bar 0.6

#set term pdf enhanced color
set term postscript eps enhanced color
set size 0.45,0.42
set xlabel "{/:Italic T/V}" offset 0,0.5
set ylabel "{/:Italic C}" offset 1.5,0.0
set key samplen 1.5
set key left top at graph 0.45,0.51

set xrange [0.2:1.0]
set yrange [0.2:1.2]
set ytics 0.2
set xtics ("0.2"0.2,"0.3"0.3,"0.4"0.4,"0.5"0.5,"0.6"0.6,"0.7"0.7,"0.8"0.8,"0.9"0.9)
set label 10 "1" at graph 0.98,-0.095

#set label 1 "" at graph 0.03,0.9
#set label 1 "U/V=1.00" at graph 0.7,0.1
#set label 2 "(b)" at graph -0.24,0.99

#set output "fig_${name}.pdf"
set output "fig_${name}.eps"

set tics front
Th=0.53
Tl=0.36
set parametric

p \
Th,t w filledcurves y1 ls 101 ti "", \
Tl,t w filledcurves y1 ls 102 ti "", \
\
"< echo 100 100 1" w e ls 1 ps 1 ti "{/:Italic L}=12", \
"< echo 100 100 1" w e ls 2 ps 1 ti "24", \
"< echo 100 100 1" w e ls 3 ps 1 ti "48", \
"< echo 100 100 1" w e ls 4 ps 1 ti "96", \
"< echo 100 100 1" w e ls 5 ps 1 ti "192", \
\
"./${dir}/dat_L12" u 1:3:4 w l lc rgb "white" lw 12 ti "", \
"./${dir}/dat_L24" u 1:3:4 w l lc rgb "white" lw 12 ti "", \
"./${dir}/dat_L48" u 1:3:4 w l lc rgb "white" lw 12 ti "", \
"./${dir}/dat_L96" u 1:3:4 w l lc rgb "white" lw 12 ti "", \
"./${dir}/dat_L192" u 1:3:4 w l lc rgb "white" lw 12 ti "", \
\
"./${dir}/dat_L12" u 1:3:4 w l ls 1 ti "", \
"./${dir}/dat_L12" u 1:3:4 every 2 w p ls 1 ti "", \
"./${dir}/dat_L24" u 1:3:4 w l ls 2 ti "", \
"./${dir}/dat_L24" u 1:3:4 every 2 w p ls 2 ti "", \
"./${dir}/dat_L48" u 1:3:4 w l ls 3 ti "", \
"./${dir}/dat_L48" u 1:3:4 every 2 w p ls 3 ti "", \
"./${dir}/dat_L96" u 1:3:4 w l ls 4 ti "", \
"./${dir}/dat_L96" u 1:3:4 every 4 w p ls 4 ti "", \
"./${dir}/dat_L192" u 1:3:4 w l ls 5 ti "", \
"./${dir}/dat_L192" u 1:3:4 every 4 w p ls 5 ti ""

EOF

#----

./Replace_mark.awk fig_${name}.eps > fig_${name}.eps_
mv fig_${name}.eps_ fig_${name}.eps

./Rebb.sh fig_${name}.eps

#pdfcrop fig_${name}.pdf fig_${name}.pdf_1
#mv fig_${name}.pdf_1 fig_${name}.pdf

ps2pdf -dEPSCrop fig_${name}.eps fig_${name}.pdf
rm fig_${name}.eps

}

#==== run ====
make_fig spec_heat ./dat

rm -f *~
