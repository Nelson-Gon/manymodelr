#' Perform several kinds of models in one click
#' @importFrom stats "as.formula"  "complete.cases" "setNames"
#' @param df The data for which analysis is required
#' @param yname The dependent variable
#' @param xname Theindependent variable. Supports formulae x1+x2+...
#' @param modeltype Currently one of lm and aov. Other models may work with inaccuracies
#' @param na.rm Logical. Should missing values be removed from analysis?
#' @param ... Additional arguments to the modeltype
#' @return A list containing summary stats and a data.frame object of some stats.
#' @details This function provides a friendly way to perform any kind of model in one line.
#' @examples
#' \dontrun{
#' modeleR(iris,Sepal.Length,Petal.Length,lm,na.rm=T)
#' }
#' @export
modeleR<-function(df,yname,xname,modeltype,na.rm=F,...){
  #Takes data as df,yname as y variable,xname as
  #x variables modletype of either lm or glm
  yname<-deparse(substitute(yname))
  xname<-deparse(substitute(xname))
  modeltype<-deparse(substitute(modeltype))
  formula1<-as.formula(paste(yname,"~",xname))
  if(!modeltype%in%c("lm","aov")) stop("Model Type Not Suitable.")
  if(modeltype=="lm"){
  lm.fit<-do.call(modeltype,list(data=quote(df),formula1,...))
  m<-summary(lm.fit)
  df<-as.data.frame(sapply(m,"[[",1)[c(3,4,8,9,10)])
  df<-cbind(df,Explanatory=xname,Response=yname)
  names(df)<-gsub("^r","R",names(df))
 return(
   list(DataFrame=df,Summary_data=m)
 )
  }
  else if(modeltype=="aov" & na.rm==T){
    lm.fit<-do.call(modeltype,list(data=quote(df),formula1,...))
    m<-summary(lm.fit)
    df<-as.data.frame(sapply(m,"["))
    df1<-as.data.frame(unlist(df))
    names(df1)<-c("Value")
    rownames(df1)<-gsub("V1.","",row.names(df1))

    df1<-dplyr::as_tibble(df1)
    df1$Var<-rownames(df1)
    df1$Value=round(df1$Value,3)
    df1<-df1[,c("Var","Value")]
    df1<-na.omit(df1)
     return(list(Summary_data=m,Stats=df1))
      #tibble::as.tibble(do.call(cbind,split(df1,substr(df$Var,1,1))))
  }
  else if(modeltype=="aov" & na.rm==F){
    lm.fit<-do.call(modeltype,list(data=quote(df),formula=formula1,...))
    m<-summary(lm.fit)
    df<-as.data.frame(sapply(m,"["))
    df1<-as.data.frame(unlist(df))
    names(df1)<-c("Value")
    rownames(df1)<-gsub("V1.","",row.names(df1))
    df1<-dplyr::as_tibble(df1)
    df1$Var<-rownames(df1)
    df1$Value=round(df1$Value,3)
       df1[,c("Value","Var")]
    return(list(Summary_data=m,Stats=df1))
    #tibble::as.tibble(do.call(cbind,split(df1,substr(df$Var,1,1))))
  }
}
