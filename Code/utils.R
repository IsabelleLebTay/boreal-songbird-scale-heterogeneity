filter_richness_data <- function(target_distance, richness_data) {
  #' Filter richness data to the closest available distance.
  #' @param target_distance Numeric value representing the target distance.
  #' @param richness_data Data frame with a 'distance' column.
  #' @return A data frame filtered to the closest available distance.
  available_distances <- unique(richness_data$distance)
  closest_distance <- available_distances[which.min(abs(available_distances - target_distance))]

  filtered_data <- richness_data %>%
    dplyr::filter(distance == closest_distance)

  return(filtered_data)
}


land_metrics_single_obs_multi_landscape_extents <- function(landscape_metrics_all_sites_all_buffers, response_distance, richness_single_dist_tibble, survey_year_df, climatic_df) {
  #' Join landscape metrics with richness, survey year, and climate data for a single response extent.
  #'
  #' @param landscape_metrics_all_sites_all_buffers A data frame containing landscape metrics at all buffer distances.
  #' @param response_distance A numeric value representing the minimum distance for the response variable.
  #' @param richness_single_dist_tibble A tibble containing species richness data for a single distance.
  #' @param survey_year_df A data frame with location name and year of survey.
  #' @param climatic_df A data frame with climate variables per location.
  #' @return A tibble with landscape metrics for all landscape extents >= response_distance, joined with richness, survey year, and climate data.
  analysis_df <- landscape_metrics_all_sites_all_buffers %>%
    dplyr::filter(distance_int >= response_distance) %>%
    inner_join(richness_single_dist_tibble, by = "location") %>%
    left_join(
      survey_year_df %>%
        dplyr::select(location, survey_year),
      by = "location"
    ) %>%
    left_join(
      climatic_df,
      by = "location"
    )

  return(analysis_df)
}
