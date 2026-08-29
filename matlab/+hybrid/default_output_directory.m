function output_directory = default_output_directory(matlab_root, requested_directory)
% Resolve the output folder.

if nargin >= 2 && ~isempty(requested_directory)
    output_directory = char(requested_directory);
else
    repository_root = fileparts(matlab_root);
    output_directory = fullfile(repository_root, 'outputs', 'data');
end
end
