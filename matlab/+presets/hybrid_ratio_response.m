function config = hybrid_ratio_response(mode)
% Set hybrid-ratio scans.

common.distribution_parameters.Delta = 0.1;
common.Omega = 4;
common.K = 0;
common.rho = [0 0.2 0.4 0.6 0.8 1.0];

quick.rho = [0 0.8 1.0];
quick.Lgrid = [0 0.5 1.0];

full.Lgrid = 0:0.05:10;
config = hybrid.compose_config(mode, common, quick, full);
end
