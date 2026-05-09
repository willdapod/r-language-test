# Analyzing the nycflights13 dataset
# This dataset contains all 336,776 flights that departed from New York City in 2013.

# This section checks if you have the packages installed, and installs them if you don't.
# This should fix the "there is no package called 'dplyr'" error!
packages <- c("dplyr", "ggplot2", "nycflights13")
for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing missing package:", pkg, "...\n")
    install.packages(pkg, repos = "http://cran.us.r-project.org")
  }
}

# Now load the libraries
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(nycflights13))

# Load the flights data
data("flights")

cat("Dataset Dimensions (Rows, Columns): ", dim(flights)[1], "x", dim(flights)[2], "\n\n")

# 1. Relational Data (Joins)
# The nycflights13 package actually contains multiple tables (flights, airlines, planes, airports).
# Let's join the 'flights' table with the 'airlines' table to get the full airline names instead of just the 2-letter codes.

cat("--- Joining Tables ---\n")
flights_with_names <- flights %>%
  inner_join(airlines, by = "carrier")

# Check the first few rows to see the new 'name' column
print(head(flights_with_names %>% select(year, month, day, carrier, name, flight), 5))

# 2. Aggregating 336k rows
# Let's find out which airlines had the worst average departure delays in 2013
cat("\n--- Aggregating 336,776 rows ---\n")

delay_summary <- flights_with_names %>%
  # Remove rows where departure delay is NA (meaning the flight was probably cancelled)
  filter(!is.na(dep_delay)) %>%
  # Group by the full airline name
  group_by(name) %>%
  # Calculate average delay and count total flights
  summarize(
    avg_dep_delay = mean(dep_delay),
    total_flights = n(),
    .groups = 'drop'
  ) %>%
  # Filter out airlines with very few flights to avoid weird outliers
  filter(total_flights > 1000) %>%
  # Sort by highest average delay
  arrange(desc(avg_dep_delay))

print("Airlines with the worst average departure delays (mins):")
print(head(delay_summary, 5))

# 3. Visualizing delays by month
# Let's calculate the average delay per month and plot it to see seasonal trends

monthly_delays <- flights %>%
  filter(!is.na(dep_delay)) %>%
  group_by(month) %>%
  summarize(avg_delay = mean(dep_delay))

delay_plot <- ggplot(monthly_delays, aes(x = factor(month), y = avg_delay, group = 1)) +
  geom_line(color = "steelblue", linewidth = 1.2) +
  geom_point(color = "red", size = 3) +
  labs(
    title = "Average Departure Delay by Month in NYC (2013)",
    x = "Month",
    y = "Average Delay (minutes)"
  ) +
  theme_minimal()

# Uncomment this to see the plot pop up
# print(delay_plot)
