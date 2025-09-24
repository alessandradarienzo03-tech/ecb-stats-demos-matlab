# ECB-oriented Data & Modelling Mini-Portfolio (MATLAB)

This repository contains three self-contained MATLAB scripts that demonstrate **data management, modelling and visualisation** skills in a way that aligns with an ECB statistics & data culture (clarity, documentation, and reproducibility).

## Contents
1. `markowitz_efficient_frontier.m` — mean-variance portfolio optimisation using `fmincon`.
2. `predictive_maintenance_sim.m` — simple predictive-maintenance simulation with thresholding and linear prediction.
3. `kalman_filter_demo.m` — state estimation with a discrete-time Kalman filter on a toy system.

Each script:
- is **reproducible** (`rng` seeded, synthetic data generated);
- includes **clear sections** (data setup → method → results);
- produces **readable figures** and concise console output where appropriate.

> Note: Scripts are designed as didactic examples; no proprietary data is used.

## How to run
Open MATLAB (R2021a or later recommended), navigate to the repo folder and run:
```matlab
markowitz_efficient_frontier
predictive_maintenance_sim
kalman_filter_demo
