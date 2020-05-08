#' Get the exponent of any number or numbers
#' @param y The number or numeric columns for which an exponent is required
#' @param x The power to which y is raised
#' @return A data.frame object showing the value,power and result
#' @details Depends on the expo and expo1 functions in expo
#' @examples
#' df<-data.frame(A=c(1123,25657,3987))
#' get_exponent(df,3)
#' get_exponent(1:5, 2)
#' @export
get_exponent <- function(y=NULL, x=NULL){
  UseMethod("get_exponent")
}
#' @export
get_exponent.default <- function(y=NULL, x=NULL){
  make_exponent(y=NULL, x=NULL)

  
}

#' @export

get_exponent.data.frame<-function(y=NULL, x=NULL){
 
    y %>%
    dplyr::mutate(dplyr::across(is.numeric,~make_exponent(.,x=x)))
    
 

}

#' @export
get_exponent.numeric<- function(y=NULL, x=NULL){
  make_exponent(y= y, x= x)
}
