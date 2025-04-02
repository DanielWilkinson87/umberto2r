library(purrr)
library(tidyverse)
library(ggthemes)

# Get unique scenarios
scenarios <- unique(df$Scenario)

# Run analysis and plotting for each scenario
results <- map(scenarios, function(scenario) {
  # Calculate weighted categories
  weighted_data <- calculate_weighted_categories(df, scenario)
  
  # Create plot
  plot <- create_hotspot_plot(weighted_data, add_title = TRUE, title_scenario = scenario)
  
  # Save plot (sanitize file name)
  safe_name <- gsub("[^a-zA-Z0-9]", "_", scenario)
  ggsave(paste0("Figures/MostRelevantICS_", safe_name, ".png"), plot = plot, bg = "white")
  
  # Return both data and plot if needed
  list(
    scenario = scenario,
    data = weighted_data,
    plot = plot
  )
})
