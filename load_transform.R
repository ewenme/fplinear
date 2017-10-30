
# SESSION -----------------------------------------------------------------

library(fplR)
library(dplyr)

# LOAD --------------------------------------------------------------------

# get current season player list
player_list <- players() %>% 
  # cols to keep
  select(id, first_name, second_name, web_name, team_name, position)

# get gameweek points data for 17/18 players
player_data <- lapply(unique(player_list$id), playerDetailed) %>% bind_rows()


# TRANSFORM ---------------------------------------------------------------

# join data
player_data <- left_join(player_data, player_list, by=c("player_id"="id"))

# cols to remove
player_data <- player_data %>%
  select(-kickoff_time, -kickoff_time_formatted, -transfers_balance:-loaned_out, -influence:-dribbles)

# EXPORT ------------------------------------------------------------------

write.csv(player_data, "player_data.csv")
