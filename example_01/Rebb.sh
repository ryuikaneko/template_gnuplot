#!/bin/bash

input=$1
#output=$2
output=${input}_output

gs -q -sDEVICE=bbox -dNOPAUSE -dSAFER -dBATCH \
-dDEVICEWIDTH=250000 -dDEVICEHEIGHT=250000 \
${input} > ${input}_temp 2>&1
#eps2eps ${input} ${input}_temp ;\
sed -n '1,/^%%BoundingBox:/p' ${input} |\
sed -e '$d' >\
${output} ;\
grep '^%%BoundingBox:' ${input}_temp >>\
${output} ;\
grep '^%%HiResBoundingBox:' ${input}_temp >>\
${output} ;\
sed -n '/^%%BoundingBox:/,$p' ${input} |\
sed -e '1d' >>\
${output} ;\

mv ${output} ${input}
rm ${input}_temp
