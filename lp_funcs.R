library(dplyr)
library(tidyr)

rotate_pts <- function(player_id_a, player_id_b) {
  
# player ids
player_ids <- c(player_id_a, player_id_b)

# player points
player_points <- player_data %>%
  # match player id to inputs
  filter(player_id %in% player_ids) %>%
  # keep points
  select(round, player_id, total_points)

# get max points for each round
max_round_points <- player_points %>%
  group_by(round) %>%
  summarise(best_points=max(total_points))

# get max points total
max_points_total <- sum(max_round_points$best_points)

return(max_points_total)

}
