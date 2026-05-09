# using 'dplyr' from the tidyverse.

# Loading the library
suppressPackageStartupMessages(library(dplyr))

# using the built-in 'mtcars' dataset for practice
print("First 5 rows of mtcars:")
print(head(mtcars, 5))

# --- Data Filtering, Mutating, and Summarizing ---

# using the %>% (pipe) operator to chain commands together.

analysis_result <- mtcars %>%
  # 1. Filter: Keep only cars with 4 or 6 cylinders
  filter(cyl %in% c(4, 6)) %>%
  
  # 2. Mutate: Create a new column (e.g., horsepower per ton)
  # (wt is weight in 1000 lbs, so wt * 1000 / 2000 roughly gives tons)
  mutate(hp_per_ton = hp / (wt * 0.5)) %>%
  
  # 3. Group By: Group the data by number of cylinders
  group_by(cyl) %>%
  
  # 4. Summarize: Calculate average miles per gallon (mpg) and max horsepower per ton
  summarize(
    avg_mpg = mean(mpg),
    max_hp_per_ton = max(hp_per_ton),
    car_count = n()
  ) %>%
  
  # 5. Arrange: Sort by average mpg descending
  arrange(desc(avg_mpg))

print("Analysis Result:")
print(analysis_result)
