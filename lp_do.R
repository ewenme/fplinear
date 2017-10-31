
# SESSION -----------------------------------------------------------------

# load pkgs
library(tidyverse)

# load funcs
source('lp_funcs.R')


# LOAD --------------------------------------------------------------------

# load player data
player_data <- read_csv("player_data.csv")


# CLEAN -------------------------------------------------------------------

# create goalies df
goalie_data <- filter(player_data, position=="Goalkeeper")

# unique goalies list
unique_goalies <- distinct(goalie_data, player_id, web_name, team_name)


# DO ----------------------------------------------------------------------

# loop rotation function test
foo <- lapply(goalie_data, function(x) rotate_pts())
