# Simulation study parameters

Common defaults are `A0=1`, `gamma=1`, deterministic frequency quantiles, random
initial phases with a fixed seed, fourth-order Runge-Kutta integration, and tail-time
averaging after a transient.

| Study preset | Distribution | Main parameters | Scan |
|---|---|---|---|
| `hybrid-ratio-response` | Lorentzian, `Delta=0.1` | `N=2000`, `Omega=4`, `K=0`, `rho=0:0.2:1`, `TT=800`, `dt=0.01`, `tail_steps=1600` | `L=0:0.05:10`, forward and backward |
| `stationary-detuning-map` | Lorentzian, `Delta=0.1` | `N=2000`, `K=0`, `rho=linspace(0,1,201)`, `TT=800`, `dt=0.05`, `tail_steps=3200` | `Omega=linspace(-5,5,201)`, `L=[0.5,1.5,2.5,3.5]` |
| `detuning-continuation` | Lorentzian, `Delta=0.1` | `N=2000`, `K=0`, `rho=[0,0.8,1]`, `TT=500`, `dt=0.05`, `tail_steps=2000` | `Omega=linspace(-5,5,401)`, `L=linspace(0,10,401)`, forward and backward |
| `stationary-hybrid-map` | Lorentzian, `Delta=0.1` | `N=2000`, `K=0`, `Omega=[3,4,5]`, `TT=800`, `dt=0.05`, `tail_steps=3200` | `L=linspace(0,10,201)`, `rho=linspace(0,1,201)` |
| `transition-boundaries` | Lorentzian, `Delta=0.1` | `N=2000`, `Omega=4`, `K=0`, `rho=0:0.01:1`, `TT=800`, `dt=0.01`, `tail_steps=1600` | `L=0:0.05:8`, forward and backward; thresholds from the largest numerical jump |
| `phase-resolved-response` | Lorentzian, `Delta=0.1` | `N=2000`, `Omega=4`, `K=0`, `rho=0.7`, `TT=800`, `dt=0.01`, `tail_steps=1600` | `L=0:0.1:6`, forward and backward; store phase and group frequency |
| `coupling-response` | Lorentzian, `Delta=0.3` | `N=2000`, `Omega=4`, `K=[-1,0,1]`, `rho=0.8`, `TT=800`, `dt=0.01`, `tail_steps=1600` | `L=0:0.05:8`, forward and backward |
| `frequency-locking` | Lorentzian, `Delta=0.3` | `N=2000`, `Omega=4`, `K=linspace(-5,5,401)`, `rho=0.8`, `TT=800`, `dt=0.05`, `tail_steps=3200` | `L=linspace(0,10,401)`, forward continuation; manuscript displays a truncated region |
| `distribution-robustness` | Gaussian and bimodal | `N=2000`, `Omega=4`, `K=0`, `rho=[0,0.8,1]`, `TT=800`, `dt=0.01`, `tail_steps=1600`; Gaussian `sigma=0.30`; bimodal `mu=0.25`, `sigma=0.20` | `L=0:0.1:10`, forward and backward |

The detuning-continuation and stationary-hybrid grids follow the retained simulation
sources. The paper caption specifies the physical parameters but does not list the
numerical resolution.
