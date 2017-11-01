
# SESSION -----------------------------------------------------------------

# load pkgs
library(tidyverse)
library(glue)

# load funcs
source('lp_funcs.R')


# LOAD --------------------------------------------------------------------

# load player data
player_data <- read_csv("player_data.csv")


# CLEAN -------------------------------------------------------------------

# create goalies df
goalie_data <- filter(player_data, position=="Goalkeeper") %>%
  # add 'start price' col
  group_by(player_id) %>%
  mutate(start_price=first(price)) %>%
  ungroup()

# unique goalies list
unique_goalies <- distinct(goalie_data, player_id, web_name, team_name, start_price)


# DO ----------------------------------------------------------------------

# get points rotation for all goalies
goalie_rotation <- lapply(unique(goalie_data$player_id), rotate_all, data=goalie_data)

# bind these items
goalie_rotation <- bind_rows(goalie_rotation) %>%
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
  rename(player_name=web_name.x, team_name=team_name.x, start_price=start_price.x,
         rotation_player_name=web_name.y, rotation_team_name=team_name.y, 
         rotation_start_price=start_price.y) %>%
  # add total value col and name col
  mutate(total_price=start_price+rotation_start_price,
         combo=glue("{player_name} ({team_name}) & {rotation_player_name} ({rotation_team_name}) "))


# VIZ ---------------------------------------------------------------------

# top ten combos
goalie_rotation %>%
  ggplot(aes(x=points, y=total_price)) +
  geom_point()