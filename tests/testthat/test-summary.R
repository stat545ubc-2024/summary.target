
# Define a simple data frame

Sim_data <- data.frame(
  type = c("A", "A", "B", "B"),
  value = c(10, 20, 30, 40),
  color = c("Blue", "red", "red", NA),
  count = c(5, 2, "NA", 4)
)

expected_summary <- dplyr::tibble( type = c("A", "B"), mean = c(15, 35), min = c(10, 30), max = c(20, 40), sd = c(7.0710678, 7.0710678))

test_that("Testing multiplication function", {
  #check for correct output
  expect_equal(summarize_target(Sim_data, "type", "value"), expected_summary)

  #check for expected length
  expect_length(summarize_target(Sim_data, "color", "value"), 5)

  # Check for expected errors

  expect_error(summarize_target(Sim_data, "type", "color"), "Sorry, the elements inside of your color should be numeric.")

  # Check for expected errors
  expect_error(summarize_target(Sim_data, "type", "number"), "Sorry, your  number  does not exist in your 'data'.")
})

rm(Sim_data)
rm(expected_summary)
