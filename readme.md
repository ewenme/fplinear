fplinear
================

Exploring techniques in a linear programming space, in R, for optimising fantasy football squads.

Inspired by:

-   Martin Eastwood's [penalty](https://github.com/martineastwood/penalty/tree/master/fantasy_football_optimiser) work
-   Torvaney's [fpl-optimiser](https://github.com/Torvaney/fpl-optimiser)

Usage
-----

-   `load_transform.R` script uses functions from my [fplr](https://github.com/ewenme/fplR) package to load, transform and export gameweek-level player data from the current season.
-   `lp_funcs.R` collates linear programming-related functions for operating on the gameweek-level player data.
-   `lp_do.R` (WIP) plays with these functions to try and create meaningful results
