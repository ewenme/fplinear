# function to get points total if two named players rotated
rotate_pair <- function(player_id_a, player_id_b) {
  
# player ids
player_ids <- c(player_id_a, player_id_b)

# player points
player_points <- player_data %>%
  # match player id to inputs
  dplyr::filter(player_id %in% player_ids) %>%
  # keep points
  dplyr::select(round, player_id, total_points)

# get max points for each round
max_round_points <- player_points %>%
  dplyr::group_by(round) %>%
  dplyr::summarise(best_points=max(total_points))

# get max points total
max_points_total <- sum(max_round_points$best_points)

return(max_points_total)

}

# function to get points total for all rotations with a named player
rotate_all <- function(data, id_player) {
  
  # player points
  player_points <- data %>%
    # match player id to inputs
    dplyr::filter(player_id == id_player) %>%
    # keep points
    dplyr::select(round, player_id, total_points)
  
  # other player points
  other_points <- data %>%
    # match player id to inputs
    dplyr::filter(player_id != id_player) %>%
    # keep points
    dplyr::select(round, player_id, total_points)
  
  # nest other players points
  other_points_nested <- other_points %>%
    split(.$player_id)
  
  # function to total rotation points
  collect_points <- function(x) { 
    
    # get max points for each round
    x <- x %>%
    dplyr::group_by(round) %>%
    dplyr::summarise(best_points=max(total_points))
    
    # get max points total
    max_points_total <- sum(x$best_points)
  }
  
  # iterate through other players to compare points to orig player
  points_compare <- other_points_nested %>%
    purrr::map(~dplyr::bind_rows(., player_points)) %>%
    purrr::map(~collect_points(.))
  
  # create df from named list
  points_compare <- stack(points_compare)
  
  # set colnames
  points_compare <- points_compare %>%
    dplyr::mutate(player_id=id_player) %>%
    dplyr::select(player_id, rotation_player_id=ind, points=values)
  
  # convert factor to numeric
  points_compare$rotation_player_id <- as.numeric(as.character(points_compare$rotation_player_id))
  
  return(points_compare)
  
}

