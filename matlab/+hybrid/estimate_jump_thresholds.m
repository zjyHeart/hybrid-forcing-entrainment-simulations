function thresholds = estimate_jump_thresholds(scan, min_jump, min_width, min_rho)
% Find scan jumps.

if isempty(scan.R_backward)
    error('hybrid:BackwardScanRequired', ...
        'Transition estimation requires a backward scan.');
end

case_count = size(scan.R_forward, 2);
forward_L = nan(1, case_count);
backward_L = nan(1, case_count);
forward_jump = nan(1, case_count);
backward_jump = nan(1, case_count);

for case_index = 1:case_count
    [forward_jump(case_index), forward_index] = max(diff(scan.R_forward(:, case_index)));
    [backward_jump(case_index), backward_index] = max(diff(scan.R_backward(:, case_index)));
    forward_L(case_index) = scan.Lgrid(forward_index + 1);
    backward_L(case_index) = scan.Lgrid(backward_index + 1);
end

width = forward_L - backward_L;
valid = forward_jump >= min_jump & backward_jump >= min_jump & ...
    width >= min_width & scan.rho_cases >= min_rho;

forward_L(~valid) = NaN;
backward_L(~valid) = NaN;
width(~valid) = NaN;

thresholds.rho = scan.rho_cases;
thresholds.L_forward = forward_L;
thresholds.L_backward = backward_L;
thresholds.width = width;
thresholds.forward_jump = forward_jump;
thresholds.backward_jump = backward_jump;
thresholds.valid = valid;
thresholds.min_jump = min_jump;
thresholds.min_width = min_width;
thresholds.min_rho = min_rho;
end
