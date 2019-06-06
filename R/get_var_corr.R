#' Get correlations between variables
#' @importFrom stats cor.test
#' @description This function returns the correlations between different variables.
#' @param df The data set for which correlations are required
#' @param comparison_var The variable to compare to
#' @param other_vars Variables for which correlation with comparison_var is required. If not
#' supplied, all variables will be used.
#' @param get_all Logical. Should all variables be used for correlation? If true, all variables
#' are used. Defaults to TRUE.
#' @param method The method used to perform the correlation test as defined in 'cor.test'.
#' Defaults to pearson.
#' @param ... Other arguments to 'cor.test' see ?cor.test for details
#' @return A data.frame object containing correlations between comparison_var and each of other_vars
#' @examples
#' get_var_corr(mtcars, "mpg",get_all = TRUE)
#' get_var_corr(iris,"Sepal.Length","Petal.Length",get_all = FALSE,method="kendall")
#' @export
get_var_corr<- function (df, comparison_var, other_vars = NULL, get_all = TRUE,
                         method= "pearson",...)
{
  columns <- setdiff(names(df), comparison_var)
  if (get_all == TRUE){
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

