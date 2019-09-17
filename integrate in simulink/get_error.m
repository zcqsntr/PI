format long

close all


% get erorrs
PID_errors = [];
N1_ranges = [];
N2_ranges = [];


tsteps = [1,2,3,4,5,10,20,30,40,50,60];

tolerances = [0.0000001,0.0000001,0.0000001,0.0000001,0.0000001,0.0003 ,0.0000001,0.0000001,0.0000001,0.0000001,0.0000001];
for i = 1:length(tsteps)

    % get samples
    n_mins = tsteps(i);
    tol = tolerances(i);
   
    load("/home/neythen/Desktop/Projects/PI/output_data/output_" + n_mins + "min.mat")
    structure = out.pops;
    time = structure.time;
    populations = extractfield(structure.signals, 'values');
    N1 = squeeze(populations(1, 1, :));
    N2 = squeeze(populations(1, 2, :));
    
    %save("output_" + n_mins + "min", "out");
    sample_times = [(0:24*(60/n_mins))*n_mins/60];
    sample_indices = ismembertol(time,sample_times,tol);
    sharedvals = time(sample_indices);
    disp(size(sharedvals))
    disp(size(sample_times))
    target = [20000, 30000];
    Ns = [N1, N2];
    subs = (Ns(sample_indices, :)-target).^2;

    error = sum(sum(abs(subs)))/length(sample_times);
    
    PID_errors= [PID_errors, error];
    N1_ranges = [N1_ranges, range(N1)];
    N2_ranges = [N2_ranges, range(N2)];
    
end

%PID_errors = [7.741766526390517e+02,  1.522160354031577e+03,  3.645267579050994e+03, 3.886901590816143e+03, 5.817622094541824e+03, 8.705799832222199e+03,  9.574419406540001e+03, 1.231972416292504e+04];
RL_errors = [14862, 1190, 1984, 3404, 4947, 6547, 8220, 9777];
times = [1, 5, 10, 20, 30, 40, 50, 60];
plot(tsteps, PID_errors)
% hold on 
% plot(times, RL_errors)
% figure()
% plot(times, N1_ranges)
% hold on
% plot(times, N2_ranges)
