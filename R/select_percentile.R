#' Get the row corresponding to a given percentile
#' @param df The dataframe for which a percentile is required
#' @param n The percentile required eg 10th percentile
#' @return A dataframe showing the row corresponding to a given percentile
#' @examples
#' select_percentile(iris,5)
#'\dontrun{
#'select_percentile(mtcars,1)
#'}
#'@export
select_percentile<-function(df,n){
  nth <- (n/nrow(df)) * 100
  return(df[nth, ])
}

