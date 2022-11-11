set term png;

set output "gnuplot/yPlus_time".time.".png";
set logscale x;
set xrange [0.1:]


binwidth = 10
bin(x,width) = width * floor(x/width)

plot "postProcessing/yPlus/".time."/stirrer.dat" using (bin($1,binwidth)):(1.0) smooth freq with boxes title "Stirrer", \
     "postProcessing/yPlus/".time."/shaft.dat" using (bin($1,binwidth)):(1.0) smooth freq with boxes title "Shaft", \
     "postProcessing/yPlus/".time."/tank.dat" using (bin($1,binwidth)):(1.0) smooth freq with boxes title "Tank", \
     "postProcessing/yPlus/".time."/baffles.dat" using (bin($1,binwidth)):(1.0) smooth freq with boxes title "Baffles";
