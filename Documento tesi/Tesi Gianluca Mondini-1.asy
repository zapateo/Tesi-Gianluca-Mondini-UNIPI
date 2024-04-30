if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
settings.inlinetex=true;
deletepreamble();
defaultfilename="Tesi Gianluca Mondini-1";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

import graph; size(0cm);
real labelscalefactor = 0.5; /* changes label-to-point distance */
pen dps = linewidth(0.7) + fontsize(10); defaultpen(dps); /* default pen style */
pen dotstyle = black; /* point style */
real xmin = -8, xmax = 22.64, ymin = -10.92, ymax = 8.52; /* image dimensions */
pen zzttqq = rgb(0.6,0.2,0); pen cqcqcq = rgb(0.7529411764705882,0.7529411764705882,0.7529411764705882);

draw((2.14,1.64)--(3.28,0.66)--(4.86,3.08)--(3.3,3.7)--cycle, linewidth(2) + zzttqq);
/* draw grid of horizontal/vertical lines */
pen gridstyle = linewidth(0.7) + cqcqcq; real gridx = 1, gridy = 1; /* grid intervals */
for(real i = ceil(xmin/gridx)*gridx; i <= floor(xmax/gridx)*gridx; i += gridx)
draw((i,ymin)--(i,ymax), gridstyle);
for(real i = ceil(ymin/gridy)*gridy; i <= floor(ymax/gridy)*gridy; i += gridy)
draw((xmin,i)--(xmax,i), gridstyle);
/* end grid */

Label laxis; laxis.p = fontsize(10);
xaxis(xmin, xmax, Ticks(laxis, Step = 1, Size = 2, NoZero),EndArrow(6), above = true);
yaxis(ymin, ymax, Ticks(laxis, Step = 1, Size = 2, NoZero),EndArrow(6), above = true); /* draws axes; NoZero hides '0' label */
/* draw figures */
draw((2.14,1.64)--(3.28,0.66), linewidth(2) + zzttqq);
draw((3.28,0.66)--(4.86,3.08), linewidth(2) + zzttqq);
draw((4.86,3.08)--(3.3,3.7), linewidth(2) + zzttqq);
draw((3.3,3.7)--(2.14,1.64), linewidth(2) + zzttqq);
/* dots and labels */
dot((2.14,1.64),dotstyle);
label("$A$", (2.22,1.84), NE * labelscalefactor);
dot((3.28,0.66),dotstyle);
label("$B$", (3.36,0.86), NE * labelscalefactor);
dot((4.86,3.08),dotstyle);
label("$C$", (4.94,3.28), NE * labelscalefactor);
dot((3.3,3.7),dotstyle);
label("$D$", (3.38,3.9), NE * labelscalefactor);
label("$a$", (2.5,0.92), NE * labelscalefactor,zzttqq);
label("$b$", (4.32,1.7), NE * labelscalefactor,zzttqq);
label("$c$", (4.18,3.7), NE * labelscalefactor,zzttqq);
label("$d$", (2.44,2.84), NE * labelscalefactor,zzttqq);
clip((xmin,ymin)--(xmin,ymax)--(xmax,ymax)--(xmax,ymin)--cycle);
