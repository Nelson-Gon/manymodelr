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
  # This would have been done with dplyr but the where syntax requires import of tidyselect
  # I try to minimise imports as much as possible
  # I don't want to import tidyselect
  #dplyr::mutate(y,dplyr::across(tidyselect:::where(is.numeric), ~make_exponent(y=.,x=x)))

use_these_columns<-which(sapply(y, is.numeric))
warning("Replacing all numeric columns with their exponents inplace")
y[use_these_columns] <- sapply(y[use_these_columns],make_exponent,x=x)
    
y
}

#' @export
get_exponent.numeric<- function(y=NULL, x=NULL){
  make_exponent(y= y, x= x)
}
