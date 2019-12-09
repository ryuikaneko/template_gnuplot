#!/usr/bin/awk -f

# line:306
# /h {rlineto rlineto rlineto gsave fill grestore} bind def
# /h {rlineto rlineto rlineto gsave closepath fill grestore} bind def

/rlineto rlineto rlineto gsave/\
{if (!flg) $0 = $0 "\n\
\
%\n\
\/Circle {\n\
  stroke [] 0 setdash\n\
    gsave LCw setrgbcolor 2 copy\n\
      hpt 0 360 arc fill\n\
    grestore\n\
      hpt 0 360 arc stroke\n\
} def\n\
\/Box {\n\
  stroke [] 0 setdash\n\
    gsave LCw setrgbcolor 2 copy\n\
      exch hpt sub exch vpt add M 0 vpt2 neg V hpt2 0 V 0 vpt2 V hpt2 neg 0 V closepath fill\n\
    grestore\n\
      exch hpt sub exch vpt add M 0 vpt2 neg V hpt2 0 V 0 vpt2 V hpt2 neg 0 V closepath stroke\n\
} def\n\
\/TriU {\n\
  stroke [] 0 setdash\n\
    gsave LCw setrgbcolor 2 copy\n\
      vpt 1.12 mul add M hpt neg vpt -1.62 mul V hpt 2 mul 0 V hpt neg vpt 1.62 mul V closepath fill\n\
    grestore\n\
      vpt 1.12 mul add M hpt neg vpt -1.62 mul V hpt 2 mul 0 V hpt neg vpt 1.62 mul V closepath stroke\n\
} def\n\
\/TriD {\n\
  stroke [] 0 setdash\n\
    gsave LCw setrgbcolor 2 copy\n\
      vpt 1.12 mul sub M hpt neg vpt 1.62 mul V hpt 2 mul 0 V hpt neg vpt -1.62 mul V closepath fill\n\
    grestore\n\
      vpt 1.12 mul sub M hpt neg vpt 1.62 mul V hpt 2 mul 0 V hpt neg vpt -1.62 mul V closepath stroke\n\
} def\n\
\/Dia {\n\
  stroke [] 0 setdash\n\
    gsave LCw setrgbcolor 2 copy\n\
      vpt add M hpt neg vpt neg V hpt vpt neg V hpt vpt V hpt neg vpt V closepath fill\n\
    grestore\n\
      vpt add M hpt neg vpt neg V hpt vpt neg V hpt vpt V hpt neg vpt V closepath stroke\n\
} def\n\
\/Pent {\n\
  stroke [] 0 setdash\n\
    gsave LCw setrgbcolor 2 copy\n\
      gsave translate 0 hpt M 4 {72 rotate 0 hpt L} repeat closepath fill grestore\n\
    grestore\n\
      gsave translate 0 hpt M 4 {72 rotate 0 hpt L} repeat closepath stroke grestore\n\
} def\
\
"; flg = 1}{print}
