#' Convenience functions for use with get_exponent
#' @param n The value to which a number should be raised. Useful for expo1
#' @details See ?get_exponent for details
#' @examples
#' \dontrun{
#' square<-expo(2)
#' square(4)
#' expo1(2,3)}
#' @export
expo<-function(n){
  force(n)
  function(x){
  res<-x^n
   #sum(res)
  }
}
#'Convenience functions for use with get_exponent
#'@param y The value for which an exponential is required
#'@param x The power to which y should be raised
#'@details See ?get_exponent for details
#'@examples
#'\dontrun{
#' square<-expo(2)
#' square(4)
#' expo1(2,3)}
#' @export
expo1<-function(y,x){


  target<-expo(x)
 res<-target(y)
 return(data.frame(Val=y,Pow=x,Res=res))
}


