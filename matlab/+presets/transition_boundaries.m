function config = transition_boundaries(mode)
% Set boundary scans.

common.distribution_parameters.Delta = 0.1;
common.Omega = 4;
common.K = 0;

quick.rho = [0.5 0.8 1];
quick.Lgrid = [0 1 2];
quick.min_jump = 0;
quick.min_width = -inf;
quick.min_rho = 0;

full.rho = 0:0.01:1;
full.Lgrid = 0:0.05:8;
full.min_jump = 0.1;
full.min_width = 0.05;
full.min_rho = 0.5;

config = hybrid.compose_config(mode, common, quick, full);
end
