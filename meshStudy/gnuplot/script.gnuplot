set term png;

set output "gnuplot/residuals.png";
set logscale y;

plot "logs/Ux_0" using 1:2 with lines title "Ux", \
     "logs/Uy_0" using 1:2 with lines title "Uy", \
     "logs/Uz_0" using 1:2 with lines title "Uz", \
     "logs/p_0" using 1:2 with lines title "p", \
     "logs/k_0" using 1:2 with lines title "k", \
     "logs/epsilon_0" using 1:2 with lines title "epsilon", \
