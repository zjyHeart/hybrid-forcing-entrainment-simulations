function config = compose_config(mode, common, quick, full)
% Compose a preset.

if nargin < 2 || isempty(common)
    common = struct();
end
if nargin < 3 || isempty(quick)
    quick = struct();
end
if nargin < 4 || isempty(full)
    full = struct();
end

config = hybrid.merge_structs(hybrid.base_config(mode), common);
if strcmp(config.mode, 'quick')
    config = hybrid.merge_structs(config, quick);
else
    config = hybrid.merge_structs(config, full);
end
end
