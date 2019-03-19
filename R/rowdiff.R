#' Get row differences between values
#' @description This function returns the differences between rows depending on the user's choice.
#' @param df The data set for which differences are required
#' @param direction One of forward and reverse. The default is forward meaning the differences are calculated
#' in such a way that the difference between the current value and the next is returned
#' @return A data.frame object of row differences
#' @examples
#' rowdiff(iris[1:5,-5])#-5 to remove factor column.
#' rowdiff(iris[1:10,-5],direction="reverse")
#' @export
rowdiff<-function (df, direction = "forward"){
  res<-df
  if(direction=="forward"){
    res<-apply(df,2,function(x) x-dplyr::lead(x,1))
  }else{
    res<-apply(df,2,function(x) x-dplyr::lag(x,1))
  }
  as.data.frame(res)
}

