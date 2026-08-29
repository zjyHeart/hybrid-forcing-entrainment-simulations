function run_smoke_tests(output_directory)
% Test all studies.

test_root = fileparts(mfilename('fullpath'));
repository_root = fileparts(test_root);
matlab_root = fullfile(repository_root, 'matlab');
addpath(matlab_root);

if nargin < 1 || isempty(output_directory)
    output_directory = fullfile(repository_root, 'outputs', 'smoke');
end

close all force;
paths = cell(1, 9);

[response, paths{1}] = run_study( ...
    'hybrid-ratio-response', 'quick', output_directory);
assert(isequal(size(response.R_forward), [3 3]));
assert(isequal(size(response.R_backward), [3 3]));
assert(strcmp(response.execution_device, 'cpu'));

[detuning_map, paths{2}] = run_study( ...
    'stationary-detuning-map', 'quick', output_directory);
assert(isequal(size(detuning_map.R), [3 3 2]));
assert(strcmp(detuning_map.execution_device, 'cpu'));

[detuning_scan, paths{3}] = run_study( ...
    'detuning-continuation', 'quick', output_directory);
assert(numel(detuning_scan.members) == 3);
assert(isequal(size(detuning_scan.members{1}.R_forward), [3 3]));

[hybrid_map, paths{4}] = run_study( ...
    'stationary-hybrid-map', 'quick', output_directory);
assert(isequal(size(hybrid_map.R), [2 2 2]));

[boundaries, paths{5}] = run_study( ...
    'transition-boundaries', 'quick', output_directory);
assert(numel(boundaries.thresholds.rho) == 3);
assert(numel(boundaries.thresholds.L_forward) == 3);

[phase_response, paths{6}] = run_study( ...
    'phase-resolved-response', 'quick', output_directory);
assert(isequal(size(phase_response.R_forward), [2 1]));
assert(size(phase_response.phase_forward, 1) == 2);
assert(size(phase_response.phase_forward, 2) == 24);
assert(isequal(size(phase_response.frequency_forward), [2 1]));

[coupling_response, paths{7}] = run_study( ...
    'coupling-response', 'quick', output_directory);
assert(isequal(size(coupling_response.R_forward), [2 3]));

[locking, paths{8}] = run_study( ...
    'frequency-locking', 'quick', output_directory);
assert(isequal(size(locking.R), [3 2]));
assert(isequal(size(locking.frequency_error), [3 2]));

[robustness, paths{9}] = run_study( ...
    'distribution-robustness', 'quick', output_directory);
assert(isequal(size(robustness.gaussian.R_forward), [2 3]));
assert(isequal(size(robustness.bimodal.R_forward), [2 3]));

assert(all(cellfun(@isfile, paths)));
assert(isempty(findall(groot, 'Type', 'figure')), ...
    'Simulation-only entry points must not create figure windows.');

fprintf('All named simulation studies passed.\n');
fprintf('Validation MAT files: %s\n', output_directory);
end
