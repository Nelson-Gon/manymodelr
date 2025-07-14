
#'A convenience function that returns the mode
#'@param x  The dataframe or vector for which the mode is required.
#'@param na.rm Logical. Should `NA`s be dropped? Defaults to `TRUE`
#'@return a data.frame or vector showing the mode of the variable(s)

#'@details Useful when used together with get_stats in a pipe fashion.
#'These functions are for exploratory data analysis
#' The smallest number is returned if there is a tie in values
#' The function is currently slow for greater than 300,000 rows. It may take up to a minute.
#' may work with inaccuracies. By default, NAs are discarded.
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
get_mode.default<-function (x,na.rm=TRUE){

stop(paste0("No implementation available for objects of class ", class(x)))

}

#' @export

get_mode.numeric<-function(x,na.rm=TRUE){


if(na.rm){
  x <- na.omit(x)

}

x[which.max(rowSums(sapply(seq_along(x),function(y) x == x[y])))]

}


#' @export
get_mode.character <- get_mode.numeric



#' @export
get_mode.data.frame <- function(x,na.rm=TRUE){

all_factors <- sapply(x,is.factor)
if(any(all_factors)){
warning("factor columns converted to character")
 x %>%
   mutate(across(is.factor,
                 as.character)) -> x

}


x %>%
  summarise(across(everything(),
                                 ~get_mode.character(.,na.rm=na.rm)))




}
















