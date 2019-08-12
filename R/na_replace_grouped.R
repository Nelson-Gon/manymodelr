#' Replace NAs by group
#' @description A convenient way to replace NAs by group.
#' @param df A data.frame object for which grouped NA replacement is desired.
#' @param group_by_cols The column(s) used to use for the grouping.
#' @param ... Other arguments to `na_replace`
#' @return A `data.frame` object with `NA`s replaced.
#' @examples 
#' test2 <- data.frame(A=c("A","A","A","B","B","B"),
#' B=c(NA,5,2,2,NA,2))
#' head(na_replace_grouped(test2,"A",
#' how="value","Replaced"))
#' test <- data.frame(groups=c("A","A","A","B","B","B"),
#'                   values = c(1,NA,2,1,NA,NA))
#' 
#'  na_replace_grouped(test,"groups",how="mean")
#' @export
na_replace_grouped <- function(df,group_by_cols=NULL,...){
  UseMethod("na_replace_grouped")
  
}
#' @export
na_replace_grouped <- function(df,group_by_cols=NULL,...){

# make groups
use_groups <- split(df,df[group_by_cols])
# Find which columns these are
grouping_cols <- which(names(df) %in% group_by_cols)
# Replace NAs
final_res<-do.call(rbind,lapply(use_groups, function(x) 
    cbind(x[grouping_cols],na_replace(x[-grouping_cols],
                          ...))))
# Drop row_names
rownames(final_res) <- 1:nrow(final_res)
# Return
final_res
  
}
