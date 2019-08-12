#' Simultaneously train and predict on new data.
#' @description This function provides a convenient way to train several model types.
#' It allows a user to predict on new data and depending on the  metrics, the user is able to decide which model
#' predictions to finally use. The models are built based on Max Kuhn's models in the caret package.
#' @param df The data holding the training dataset
#' @param yname The outcome variable
#' @param xname The predictor variable(s)
#' @param method A vector containing methods to be used as defined in the caret package
#' @param metric One of several metrics. Accuracy,RMSE,MAE,etc
#' @param control See caret ?trainControl for details.
#' @param newdata A data set to validate the model or for which predictions are required
#' @param ... Other arguments to caret's train function
#' @param valid Logical. Are you performing validation or dealing with new data? Defaults to False. Predictions added to new
#' data
#' @importFrom magrittr "%>%"
#' @importFrom stats "as.formula"  "complete.cases" "setNames" "na.omit" "predict"
#' @importFrom dplyr "arrange" "desc"
#' @import caret
#' @import e1071
#' @rawNamespace   import(Metrics,except=c("precision","recall"))
#' @return A list containing two objects. A tibble containing a summary of the metrics per model,
#' a tibble containing predicted values and information concerning the model
#' @details Most of the details of the parameters can be found in the caret package documentation.
#' This function is meant to help in exploratory analysis to
#' make an informed choice of the best models
#' @references
#' Kuhn (2014), "Futility Analysis in the Cross-Validation of Machine Learning Models" http://arxiv.org/abs/1405.6974,
#'
#' Kuhn (2008), "Building Predictive Models in R Using the caret" (http://www.jstatsoft.org/article/view/v028i05/v28i05.pdf)
#' @examples
#' library(caret)
#' train_set<-createDataPartition(iris$Species,p=0.8,list=FALSE)
#' valid_set<-iris[-train_set,]
#' train_set<-iris[train_set,]
#' ctrl<-trainControl(method="cv",number=5)
#' set.seed(233)
#' m<-multi_model_1(train_set,"Species",".",c("knn","rpart"),
#' "Accuracy",ctrl,newdata =valid_set,valid=TRUE)
#' m$Predictions
#' m$Metrics
#' m$modelInfo
#' @export
multi_model_1<-function (df, yname, xname, method, metric, control, ..., newdata,
valid=FALSE)
{
  UseMethod("multi_model_1")
}
#' @export
multi_model_1<-function (df, yname, xname, method, metric, control, ..., newdata,
                              valid=FALSE)
 {
  if(is.null(newdata) || missing(newdata)){
    stop("Please provide a data frame to perform validation or predict on
         unseen data. ")
  }
  if(valid){
    df <- df
    methods1 <- method
    f1 <- as.formula(paste0(yname, "~", xname))
    fit <- lapply(methods1, function(met) {
      set.seed(520)
      fit <- do.call("train", list(data = quote(df), f1, metric = metric,
                                   trControl = control, method = met, ...))
    })
    preds <- lapply(fit, function(x) predict(x, newdata))
    res <- as.data.frame(sapply(preds, function(x) do.call(unlist,
                                                           list(x))))
    names(res) <- method
    new_metric <- tolower(metric)
    new_metric <- eval(parse(text = paste0("Metrics::", new_metric)))
    print("Returning Metrics")
    #res
    metrics <- lapply(res, function(x) new_metric(newdata[,yname],
                                                  x))
    #res1<-list(Results=tibble::as_tibble(newdata),res=res)
    Results <- list(Metrics = tibble::as_tibble(metrics), Predictions = tibble::as_tibble(res),
                    modelInfo=fit)

  }
  else{
    df <- df
    methods1 <- method
    f1 <- as.formula(paste0(yname, "~", xname))
    fit <- lapply(methods1, function(met) {
      
     set.seed(520)
 fit <- do.call("train", list(data = quote(df), f1, metric = metric,
                                   trControl = control, method = met, ...))
    })
    preds <- lapply(fit, function(x) predict(x, newdata))
    res <- as.data.frame(sapply(preds, function(x) do.call(unlist,
                                                           list(x))))
    names(res) <- method
    new_metric <- tolower(metric)
    new_metric <- eval(parse(text = paste0("Metrics::", new_metric)))
    print("Returning Metrics")
    #res
    newdata[yname]<-res
    metrics <- lapply(res, function(x) new_metric(newdata[,yname],
                                                  x))
    #res1<-list(Results=tibble::as_tibble(newdata),res=res)
    Results <- list(Metrics = tibble::as_tibble(metrics), Predictions = tibble::as_tibble(res),
                    modelInfo=fit)
  }


}
