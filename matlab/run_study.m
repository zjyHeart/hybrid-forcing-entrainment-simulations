function [result, output_path] = run_study(study_id, mode, output_directory)
% Run one study.

if nargin < 2 || isempty(mode)
    mode = 'quick';
end
matlab_root = fileparts(mfilename('fullpath'));
addpath(matlab_root);
if nargin < 3
    output_directory = '';
end
output_directory = hybrid.default_output_directory(matlab_root, output_directory);

entry = studies.get(study_id);
config = entry.configure(mode);
result = entry.execute(config);
result.metadata.study_id = entry.id;
result.metadata.description = entry.description;
result.metadata.manuscript_context = entry.manuscript_context;
result.metadata.provenance_status = entry.provenance_status;

output_path = hybrid.save_result( ...
    output_directory, entry.output_name, result);
end
