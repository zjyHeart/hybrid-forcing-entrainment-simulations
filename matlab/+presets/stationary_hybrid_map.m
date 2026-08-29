function config = stationary_hybrid_map(mode)
% Set the hybrid map.

common.distribution_parameters.Delta = 0.1;
common.K = 0;

quick.grid.row = axis_definition('rho', [0 1]);
quick.grid.column = axis_definition('L', [0 1]);
quick.grid.slice = axis_definition('Omega', [3 4]);

full.dt = 0.05;
full.tail_steps = 3200;
full.grid.row = axis_definition('rho', linspace(0, 1, 201));
full.grid.column = axis_definition('L', linspace(0, 10, 201));
full.grid.slice = axis_definition('Omega', [3 4 5]);

config = hybrid.compose_config(mode, common, quick, full);
end


function axis = axis_definition(parameter, values)
axis.parameter = parameter;
axis.values = values;
end
