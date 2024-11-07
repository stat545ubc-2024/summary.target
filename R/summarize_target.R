#' Summarize a Target Numeric Variable in a Data Frame by Specified Grouping Variables
#'
#' This function calculates summary statistics for a specific numeric column in a data frame. It computes the
#' mean, minimum, maximum, and standard deviation for each group defined by the specified grouping variables.
#'
#' @param data A data frame containing the data to be summarized.
#' Named 'data' to indicate this part of function expects a data frame as input.
#' @param group_vars A character vector specifying the names of the columns to group by.
#' Named 'group_vars' to indicate these variables determine the grouping structure
#' @param target_var A single character string specifying the name of the numeric column to summarize.
#' Named 'target_var' to indicate this is the target variable need to be summarized.
#' @importFrom dplyr .data
#' @importFrom dplyr across all_of
#' @importFrom stats sd
#' @importFrom dplyr %>%
#' @return A data frame containing the grouped summary statistics, including mean, minimum, maximum, and
#' standard deviation of the target variable for each combination of grouping variables.
#' @examples
#' # Use the steam_games data here to compute summary statistics for the
#' # discount_price variable group by types.
#' summarize_target(datateachr::steam_games, "types", "discount_price")
#'
#' # The function will stop and display an error message
#' # indicating that the specified grouping variable does not exist in the data frame.
#' try(summarize_target(datateachr::steam_games, "color", "discount_price"))
#' @export
summarize_target <- function(data, group_vars, target_var){
  if (!is.data.frame(data)){
    stop("Sorry, your ", deparse(substitute(data)), " should be a data frame.")
  }

  if (length(setdiff(group_vars, names(data))) != 0){
    stop("Sorry, all ", paste(group_vars, collapse = ", "), " should be columns inside of your 'data'.")
  }

  if (!is.character(group_vars)){
    stop("Sorry, your ", deparse(substitute(group_vars)), " should be a character vector.")
  }

  if (!(target_var %in% names(data))) {
    stop(paste("Sorry, your ", target_var, " does not exist in your 'data'."))
  }

  if (!is.character(target_var) || length(target_var) != 1){
    stop("Sorry, your ", deparse(substitute(target_var)), " should be a single character vector.")
  }

  if (!is.numeric(data[[target_var]])) {
    stop("Sorry, the elements inside of your ", target_var, " should be numeric.")
  }

  summarize_info <- data %>%
    dplyr::group_by(across(all_of(group_vars))) %>%
    dplyr::summarize(
      mean = mean(.data[[target_var]], na.rm = TRUE),
      min = min(.data[[target_var]], na.rm = TRUE),
      max = max(.data[[target_var]], na.rm = TRUE),
      sd = sd(.data[[target_var]], na.rm = TRUE),
      .groups = "drop"
    )

  return(summarize_info)
}
