#' Get correlations for combinations
#' @param df A `data.frame` object for which correlations are required in combinations.
#' @param ... Other arguments to `get_var_corr`
#' @return A data.frame object with combinations.
#' @details This function extends get_var_corr by providing an opportunity to get correlations
#' for combinations of variables. It is currently slow and may take up to a minute depending on system specifications.
#' @examples 
#' get_var_corr_(mtcars,exact=FALSE,method="spearman")
#' @export
get_var_corr_<-function(df,...){
  
get_combn<-expand.grid(names(df),names(df))
no_dupe<-apply(get_combn,1,function(x) x[!anyDuplicated(x)])
plyr::ldply(lapply(no_dupe[lengths(no_dupe)>0],
            function(x) get_var_corr(df=df,
                         comparison_var = x[1],
                            other_vars = x[2],
                         get_all = FALSE,...)),
              data.frame)[,-1] 
  
}

