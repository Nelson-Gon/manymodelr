#' @title Replacing all NAs with mean values of a given row
#' @param data is the data you for which the mean is needed
#' @param func describes the function to use. Currently only supports the mean(others may work with some inaccuracies)
#' @param observations takes on column names  for which manipulations are required
#' @param na.rm Logical. Should NAs be removed from analysis?
#' @param exc the column to exclude from analysis. Useful for removing factor columns
#' @return Returns a data.frame object showing columns with NAs and their replacement if na.rm=T
#' @export
row_mean_na<-function(data,func,observations,na.rm=FALSE,exc){
  ###This is no longer used. Was a design flaw####
  .Defunct("na_replace")
  m<-as.data.frame(mget(observations,envir = as.environment(data)))
  if(na.rm){
  res1<-apply(m[complete.cases(m),],1,func)
  m<-m[!complete.cases(m),]
  m[is.na(m)]<-0
  res2<-rowSums(m)/ncol(m)
  with_NA<-data[,observations]
  with_NA<-with_NA[!complete.cases(with_NA),]
 res<-reshape2::melt(c(res1,res2))
 res_with_NA<-setNames(cbind(res2,with_NA),nm=c("Replacement"))
 replaced<-list(res1,res2,res_with_NA["Replacement"])[3]
 merge(data,replaced,by=0)[-1]

  }else{
 res3<-reshape2::melt(apply(m,1,func))
 data.frame(data,res3)
}
}
#' @title Replace missing values
#' @param df The data set(data.frame or vector) for which replacements are required
#' @param how How should missing values be replaced?  One of ffill, samples,value or any other known
#' method e.g mean, median, max ,min. The default is NULL meaning no  imputation is done. For character vectors,
#' the use of `get_mode` is also supported. No implementation for class factor(yet).
#' @param value If how is set to value, this allows the user to provide a specific fill value for the NAs.
#' @details This function currently does not support grouping although this may be achieved with some
#' inaccuracies using grouping functions from other packages.
#' @return A data.frame object with missing values replaced.
#' @examples
#' na_replace(airquality,how="value", value="Missing")
#' @export
na_replace<-function(df,how=NULL,value=NULL){
  UseMethod("na_replace")
}
#' @export

na_replace.data.frame<-function(df,how=NULL,value=NULL){
do.call(data.frame,list(sapply(df,na_replace.character,how=how,value=value)))
  
}
#' @export
na_replace.numeric<-function(df=NULL,how=NULL,value=NULL){

  if(any(is.null(df), is.null(how))){
    stop("df and how must both be provided.")
  }
  # individually get replacements 
  if(! how%in%c("ffill","samples","value", "get_mode")){
    stop("how should be one of ffill, samples, value or get_mode.")
  }
  # fill missing values with next value
  to_replace<-df[!is.na(df)]


switch(how,
         ffill =  ifelse(is.na(df), to_replace[1:length(df[is.na(df)])],df),
         sample =       
           ifelse(is.na(df),sample(na.omit(df),length(df[is.na(df)]),
                                   replace = TRUE),df),
         value = ifelse(is.na(df),value, df),
         get_mode = ifelse(is.na(df),do.call("get_mode",list(na.omit(df))),df))
  
  
}
#' @export
na_replace.character<- na_replace.numeric
