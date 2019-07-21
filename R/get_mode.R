
#'A convenience function that returns the mode
#'@param x  The dataframe or vector for which the mode is required
#'@param na.rm Logical. Should missing values be removed? Defaults to True.Removes
#' 'NA' values if set to TRUE
#'@return a data.frame or vector showing the mode of the variable(s)
#'@details Useful when used together with get_stats in a pipe fashion.
#'These functions are for exploratory data analysis
#' The smallest number is returned if there is a tie in values
#' The function is currently slow for greater than 300,000 rows. It may take up to a minute.
#' Getting the mode for charcater/ factor columns is also currently unsupported. It 
#' may work with inaccuracies. 
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
get_mode <- function(x,na.rm=TRUE){
  UseMethod("get_mode")
}
#' @export
get_mode.numeric<-function(obj){
  # vector
  obj[which.max(sapply(seq_along(obj), 
                       function(x) sum(obj == obj[x])))]
  
}
#' @export
get_mode.character <- function(obj){
  # vector
  obj[which.max(sapply(seq_along(obj), 
                       function(x) sum(obj == obj[x])))]
  
}
#' @export
get_mode.default<-function (x,na.rm=TRUE){
  if(na.rm==TRUE){
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

  else{
    y <- x
    z <- vector("numeric")
    for (j in 1:length(y)) {
      z[j] <- sum(y == y[j])
    }
    q <- which(z == max(z))
    res <- unique(y[q])
    ifelse(length(res) >= 2, min(res), res)
  }

}

#' @export
get_mode.data.frame <- function(x,...){

mapply(function(y){
  if(is.factor(y)){
    get_mode.character(as.character(y))
  }
  else{
    get_mode.default(y)
  }
  }, x)
  

 
}


