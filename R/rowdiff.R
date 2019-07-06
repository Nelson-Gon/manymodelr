#' Get row differences between values
#' @description This function returns the differences between rows depending on the user's choice.
#' @param df The data set for which differences are required
#' @param direction One of forward and reverse. The default is forward meaning the differences
#' are calculated
#' in such a way that the difference
#' between the current value and the next is returned
#' @param exclude What data types should be removed?! Currently only supports the entry
#' "non_numeric." See examples below
#' @param na.rm Logical. Should misisng values be removed? Defaults to FALSE.
#' @param na_action If na.rm is TRUE, how should missing values be replaced? Uses arguments
#' to ?na_replace.
#' @return A data.frame object of row differences
#' @examples
#' rowdiff(iris,exclude = "non_numeric",direction = "reverse")
#' rowdiff(mtcars)
#' @export
rowdiff<-function (df, direction = "forward",exclude=NULL,na.rm=FALSE,na_action=NULL){
  res<-df
  if(na.rm==TRUE & anyNA(res)==TRUE){
    res<-na_replace(res,how=na_action)
  }
  factr_or_char<-Filter(function(x) !is.numeric(x),res)
  if(is.null(exclude) & direction=="forward"){
    res<-sapply(res,function(x) x-dplyr::lead(x,1))

  }
  else if(is.null(exclude) & direction=="reverse"){
    res<-sapply(res,function(x) x-dplyr::lag(x,1))
  }

  else if(exclude=="non_numeric" & direction=="forward"){
    include<-setdiff(names(res),names(factr_or_char))
    res<-res[,include]
    res<-sapply(res,function(x) x-dplyr::lead(x,1))
  }
  else{
    include<-setdiff(names(res),names(factr_or_char))
    res<-res[,include]
    res<-sapply(res,function(x) x-dplyr::lag(x,1))

  }

  as.data.frame(res)
}

