# 'These are helper functions that should never have been exported
#' @title  Convenience functions for use with get_exponent
#' @param n Power to which a value should be raised
#' @details This is a function factory that creates an exponent from a given value of n
#' @return Returns n to the power of n
#' @keywords internal
#' @noRd 

force_exponent<-function(n){
  force(n)
  function(x){
    x^n
    
  }
}

#' @param y A numeric value whose exponent is required
#' @param x The power to which y is to be raised
#' @return y to the power of x.
#' @keywords internal
#' @noRd

make_exponent<-function(y=NULL,x=NULL){
  if(any(is.null(x), is.null(y))) stop("Both x and y should be supplied. Please see the docs for details")
  if(any(!is.numeric(y),!is.numeric(x))) stop("Only numerics are supported")
  get_exponent_helper<-force_exponent(x)
  get_exponent_helper(y)
 
}

# skip tests on old releases

skip_on_oldrel <- function(version="3.6.3", msg = NULL) {
  current_version <- utils::packageVersion("base")
  if (current_version <= version) {
    msg <- paste("R version",current_version, "not supported. Please upgrade to R>= 3.6.3")
    testthat::skip(msg)
  }
}

#' Drops non numeric columns from a data.frame object
#' @param df A data.frame object for which non-numeric columns will be dropped
#' @examples 
#' head(drop_non_numeric(iris))
#' @export

drop_non_numeric <- function(df){
  UseMethod("drop_non_numeric")
  
}

#' @export

drop_non_numeric.data.frame <- function(df){
  Filter(is.numeric, df)
}

