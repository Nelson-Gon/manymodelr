
#'A convenience function that returns the mode
#'@param x  The dataframe or vector for which the mode is required
#'@param na.rm Logical. Should missing values be removed? Defaults to True.Removes
#' 'NA' values if set to TRUE
#'@return a data.frame or vector showing the mode of the variable(s)
#'@details Useful when used together with get_stats in a pipe fashion.
#'These functions are for exploratory data analysis
#' The smallest number is returned if there is a tie in values
#' The function is currently slow for greater than 300,000 rows. It may take up to a minute
#' @examples
#'test<-c(1,2,3,3,3,3,4,5)
#'test2<-c(455,7878,908981,NA,456,455,7878,7878,NA)
#'get_mode(test)
#'get_mode(test2)
#'\dontrun{
#'mtcars %>%
#'get_stats(get_mode)
#'get_stats(mtcars,get_mode)}
#' @export
get_mode<-function (x,na.rm=TRUE){
  if(na.rm==TRUE){
    x<-x[!is.na(x)]
    y <- x
    for (i in 1:length(x)) {
      y[i] <- x[i]
    }
    z <- vector("numeric")
    for (j in 1:length(y)) {
      z[j] <- sum(y == y[j])
    }
    q <- which(z == max(z))
    res <- unique(y[q])
    ifelse(length(res) >= 2, min(res), res)
  }

  else{
    y <- x
    for (i in 1:length(x)) {
      y[i] <- x[i]
    }
    z <- vector("numeric")
    for (j in 1:length(y)) {
      z[j] <- sum(y == y[j])
    }
    q <- which(z == max(z))
    res <- unique(y[q])
    ifelse(length(res) >= 2, min(res), res)
  }

}


