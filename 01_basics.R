# --- 1. Basic Data Types and Structures ---

# Testing out variables and assignment
my_number <- 42
my_string <- "Hello, R!"
my_bool <- TRUE

# Vectors (one-dimensional arrays, all elements must be of the same type)
numeric_vector <- c(1, 2, 3, 4, 5)
character_vector <- c("apple", "banana", "cherry")

# Lists (these can contain elements of different types, including other lists)
my_list <- list(
  name = "John Doe",
  age = 30,
  scores = c(85, 92, 78)
)

# Data Frames (tabular data, similar to a spreadsheet)
my_dataframe <- data.frame(
  ID = 1:3,
  Name = c("Alice", "Bob", "Charlie"),
  Passed = c(TRUE, FALSE, TRUE)
)

print("Data Frame:")
print(my_dataframe)

# --- 2. Functions and Control Flow ---

#  testing first function
calculate_grade <- function(score) {
  if (score >= 90) {
    return("A")
  } else if (score >= 80) {
    return("B")
  } else {
    return("C")
  }
}

# for loop
print("Grades:")
for (score in my_list$scores) {
  grade <- calculate_grade(score)
  print(paste("Score:", score, "- Grade:", grade))
}
