function output_path = save_result(output_directory, base_name, result)
% Save a MAT result.

if ~isfolder(output_directory)
    mkdir(output_directory);
end

timestamp = char(datetime('now', 'Format', 'yyyyMMdd_HHmmss'));
output_path = fullfile(output_directory, sprintf('%s_%s.mat', base_name, timestamp));
save(output_path, 'result', '-v7.3');
fprintf('Saved simulation result: %s\n', output_path);
end
