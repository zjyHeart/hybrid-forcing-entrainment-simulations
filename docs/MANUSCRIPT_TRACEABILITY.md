# Manuscript traceability

The source tree is organized by scientific and numerical responsibilities. This
table is retained only to trace study outputs back to the manuscript.

| Manuscript location | Registered study | Audited archived source |
|---|---|---|
| Fig. 1 | `hybrid-ratio-response` | `figure1/quan_part_r.m` |
| Fig. 2 | `stationary-detuning-map` | `figure2/GPU.m` |
| Fig. 3(a-c) | `detuning-continuation` | `figure3/new.m` |
| Fig. 3(d-f) | `stationary-hybrid-map` | `figure3/she.m` |
| Fig. 4 | `transition-boundaries` | Reconstructed from manuscript parameters; no exact final generator retained |
| Fig. 5 | `phase-resolved-response` | `figure4/weiguan.m` |
| Fig. 6(a-c) | `coupling-response` | `figure6/results_K_L_phase/diff_k.m` |
| Fig. 6(d) | `frequency-locking` | `figure6/results_K_L_phase/average_omega.m` |
| Fig. 7 | `distribution-robustness` | `Gaussian/FigS1_Gaussian_Bimodal_GPU_3x2.m` and `Gaussian/bim.m` |

The current `quan_part_r.m` was changed after the final Fig. 1 run. The final
`Omega=4` and `L=0:0.05:10` settings are corroborated by the retained autosave and
final archived output. The public preset uses the final manuscript settings.
