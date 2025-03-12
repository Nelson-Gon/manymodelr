#' A convenient way to perform grouped operations
#' @importFrom stats aggregate
#' @description This function performs operations by grouping the data.
#' @param data_set The data set for which correlations are required
#' @param my_formula A formula such as A~B where B is the grouping variable(normally a factor).
#' See examples below
#' @param  func The kind of operation e.g sum,mean,min,max,manymodelr::get_mode
#' @param ... Other arguments to 'aggregate' see ?aggregate for details
#' @return A grouped data.frame object with results of the chosen operation.
#' @examples
#' head(agg_by_group(airquality,.~Month,sum))
#' @export
agg_by_group <- function(data_set=NULL,my_formula=NULL,func=NULL,...){
  UseMethod("agg_by_group")
}
#' @export
agg_by_group.default <- function(data_set=NULL,my_formula=NULL,func=NULL,...){
  stop(paste0("Don't know how to deal with an object of class ", class(data_set)))

}
#' @export
agg_by_group.data.frame <-function(data_set=NULL,my_formula=NULL,func=NULL,...){

  if(any(is.null(my_formula), is.null(func), is.null(data_set))){
    stop("You should provide a data.frame, formula, and a function.")
  }


  my_formula<-deparse(substitute(my_formula))

  res<-aggregate(as.formula(my_formula),data_set,func,...)
  extracted_attr <- trimws(gsub("[~+]","",gsub(".*(?=~)","",my_formula,perl=TRUE),"left"))
  attr(res,"Groups")<-extracted_attr
  attr(res,"Groups")<-strsplit(attributes(res)$Groups,"\\s+")[[1]]
  res_list<-unlist(strsplit(attributes(res)["Groups"][[1]]," "))
  res_list<-res_list[res_list!=""]
  cat(noquote(paste0("Grouped By","[",length(res_list),"]",":","\t")))
  cat(gsub(",","",paste0(c(unlist(attributes(res)["Groups"])),sep=",")),"\n ")
  res
}

