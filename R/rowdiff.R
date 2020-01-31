#' Get row differences between values
#' @description This function returns the differences between rows depending on the user's choice.
#' @param df The data set for which differences are required
#' @param direction One of forward and reverse. The default is forward meaning the differences
#' are calculated
#' in such a way that the difference
#' between the current value and the next is returned
#' @param exclude A character vector specifying what classes should be removed. See examples below
#' @param na.rm Logical. Should missing values be removed? The missing values referred to are those introduced during the calculation ie when subtracting a row with itself.
#' Defaults to FALSE.
#' @param na_action If na.rm is TRUE, how should missing values be replaced? Depending on the 
#' value as set out in `na_replace`, the value can be replaced as per the user's requirement.
#' @param ... Other arguments to `na_replace`.
#' @return A data.frame object of row differences
#' @examples
#' # Remove factor columns
#' rowdiff(iris,exclude = "factor",direction = "reverse")
#' rowdiff(iris[1:5,], exclude="factor",
#'      na.rm = TRUE, na_action = "get_mode",
#'      direction = "reverse")
#' @seealso \code{\link{na_replace}}
#' @export
rowdiff<-function (df, direction = "forward",exclude=NULL,
na.rm=FALSE,na_action=NULL,...){
  UseMethod("rowdiff")
}

#' @export
rowdiff.data.frame<-function(df, direction = "forward",
                             exclude=NULL,
                   na.rm=FALSE,na_action=NULL,...){

 if(is.null(exclude) & direction=="forward"){
    res<-as.data.frame(sapply(df,
                          function(x) x-dplyr::lead(x,1)))
    
    if(na.rm){
      na_replace(res,how=na_action, ...)
      
    }
    else{
      res
    }
    

}
  else if(is.null(exclude) & direction=="reverse"){
    res<-as.data.frame(sapply(df,
                          function(x) x-dplyr::lag(x,1)))
    if(na.rm){
      na_replace(res,how=na_action,...)
      
    }
    else{
      res
    }
  }

  else{
    
    filtered_df<-Filter(function(x) ! class(x) %in% exclude, df)
    
    if(direction=="forward"){
   res<-as.data.frame(sapply(filtered_df,
                          function(x) x-dplyr::lead(x,1)))
    if(na.rm){
      na_replace(res,how=na_action,...)
    
    }
    else{
      res
    }
}
  else{
   
    res<-as.data.frame(sapply(filtered_df,
                          function(x) x-dplyr::lag(x,1)))
    if(na.rm){
      na_replace(res,how=na_action, ...)
      
    }
    else{
      res
    }

  }
  
    }


}

