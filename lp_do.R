
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
  mutate(key = paste0(pmin(player_id, rotation_player_id), pmax(player_id, rotation_player_id), 
                      sep = "")) %>% 
  distinct(key, .keep_all = TRUE) %>%
  select(-key)

# join metadata
goalie_rotation <- goalie_rotation %>%
  # join original player
  left_join(unique_goalies, by="player_id") %>%
  # join rotation pplayer
  left_join(unique_goalies, by=c("rotation_player_id"="player_id")) %>%
  # rename cols
  rename(player_name=web_name.x, team_name=team_name.x, rotation_player_name=web_name.y,
         rotation_team_name=team_name.y)