# Testing R with a larger dataset: 'diamonds' (53,940 rows)
# This dataset is included with the ggplot2 package.

suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(ggplot2))

# 1. Loading and inspecting the data
# The diamonds dataset contains prices and attributes of almost 54,000 diamonds.
data("diamonds")

cat("Dataset Dimensions (Rows, Columns): ", dim(diamonds)[1], "x", dim(diamonds)[2], "\n\n")

# View a quick summary of all columns
print("Dataset Summary:")
summary(diamonds)

# 2. Complex Data Manipulation
# Let's group and summarize ~54,000 rows to find trends.
cat("\n--- Aggregating Data ---\n")

summary_stats <- diamonds %>%
  # Group by two categorical variables: cut and clarity
  group_by(cut, clarity) %>%
  # Calculate metrics for each group
  summarize(
    count = n(),
    avg_price = mean(price),
    avg_carat = mean(carat),
    .groups = 'drop'
  ) %>%
  # Sort by highest average price
  arrange(desc(avg_price))

print("Top 10 most expensive cut/clarity combinations on average:")
print(head(summary_stats, 10))

# 3. Visualization on a large dataset
# With 54,000 points, a standard scatter plot would be a giant blob (overplotting).
# Boxplots are a great way to show distributions of large datasets.

price_plot <- ggplot(diamonds, aes(x = cut, y = price, fill = cut)) +
  geom_boxplot(alpha = 0.7) +
  labs(
    title = "Diamond Price Distribution by Cut",
    subtitle = "Analysis of 53,940 diamonds",
    x = "Quality of the Cut",
    y = "Price (USD)"
  ) +
  theme_minimal() +
  theme(legend.position = "none") # Hide the legend since the x-axis already has the labels

# Uncomment to display or save the plot
# print(price_plot)
# ggsave("diamond_prices.png", plot = price_plot, width = 8, height = 6)

# 4. Statistical Modeling
# Predicting diamond price using multiple variables
cat("\n--- Modeling Price ---\n")

# We predict price based on carat weight, cut, color, and clarity.
# R automatically handles categorical variables by creating dummy variables behind the scenes.
price_model <- lm(price ~ carat + cut + color + clarity, data = diamonds)

# Print the R-squared value to see how much variance our model explains
model_summary <- summary(price_model)
cat("Model R-squared: ", round(model_summary$r.squared, 4), "\n")
cat("(This means the model explains about", round(model_summary$r.squared * 100, 1), "% of the variance in diamond prices!)\n")
