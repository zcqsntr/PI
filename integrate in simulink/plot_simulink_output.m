
structure = out.pops;
time = structure.time;
populations = extractfield(structure.signals, 'values');
N1 = squeeze(populations(1, 1, :));
N2 = squeeze(populations(1, 2, :));

figure
plot([0:3:1000], N1)
hold on 
plot([0:3:1000], N2)

xlabel("Time (hours)")
ylabel("Population (10^6 cells L^{-1})")
plot([0 1000], [30000, 30000], 'Color', 'g')
plot([0 1000], [20000 20000], 'Color', 'g')
