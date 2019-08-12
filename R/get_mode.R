
#'A convenience function that returns the mode
#'@param x  The dataframe or vector for which the mode is required.
#'@param na.rm Logical. Should NAs be removed from analysis? Deafults to TRUE.
#'@return a data.frame or vector showing the mode of the variable(s)
#'@details Useful when used together with get_stats in a pipe fashion.
#'These functions are for exploratory data analysis
#' The smallest number is returned if there is a tie in values
#' The function is currently slow for greater than 300,000 rows. It may take up to a minute.
#' Getting the mode for charcater/ factor columns is also currently unsupported. It 
#' may work with inaccuracies. By default, NAs are discarded. 
#' @importFrom stats na.omit
#' @examples
#'test<-c(1,2,3,3,3,3,4,5)
#'test2<-c(455,7878,908981,NA,456,455,7878,7878,NA)
#'get_mode(test)
#'get_mode(test2)
#'\dontrun{
#'mtcars %>%
#'get_data_Stats(get_mode)
#'get_data_Stats(mtcars,get_mode)}
#'@export
get_mode <- function(x,na.rm=TRUE){
  UseMethod("get_mode")
}
#' @export
get_mode.numeric<-function(x,na.rm=TRUE){
  # vector
  if(na.rm==TRUE){
    x <- na.omit(x)
  }
  x[which.max(sapply(seq_along(x), 
                       function(y) sum(x == x[y])))]
  
}
#' @export
get_mode.character <- function(x, na.rm=TRUE){
  # vector
  if(na.rm){
    x <- na.omit(x)
  }
  x[which.max(sapply(seq_along(x), 
                       function(y) sum(x == x[y])))]
  
}
#' @export
get_mode.default<-function (x,na.rm=TRUE){
stop(paste0("No implementation available for objects of class
             ", class(x)))  
  
}

#' @export
get_mode.data.frame <- function(x,na.rm=TRUE){
  
  
if(any(sapply(x, is.factor))){
 warning("factor columns have been removed.")
x <-Filter(Negate(is.factor), x) 
}

if(na.rm){
  x <- na.omit(x)
}
structure(sapply(x, function(column)
  column[which.max(sapply(column,
                          function(y) sum(column==y)))]),
         names = names(x))
  

 
}


