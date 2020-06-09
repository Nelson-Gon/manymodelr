#' A pipe friendly way to get summary stats for exploratory data analysis
#' @param x The data for which stats are required
#' @param func The nature of function to apply
#' @param exclude What kind of data should be excluded? Use for example c("character","factor") to drop character and factor columns
#' @param na.rm Logical. Should NAs be removed. Defaults to FALSE.
#' @param na_action If na.rm is set to TRUE, this uses na_replace to replace missing values.
#' @param ... Other arguments to na_replace
#' See ?na_replace for details.
#' @return A data.frame object showing the requested stats
#' @details A convenient wrapper especially useful for get_mode
#' @examples
#' head(get_data_Stats(airquality,mean,na.rm = TRUE,na_action = "get_mode"))
#' @export 
get_data_Stats<-function (x=NULL, func=NULL,exclude=NULL,na.rm=FALSE,na_action=NULL,...) {
  UseMethod("get_data_Stats")
}

#' @export

get_data_Stats.data.frame<-function (x=NULL, func=NULL,exclude=NULL,na.rm=FALSE,na_action=NULL,...) {

if(any(is.null(x), is.null(func))) stop("Both df and func must be supplied")

if(!is.null(exclude)){
  warning("Columns with classes in exclude have been discarded")
  
  x <- Filter(function(x) ! class(x) %in% exclude, x)
  
}

  if(na.rm){
   if(!anyNA(x)) warning("NA removal requested on data with no missing values")

    x<-na_replace(x,how=na_action,...)

}

sapply(x,function(x) do.call(func,list(x)))
  
  
}

# Alias get_data_Stats with something simpler

#' @rdname get_data_Stats
#' @examples get_stats(airquality,mean,"non_numeric",na.rm = TRUE,na_action = "get_mode")
#' @export
get_stats <- get_data_Stats




