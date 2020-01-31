#' Get correlations between variables
#' @importFrom stats cor.test
#' @description This function returns the correlations between different variables.
#' @param df The data set for which correlations are required
#' @param comparison_var The variable to compare to
#' @param other_vars Variables for which correlation with comparison_var is required. If not
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
#' get_var_corr(mtcars,"mpg", other_vars = c("disp","drat"), method = "kendall",
#'  exact=FALSE)
#' @export
get_var_corr<- function (df, comparison_var, other_vars = NULL, 
            method= "pearson",
            drop_columns=c("factor","character"),
                 ...){
  UseMethod("get_var_corr")
}
#' @export
get_var_corr.data.frame<-function (df, comparison_var, other_vars = NULL, 
                                   method= "pearson",
                                   drop_columns=c("factor","character"),
                                   ...)
{
  if(any(sapply(df,function(x) all(is.na(x))))){
    stop("Cannot perform correlation tests on columns with only NAs. Please
         remove these or impute missing values with known methods. Alternatively, set use='complete.obs'
         to use complete observations. See details in help(get_var_corr)")
  }

  columns <- setdiff(names(df), comparison_var)
  
  if (is.null(other_vars)){
    
    if(any(sapply(df,class) %in% drop_columns)){
      
    warning("Columns with classes in drop_columns have been discarded. You
              can disable this by setting yourself by setting drop_columns
              to NULL.")
      df <- Filter(function(x) ! class(x) %in% drop_columns,df)
      columns <- setdiff(names(df), comparison_var)
    }
    
      if(method=="pearson") {
    res <- plyr::ldply(lapply(columns, function(x) {
      res1 <- cor.test(get(comparison_var, as.environment(df)),
                       get(x, as.environment(df)),method=method,...)
      data.frame(Comparison_Var = comparison_var, Other_Var = x,
                 p_value = res1$p.value, Correlation = res1$estimate,
                 lower_ci= res1$conf.int[1], upper_ci= res1$conf.int[2]
                 )
    }), data.frame)
    res
    }
    else{
      res <- plyr::ldply(lapply(columns, function(x) {
        res1 <- cor.test(get(comparison_var, as.environment(df)),
                         get(x, as.environment(df)),method=method,...)

        data.frame(Comparison_Var = comparison_var, Other_Var = x,
                   p.value = res1$p.value, Correlation= res1$estimate)
      }), data.frame)
      res
    }
  }
    else{
      if(method=="pearson"){
 res <- plyr::ldply(lapply(other_vars, function(x) {
      res1 <- cor.test(get(comparison_var, as.environment(df)),
                       get(x, as.environment(df)),method=method,...)

      data.frame(Comparison_Var = comparison_var, Other_Var = x,
                 p.value = res1$p.value, Correlation= res1$estimate,
                 lower_ci= res1$conf.int[1], upper_ci= res1$conf.int[2])
    }), data.frame)
    res
      }
    else{
      res <- plyr::ldply(lapply(other_vars, function(x) {
        res1 <- cor.test(get(comparison_var, as.environment(df)),
                         get(x, as.environment(df)),method=method,...)

        data.frame(Comparison_Var = comparison_var, Other_Var = x,
                   p.value = res1$p.value, Correlation= res1$estimate)
      }), data.frame)
      res
    }

    }


}

