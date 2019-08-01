#' Get the exponent of any number or numbers
#' @param y The number for which an exponent is required
#' @param x The power to which y is raised
#' @return A data.frame object showing the value,power and result
#' @details Depends on the expo and expo1 functions in expo
#' @examples
#' df<-data.frame(A=c(1123,25657,3987))
#' get_exponent(df,3)
#' get_exponent(1:5, 6)
#' @export
get_exponent <- function(y,x){
  UseMethod("get_exponent")
}
#' @export
get_exponent.default <- function(y,x){
  stop(paste0("No implementation yet for objects of class 
               ", class(y)))
  
}

#' @export

get_exponent.data.frame<-function(y,x){
 target<-expo(x)
  res<-target(y)
  return(data.frame(Val=y,Pow=x,Res=res))
}

#' @export
get_exponent.numeric<- function(y,x){
  target<-expo(x)
  data.frame(Res=unlist(sapply(y, target)), Val=y,
             Pow=x)
}
