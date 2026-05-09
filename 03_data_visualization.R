# using 'ggplot2' for declarative graphics.

suppressPackageStartupMessages(library(ggplot2))

# using the built-in 'iris' dataset for this plot

# --- Creating a Scatter Plot with Regression Lines ---

# Learning how ggplot works by adding 'layers' with the + operator.
my_plot <- ggplot(data = iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  
  # Add points for a scatter plot
  geom_point(size = 3, alpha = 0.7) +
  
  # Add a trend line (linear regression 'lm') for each species
  geom_smooth(method = "lm", se = FALSE) +
  
  # Add labels and title
  labs(
    title = "Iris Dataset: Petal Length vs Sepal Length",
    subtitle = "Separated by Species",
    x = "Sepal Length (cm)",
    y = "Petal Length (cm)",
    color = "Iris Species"
  ) +
  
  # Use a clean, minimal theme
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    legend.position = "bottom"
  )

# Display the plot
print(my_plot)

# To save the plot to a file:
# ggsave("iris_plot.png", plot = my_plot, width = 8, height = 6)
