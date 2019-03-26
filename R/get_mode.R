
#'A convenience function that returns the mode
#'@param x  The dataframe or vector for which the mode is required
#'@return a data.frame or vector showing the mode of the variable(s)
#'@details Useful when used together with get_stats in a pipe fashion.
#'These functions are for exploratory data analysis
#' The smallest number is returned if there is a tie in values
#' The function is currently slow for greater than 300,000 rows. It may take up to a minute
#' @examples
#'test<-c(1,2,3,3,3,3,4,5)
#'get_mode(test)
#'\dontrun{
#'mtcars %>%
#'get_data_Stats(get_mode)
#'get_data_Stats(mtcars,get_mode)}
#' @export
get_mode<-function(x){
 y<-x
  for(i in 1:length(x)){
    y[i]<-x[i]

  }
 z<-vector("numeric")
 for(j in 1:length(y)){
  z[j]<-sum(y==y[j])

 }
q<-which(z==max(z))
res<-unique(y[q])
ifelse(length(res)>=2,min(res),res)
}


