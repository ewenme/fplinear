fplinear
================

Exploring linear programming techniques in R for optimising fantasy football squads.

Inspired by:

-   Martin Eastwood's [penalty](https://github.com/martineastwood/penalty/tree/master/fantasy_football_optimiser) work
-   Torvaney's [fpl-optimiser](https://github.com/Torvaney/fpl-optimiser)

Usage
-----

-   `load_transform.R` script uses functions from my [fplr](https://github.com/ewenme/fplR) package to load, transform and export gameweek-level player data from the current season.
-   `lp_funcs.R` collates linear programming functions for operating on the gameweek-level player data.
-   `lp_do.R` (WIP) plays with linear programming functionality to create meaningful results
