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
get_data_Stats<-function (x, func,exclude=NULL,na.rm=TRUE,na_action=NULL)
{
  if(na.rm==TRUE & anyNA(x)==TRUE){
    x<-na_replace(x,how=na_action)
  }
  if(is.null(exclude)|| missing(exclude)){
    x <- x
  }
  else if(exclude=="non_numeric"){
    x<-Filter(is.numeric,x)


  }
  sapply(x,function(x) do.call(func,list(x)))

}



