#' Helper function to easily access elements
#' @param what What do you want to extract from the `data.frame` or `list`? No quotes. See
#' examples below.
#' @param where Where do you want to get it from? Currently only supports `list`s
#' and `data.frame`objects.
#' @details This is a helper function useful if you would like to extract data from
#' the output of `multi_model_1`.
#' @examples
#' my_list<-list(list(A=520),list(B=456,C=567))
#' get_this(what="A",my_list)
#' get_this(my_list,"C")
#' # use values
#' get_this(my_list, "B")
#' @export
get_this<- function (where=NULL, what=NULL){
  UseMethod("get_this")
 
}
#' @export
get_this.list<- function(where=NULL,what=NULL){
 if(any(is.null(what), is.null(where))){
   stop("Both what and where are required")
 }

if(!any(sapply(where,is.list))){
  if(all(!is.null(names(where)),any(!what %in% names(where)))){
    stop("what should be a valid name in where. Perhaps you have an unnamed list?")
  }
  final_result<-where[what]
}

  if(any(sapply(where,is.list))){
  
  if(all(!is.null(names(where)),any(! what %in% unlist(sapply(my_list,names))))){
    stop("what should be a valid name in where. Perhaps you have an unnamed list?") 
  }

final_result<-Filter(Negate(is.null), Map(function(x)x[[what]],where))
}

final_result
}


#' @export 

get_this.data.frame <- get_this.list
  
  
 
  
 

  







