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

absolute(x, y, z) = sqrt(x * x + y * y + z * z);


plot "< sed s/[\\(\\)]//g postProcessing/forces/0/forces.dat" using 1:(absolute($2,$3,$4)) with lines title "Pressure Force", \
     "< sed s/[\\(\\)]//g postProcessing/forces/0/forces.dat" using 1:(absolute($5,$6,$7)) with lines title "Viscous Force", \
     "< sed s/[\\(\\)]//g postProcessing/forces/0/forces.dat" using 1:(absolute($8,$9,$10)) with lines title "Pressure Moment", \
     "< sed s/[\\(\\)]//g postProcessing/forces/0/forces.dat" using 1:(absolute($11,$12,$13)) with lines title "Viscous Moment";
