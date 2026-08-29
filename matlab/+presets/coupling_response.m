function config = coupling_response(mode)
% Set coupling scans.

common.distribution_parameters.Delta = 0.3;
common.Omega = 4;
common.K = [-1 0 1];
common.rho = 0.8;

quick.Lgrid = [0 1];
full.Lgrid = 0:0.05:8;

config = hybrid.compose_config(mode, common, quick, full);
end
