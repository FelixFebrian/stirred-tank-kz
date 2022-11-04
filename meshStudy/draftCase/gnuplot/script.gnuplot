set term png;

set output "gnuplot/residuals.png";
set logscale y;

plot "logs/Ux_0" using 1:2 with lines title "Ux", \
     "logs/Uy_0" using 1:2 with lines title "Uy", \
     "logs/Uz_0" using 1:2 with lines title "Uz", \
     "logs/p_0" using 1:2 with lines title "p", \
     "logs/k_0" using 1:2 with lines title "k", \
     "logs/epsilon_0" using 1:2 with lines title "epsilon";

set output "gnuplot/forces.png";
set logscale y;

plot "< sed s/[\\(\\)]//g postProcessing/forces/0/forces.dat" using 1:2 with lines title "Pressure Force x", \
     "< sed s/[\\(\\)]//g postProcessing/forces/0/forces.dat" using 1:3 with lines title "Pressure Force y", \
     "< sed s/[\\(\\)]//g postProcessing/forces/0/forces.dat" using 1:4 with lines title "Pressure Force z";
