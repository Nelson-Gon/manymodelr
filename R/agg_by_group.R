#' A convenient way to perform grouped operations
#' @importFrom stats aggregate
#' @description This function performs operations by grouping the data.
#' @param df The data set for which correlations are required
#' @param my_formula A formula such as A~B where B is the grouping variable(normally a factor).
#' See examples below
#' @param  func The kind of operation e.g sum,mean,min,max,manymodelr::get_mode
#' @param ... Other arguments to 'aggregate' see ?aggregate for details
#' @return A grouped data.frame object with results of the chosen operation.
#' @examples
#' agg_by_group(airquality,.~Month,sum)
#' @export
agg_by_group <- function(df,my_formula,func, ...){
  UseMethod("agg_by_group")
}
#' @export
agg_by_group.default <- function(df, ...){
  stop(paste0("Don't know how to deal with an 
               object of class ", class(df)))
  
}
#' @export
agg_by_group.data.frame <-function(df,my_formula,func,...){
  my_formula<-deparse(substitute(my_formula))
  
  res<-aggregate(as.formula(my_formula),df,func,...)
  attr(res,"Groups")<-gsub("[~+]","",
                           gsub(".*(?=~)","",
                                my_formula,perl=TRUE))
  res_list<-strsplit(attributes(res)["Groups"][[1]]," ")[[1]]
  res_list<-res_list[res_list!=""]
  cat(noquote(paste0("Grouped By","[",length(res_list),"]",
                     ":","\t")))
  cat(gsub(",","",paste0(c(unlist(attributes(res)["Groups"])),
                         sep=",")),"\n ")
  res
}

