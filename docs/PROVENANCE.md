# Source provenance

| Archived source | SHA-256 |
|---|---|
| `figure1/quan_part_r.m` | `DB2F6142259DF1C524B45FBA6B31BFED9B35D36B057E94D36A355ABB778E69B6` |
| `figure1/quan_part_r.asv` | `CA5274DFB2286CEDC1D2CFFE2DE80A327B2BAE44A7A7B0CF8B58212EEEADAD2B` |
| `figure2/GPU.m` | `C0B2FE0149D9E9AD2524EBD3CE607135DD7871E560F0DB637BA169E61C1740AC` |
| `figure3/new.m` | `F21F226BAB798561B8EBB97D6ED56FA487E0DE175545AEE7BC5B4102FD4E16DA` |
| `figure3/she.m` | `D21B643D1AD48579EA6B8DA766025FCABB9B9F56921217DBE50E7F8219047BB1` |
| `figure4/weiguan.m` | `E675B8541892A63A83FF87AF989C235A6634A1D3AEE4BABDD7BDC9FB2359CE65` |
| `figure6/results_K_L_phase/diff_k.m` | `A65D7BE4EF2165E7321034F2D3824239077BC8D22056FE7675C5018524CFB199` |
| `figure6/results_K_L_phase/average_omega.m` | `BF460C5340877C5150114155712CF6222C9C598B1095BD867E7C5CB7507328AF` |
| `Gaussian/FigS1_Gaussian_Bimodal_GPU_3x2.m` | `9E36554803BA29EB768177B9D41D5BEF18AAE8C3999F20C9C92238BCD12E821B` |
| `Gaussian/bim.m` | `971CD392EB7571127A121108B94806B81CE329FF69B8B69DBB303F2B34266E78` |

The public-facing implementation is a refactor, not a byte-for-byte copy. Repeated
right-hand-side, Runge-Kutta, continuation, frequency-generation, batching,
configuration, parameter-grid, runtime setup, and tail-averaging logic is
centralized under `matlab/+hybrid/`. Scientific presets live under
`matlab/+presets/`, while reusable workflows live under `matlab/+studies/`.
The right-hand side, all RK4 stages, and tail averaging are colocated in
`hybrid.integrate_batch` so the complete numerical model remains readable. Every
RK4 stage recomputes `R`, `Psi`, and the state-dependent forcing amplitude. This
follows the strict implementation retained in `weiguan.m`, `average_omega.m`, and
the non-Lorentzian simulations.

The public implementation is CPU-only. Archived filenames containing `GPU` are
listed solely for exact provenance and are not included as executable code.

The manuscript correspondence is documented in
[`MANUSCRIPT_TRACEABILITY.md`](MANUSCRIPT_TRACEABILITY.md), but figure numbers do
not determine directories, function names, or execution entry points.

No original source, MAT file, or final figure was modified or moved during this
reorganization.
