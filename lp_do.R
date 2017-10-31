
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

# get points rotation for all goalies
test <- lapply(seq_along(goalie_data$player_id), rotate_all, data=goalie_data)

# bind these items
goalie_rotation <- bind_rows(test) %>%
  # get unique goalie combos
  
