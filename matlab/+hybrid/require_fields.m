function require_fields(value, required_fields, context)
% Check required fields.

if nargin < 3 || isempty(context)
    context = 'Configuration';
end
missing = required_fields(~isfield(value, required_fields));
if ~isempty(missing)
    error('hybrid:MissingField', '%s is missing: %s.', ...
        context, strjoin(missing, ', '));
end
end
