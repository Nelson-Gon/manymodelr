#' Perform several kinds of models in one function
#' @importFrom stats "as.formula"  "complete.cases" "setNames"
#' @importFrom stats "predict"
#' @param df The data for which analysis is required
#' @param yname The dependent variable
#' @param xname Theindependent variable. Supports formulae x1+x2+...
#' @param modeltype Currently one of lm and aov. Other models may work with inaccuracies
#' @param na.rm Logical. Should missing values be removed from analysis?
#' @param new_data A data.frame object for which new predictions are to be made
#' @param ... Additional arguments to the modeltype
#' @return A list containing summary stats and a data.frame object of some stats.
#' @details This function provides a friendly way to perform any kind of model in one line.
#' The model uses the inbuilt R functions aov and lm to make the predictions.
#' @references
#' Chambers, J. M. (1992) Linear models. Chapter 4 of Statistical Models in S eds J. M. Chambers and T. J. Hastie, Wadsworth & Brooks/Cole.
#'
#'Wilkinson, G. N. and Rogers, C. E. (1973). Symbolic descriptions of factorial models for analysis of variance. Applied
#'Statistics, 22, 392-399. doi: 10.2307/2346786.
#' @examples
#' iris1<-iris[1:60,]
#' iris2<-iris[60:nrow(iris),]
#' modeleR(iris1,Sepal.Length,Petal.Length,
#'          lm,na.rm=TRUE,iris2)
#' @export
modeleR<-function(df,yname,xname,modeltype,na.rm=F,new_data,...){
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
    list(DataFrame=df,Summary_data=m,
         Predictions=data.frame(Predictions=as.data.frame(predict(lm.fit))))
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
    list(DataFrame=df,Summary_data=m,Predictions=data.frame(Predictions=
                                                              as.data.frame(predict(lm.fit))))
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
    list(DataFrame=df,Summary_data=m,Predictions=data.frame(Predictions=
                                                              as.data.frame(predict(lm.fit))))
    #tibble::as.tibble(do.call(cbind,split(df1,substr(df$Var,1,1))))
  }
}

