#' A pipe friendly way to get summary stats for exploratory data analysis
#' @param x The data for which stats are required
#' @param func The nature of function to apply
#' @return A data.frame object showing the requested stats
#' @details A convenient wrapper especially useful for get_mode
#' @examples
#' library(dplyr)
#' mtcars %>%
#' get_data_Stats(mean)
#' mtcars %>%
#' get_data_Stats(get_mode)
#' \dontrun{
#' get_data_Stats(airquality,min)
#' airquality%>%
#' get_data_Stats(get_mode)
#' }
#' @export
get_data_Stats<-function(x,func){

  df<-x
  for(i in 1:ncol(x))
    if(is.numeric(i)){
      df[i]<-func(x[,i])
    }
  df<-reshape2::melt(df[1,],id.vars=1)
  df<-unique(df)
  df[-1]
}



