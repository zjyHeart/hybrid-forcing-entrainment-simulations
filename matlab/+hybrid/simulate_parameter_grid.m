function result = simulate_parameter_grid(config)
% Run a parameter grid.

hybrid.require_fields(config, {'grid'}, 'Grid configuration');
hybrid.require_fields(config.grid, {'row', 'column', 'slice'}, 'Grid definition');
axes = {'row', 'column', 'slice'};
for index = 1:numel(axes)
    hybrid.require_fields(config.grid.(axes{index}), ...
        {'parameter', 'values'}, sprintf('Grid %s axis', axes{index}));
end

row = config.grid.row;
column = config.grid.column;
slice = config.grid.slice;
[column_grid, row_grid] = meshgrid(column.values, row.values);
coherence = zeros(numel(row.values), numel(column.values), numel(slice.values));

for slice_index = 1:numel(slice.values)
    cases = struct();
    cases.(row.parameter) = row_grid(:).';
    cases.(column.parameter) = column_grid(:).';
    cases.(slice.parameter) = slice.values(slice_index);
    simulation = hybrid.simulate_independent_cases(config, cases);
    coherence(:, :, slice_index) = reshape(simulation.R, ...
        numel(row.values), numel(column.values));
end

result.config = config;
result.axes = config.grid;
result.R = coherence;
result.execution_device = 'cpu';
end
