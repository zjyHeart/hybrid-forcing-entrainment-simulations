# Architecture

The repository follows one-way dependency flow:

```text
run_study / run_all_studies
          |
          v
     studies.* workflows
       /             \
      v               v
presets.*        hybrid.* numerical modules
                       |
                       v
                timestamped MAT output
```

## Reuse boundaries

- `hybrid.rhs`, `hybrid.rk4_step`, and `hybrid.integrate_batch` implement the
  dynamics and time integration once.
- `hybrid.prepare_simulation` and `hybrid.prepare_parameters` centralize CPU
  arrays, deterministic sampling, initial phases, precision, and case expansion.
- `hybrid.simulate_hysteresis_scan` handles forward/backward continuation for any
  vector of model cases.
- `hybrid.simulate_independent_cases` handles batched independent cases.
- `hybrid.simulate_parameter_grid` turns declarative row, column, and slice axes
  into independent cases without study-specific grid boilerplate.
- `hybrid.base_config`, `hybrid.compose_config`, and `hybrid.merge_structs` remove
  repeated defaults and quick/full conditionals from parameter presets.

## Extension points

To add a study:

1. Add a descriptively named function under `matlab/+presets/`.
2. Reuse an existing `studies.run_*` workflow, or add one only when new
   post-processing is required.
3. Register the preset and workflow in `studies.catalog`.

No new top-level runner is needed. `run_study` automatically handles mode
selection, metadata, output naming, and saving.
