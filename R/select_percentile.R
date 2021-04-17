#' Get the row corresponding to a given percentile
#' @param df A `data.frame` object for which a percentile is required. Other data structures are not yet supported.
#' @param percentile The percentile required eg 10 percentile
#' @param descend Logical. Should the data be arranged in descending order? Defaults
#' to FALSE.
#' @details 
#' Returns the value corresponding to a percentile. 
#' Returns mean values if the position of the percentile is  whole number.
#' Values are sorted in ascending order. You can change this by setting descend to TRUE.
#' 
#' 
#' @return A dataframe showing the row corresponding to the required percentile.
#' @examples
#' data("yields", package="manymodelr")
#' select_percentile(yields,5)
#'@export
select_percentile<-function(df=NULL,percentile=NULL,descend=FALSE){
  UseMethod("select_percentile")
}


#' @export
select_percentile.data.frame<-function(df=NULL,percentile=NULL,descend=FALSE){
  
  # Returns the value corresponding to a percentile
  # Returns mean values if the position of the percentile is  whole number
  # Values are sorted in ascending order. You can change this
  # by setting descend to TRUE.
if(any(is.null(df), is.null(percentile))){
  stop("Must provide both df and percentile.")
}
numerics <- Filter(is.numeric,df)
sort_by<- which(names(df)==names(numerics)[1])
sort_by<-names(numerics)[1]
ordered_df<-df[sort(df[,sort_by],decreasing = descend,index.return=TRUE)[[2]],]
nth<-(percentile / 100) * length(ordered_df)
print(noquote(paste0("### Ordered by ",names(numerics)[1]," ###")))
if(nchar(nth)<=1){
    return(mean(ordered_df[nth:(nth+1)]))
}
else{
    ordered_df[ceiling(nth),]
}

}
