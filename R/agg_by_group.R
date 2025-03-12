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
#' head(agg_by_group(airquality,.~Month,sum))
#' @export
agg_by_group <- function(df=NULL,my_formula=NULL,func=NULL,...){
  UseMethod("agg_by_group")
}
#' @export
agg_by_group.default <- function(df=NULL,my_formula=NULL,func=NULL,...){
  stop(paste0("Don't know how to deal with an object of class ", class(df)))

}
#' @export
agg_by_group.data.frame <-function(df=NULL,my_formula=NULL,func=NULL,...){

  if(any(is.null(my_formula), is.null(func), is.null(df))){
    stop("You should provide a data.frame, formula, and a function.")
  }


    my_formula<-deparse(substitute(my_formula))

  res<-aggregate(as.formula(my_formula),df,func,...)
  print(res)
  attr(res,"Groups")<-trimws(gsub("[~+]","",gsub(".*(?=~)","",my_formula,perl=TRUE),"left"))
  attr(res,"Groups")<-strsplit(attributes(res)$Groups,"\\s+")[[1]]
  res_list<-unlist(strsplit(attributes(res)["Groups"][[1]]," "))
  res_list<-res_list[res_list!=""]
  cat(noquote(paste0("Grouped By","[",length(res_list),"]",":","\t")))
  cat(gsub(",","",paste0(c(unlist(attributes(res)["Groups"])),sep=",")),"\n ")
  res
}

