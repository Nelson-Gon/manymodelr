#' A convenient selector gadget
#' @param df The data set from which to select a column
#' @param ... columns to select, no quotes
#' @return Returns a dataframe with selected columns
#' @details A friendly way to select a column or several columns. Mainly for non-pipe usage
#' It is recommended to use known select functions to do pipe manipulations. Otherwise convert to tibble
#' @export
#'
#' @examples
#' select_col(iris,Petal.Length,Sepal.Length,Species,Petal.Width)
#' # A pipe friendly example
#' \dontrun{
#' library(dplyr)
#' as_tibble(iris) %>%
#' select_col(Species)
#' }
select_col<-function(df,...){
  UseMethod("select_col")
}
#' @export
select_col<-function(df,...){
select_columns<-unlist(sapply(substitute(...()), deparse))
df[select_columns]
}




