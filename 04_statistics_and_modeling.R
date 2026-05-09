# Using the 'mtcars' dataset to predict miles per gallon (mpg) 
# based on car weight (wt) and horsepower (hp).

# --- Multiple Linear Regression ---

# Create the linear model (lm)
# Formula syntax: Dependent Variable ~ Independent Variable 1 + Independent Variable 2
model <- lm(mpg ~ wt + hp, data = mtcars)

# View a comprehensive statistical summary of the model
print("Model Summary:")
summary(model)

# Make a prediction for a new, hypothetical car
# Weight = 3000 lbs (wt = 3.0), Horsepower = 150
new_car <- data.frame(wt = 3.0, hp = 150)
predicted_mpg <- predict(model, newdata = new_car)

cat("\nPredicted MPG for a 3000 lb car with 150 HP:", round(predicted_mpg, 2), "\n")

# Statistical Tests
# Example: performing a basic T-Test
# Test if there's a significant difference in mpg between automatic (am=0) and manual (am=1) cars.
cat("\n--- T-Test: MPG by Transmission Type ---\n")
t_test_result <- t.test(mpg ~ am, data = mtcars)
print(t_test_result)
