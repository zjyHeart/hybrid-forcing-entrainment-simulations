function output_paths = run_all_studies(mode, output_directory)
% Run all studies.

if nargin < 1 || isempty(mode)
    mode = 'quick';
end
if nargin < 2
    output_directory = '';
end

entries = studies.catalog();
output_paths = struct();
for index = 1:numel(entries)
    key = matlab.lang.makeValidName(entries(index).id);
    [~, output_paths.(key)] = run_study( ...
        entries(index).id, mode, output_directory);
end
end
