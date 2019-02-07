#' Perform many models in a single command
#' @description This function provides a convenient way to train several model types.
#' @param df The data holding the training dataset
#' @param yname The outcome variable
#' @param xname The predictor variable(s)
#' @param method One of the many methods available in caret
#' @param metric One of several metrics. Accuraciy,RMSE,MAE,etc
#' @param control See caret ?trainControl for details.
#' @param ... Other arguments to caret's train function
#' @importFrom magrittr "%>%"
#' @importFrom stats "as.formula"  "complete.cases" "setNames" "na.omit"
#' @importFrom dplyr "arrange" "desc"
#' @import caret
#' @return A data.frame object of summary statistics of the model types used
#' @details Most of the details of the parameters can be found in the caret package documentation.
#' This function is meant to help in exploratory analysis to make an informed choice of the best models
#' @examples
#' \dontrun{
#' ctrl<-trainControl(method="cv",number=5)
#' multi_model(iris,"Species",".",c("rf","svmRadial","knn"),"Accuracy",ctrl)
#' my_grid<-expand.grid(.mtry=c(4:12))
#' multi_model(iris,"Species",".",c("rf"),"Accuracy",ctrl,tuneGrid=my_grid)
#' }
#' @export
 multi_model<-function(df,yname,xname,method,metric,control,...){
  #yname<-deparse(substitute(yname))
  #xname<-unlist(sapply(substitute(...()),deparse))
  df<-df
  methods1<-method
 f1<-as.formula(paste0(yname,"~",xname))
 fit<-lapply(methods1,function(met){set.seed(233)
   fit<-do.call("train",list(data=quote(df),f1,metric=metric,trControl=control,
                             method=met,...))})

 res<-plyr::ldply(fit,function(mod) data.frame(mod$results,
                                        Type=mod$modelInfo$tags[1:nrow(mod$results)]))
 dplyr::arrange(res,dplyr::desc(res$Accuracy))
 }

