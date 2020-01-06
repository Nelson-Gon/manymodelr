#' A pipe friendly way to get summary stats for exploratory data analysis
#' @param x The data for which stats are required
#' @param func The nature of function to apply
#' @param exclude What kind of data should be excluded? Defaults to NULL. Currently only supports
#' removing non-numeric data i.e exclude="non_numeric"
#' @param na.rm Logical. Should NAs be removed. Defaults to TRUE.
#' @param na_action If na.rm is set to TRUE, this uses na_replace to replace missing values.
#' See ?na_replace for details.
#' @return A data.frame object showing the requested stats
#' @details A convenient wrapper especially useful for get_mode
#' @examples
#' get_data_Stats(airquality,mean,"non_numeric",na.rm = TRUE,na_action = "mean")
#' @export 
get_data_Stats<-function(x, func,exclude=NULL,na.rm=TRUE,na_action=NULL){
  UseMethod("get_data_Stats")
}
#' @export
get_data_Stats.default <-function (x, func,exclude=NULL,na.rm=TRUE,na_action=NULL){
  stop("get_data_Stats is only implemented(currently) for
       data.frame objects. Please convert to a data.frame object.")
}
#' @export
get_data_Stats.data.frame<-function (x, func,exclude=NULL,na.rm=TRUE,na_action=NULL)
{
  if(na.rm & anyNA(x)){
    x<-na_replace(x,how=na_action)
  }
  if(is.null(exclude)|| missing(exclude)){
    x <- x
  }
  else if(exclude=="non_numeric"){
    warning("Non numeric columns have been discarded.")
    x<-Filter(is.numeric,x)


  }
 sapply(x,function(x) do.call(func,list(x)))
  
  
}

# Alias get_data_Stats with something simpler

#' @rdname get_data_Stats
#' @examples get_stats(airquality,mean,"non_numeric",na.rm = TRUE,na_action = "mean")
#' @export
get_stats <- get_data_Stats




