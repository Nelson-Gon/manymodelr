#' Get the row corresponding to a given percentile
#' @param df A `data.frame` object for which a percentile is required. Other data structures are not yet supported.
#' @param percentile The percentile required eg 10 percentile
#' @param get_all Logical. Should all variables be used? Currenty only supports
#' using all variables.
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
#' select_percentile(iris,5)
#'@export
select_percentile<-function(df,percentile,get_all=T,descend=FALSE){
  # Returns the value corresponding to a percentile
  # Returns mean values if the position of the percentile is  whole number
  # Values are sorted in ascending order. You can change this
  # by setting descend to TRUE.

  if(!is.data.frame(df)){
    stop("Please provide a `data.frame` object. Other
                            data types are not (yet) supported.")

  }
  numerics <- Filter(is.numeric,df)
  sort_by<- which(names(df)==names(numerics)[1])
  if(get_all==TRUE){
    sort_by<-names(numerics)[1]
    ordered_df<-df[sort(df[,sort_by],decreasing = descend,
                        index.return=T)[[2]],]
  }
  #return(ordered)
  nth<-(percentile / 100) * length(ordered_df)
  #return(nth)
  print(noquote(paste0("### Ordered by ",
                       names(numerics)[1]," ###")))

  if(nchar(nth)<=1){
    return(mean(ordered_df[nth:(nth+1)]))
  }
  else{
    ordered_df[ceiling(nth),]
  }

}
