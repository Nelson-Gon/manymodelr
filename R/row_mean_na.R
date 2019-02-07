#' @title Replacing all NAs with mean values of a given row
#' @param data is the data you for which the mean is needed
#' @param func describes the function to use. Currrently only supports the mean(others may work with some inaccuracies)
#' @param observations takes on column names  for which manipulations are required
#' @param na.rm Logical. Should NAs be removed from analysis?
#' @param exc the column to exclude from analysis. Useful for removing factor columns
#' @return Returns a data.frame object showing columns with NAs and their replacement if na.rm=T
#' @export
#' @examples
#' #This merges our replacement values with the original data containing NAs
#' row_mean_na(airquality,mean,c("Ozone","Wind"),na.rm=TRUE,0)
#' \dontrun{
#' row_mean_na(iris,max,c("Sepal.Length","Petal.Length"),na.rm = F,5)
#' }
row_mean_na<-function(data,func,observations,na.rm=F,exc){
  m<-as.data.frame(mget(observations,envir = as.environment(data)))
  if(na.rm==T){
  #m[is.na(m)]<-as.numeric(0)
  res1<-apply(m[complete.cases(m),],1,func)
  m<-m[!complete.cases(m),]
  m[is.na(m)]<-0
  res2<-rowSums(m)/ncol(m)
  with_NA<-data[,observations]
  with_NA<-with_NA[!complete.cases(with_NA),]
 res<-reshape2::melt(c(res1,res2))
 res_with_NA<-setNames(cbind(res2,with_NA),nm=c("Replacement"))
 #return(list(res1,res2,with_NA,res_with_NA["Replacement"]))
 replaced<-list(res1,res2,res_with_NA["Replacement"])[3]
 merge(data,replaced,by=0)[-1]
 #res2  contains mean for rows with NAs
 #exc is the column to exclude ie has non numeric data
  #res1 has mean for all rows with no NAs
  }else{
 res3<-reshape2::melt(apply(m,1,func))
 data.frame(data,res3)
}
}

