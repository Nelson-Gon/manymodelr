#' Get correlations between variables
#' @importFrom stats cor.test
#' @description This function returns the correlations between different variables.
#' @param df The data set for which correlations are required
#' @param comparison_var The variable to compare to
#' @param other_vars variables for which correlation with comparison_var is required. If not
#' supplied, all variables will be used.
#' @param method The method used to perform the correlation test as defined in 'cor.test'.
#' Defaults to pearson.
#' @param drop_columns A character vector specifying column classes to drop. Defaults to 
#' c("factor","character")
#' @param ... Other arguments to 'cor.test' see ?cor.test for details
#' @return A data.frame object containing correlations between comparison_var and each of other_vars
#' @examples
#' # Get correlations between all variables
#' get_var_corr(mtcars,"mpg")
#' # Use only a few variables
#' get_var_corr(mtcars,"mpg", other_vars = c("disp","drat"), method = "kendall",exact=FALSE)
#' @export
get_var_corr<- function (df, comparison_var=NULL, other_vars = NULL, method= "pearson",
                         drop_columns=c("factor","character"),...){
  UseMethod("get_var_corr")
}
#' @export
get_var_corr.data.frame<-function (df, comparison_var=NULL, other_vars = NULL, method= "pearson",
                                   drop_columns=c("factor","character"),...)
{
  if(any(sapply(df,function(x) all(is.na(x))))){
    stop("Found columns with only NAs. Please remove these first.")
  }

  if(is.null(comparison_var)){
    stop("comparison_var is required.")
  }
  
  if(any(sapply(df,class) %in% drop_columns)){
    
    warning("Columns with classes in drop_columns have been discarded. You
              can disable this by setting yourself by setting drop_columns
              to NULL.")
    df <- Filter(function(x) ! class(x) %in% drop_columns,df)
}

columns <- setdiff(names(df), comparison_var)
  
if (!is.null(other_vars)){
  columns <- other_vars
}
    
if(method=="pearson"){
# get correlations
final_result<-do.call(rbind, lapply(columns, function(x) {
    correlations <- cor.test(get(comparison_var, as.environment(df)),
                     get(x, as.environment(df)),method=method,...)
    
    data.frame(comparison_var = comparison_var, Other_var = x,
               p.value = correlations$p.value, correlation= correlations$estimate,
               lower_ci= correlations$conf.int[1], upper_ci= correlations$conf.int[2])
  }))
structure(final_result,row.names= 1:nrow(final_result))
    
}
  else{
  final_result<- do.call(rbind,lapply(columns, function(x) {
      correlations <- cor.test(get(comparison_var, as.environment(df)),
                       get(x, as.environment(df)),method=method,...)
      
      data.frame(comparison_var = comparison_var, Other_var = x,
                 p.value = correlations$p.value, correlation= correlations$estimate)
    }))
  structure(final_result,row.names= 1:nrow(final_result))
  
}
    
   


}

