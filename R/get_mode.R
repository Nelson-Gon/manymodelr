
#'A convenience function that returns the mode
#'@param x  The dataframe or vector for which the mode is required
#'@return a data.frame or vector showing the mode of the variable(s)
#'@details Useful when used together with get_stats in a pipe fashion.
#'These functions are for exploratory data analysis
#' The smallest number is returned if there is a tie in values
#' The function is currently slow for greater than 300,000 rows. It may take up to a minute.
#' Getting the mode for charcater/ factor columns is also currently unsupported. It 
#' may work with inaccuracies. By default, NAs are discarded. 
#' @examples
#'test<-c(1,2,3,3,3,3,4,5)
#'test2<-c(455,7878,908981,NA,456,455,7878,7878,NA)
#'get_mode(test)
#'get_mode(test2)
#'\dontrun{
#'mtcars %>%
#'get_stats(get_mode)
#'get_stats(mtcars,get_mode)}
#'@export
get_mode <- function(x){
  UseMethod("get_mode")
}
#' @export
get_mode.numeric<-function(x){
  # vector
  x[which.max(sapply(seq_along(x), 
                       function(y) sum(x == x[y])))]
  
}
#' @export
get_mode.character <- function(x){
  # vector
  x[which.max(sapply(seq_along(x), 
                       function(y) sum(x == x[y])))]
  
}
#' @export
get_mode.default<-function (x){
    x<-x[!is.na(x)]
    y <- x
   z <- vector("numeric")
    for (j in 1:length(y)) {
      z[j] <- sum(y == y[j])
    }
    q <- which(z == max(z))
    res <- unique(y[q])
    ifelse(length(res) >= 2, min(res), res)
  



}

#' @export
get_mode.data.frame <- function(x,...){

  warning("factor columns have been removed.")

mapply(get_mode,Filter(Negate(is.factor), x))
  

 
}


