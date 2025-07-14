#' Simultaneously train and predict on new data.
#' @description This function provides a convenient way to train several model types.
#' It allows a user to predict on new data and depending on the  metrics, the user is able to decide which model
#' predictions to finally use. The models are built based on Max Kuhn's models in the caret package.
#' @param old_data The data holding the training dataset
#' @param yname The outcome variable
#' @param xname The predictor variable(s)
#' @param method A vector containing methods to be used as defined in the caret package
#' @param metric One of several metrics. Accuracy,RMSE,MAE,etc
#' @param control See caret ?trainControl for details.
#' @param new_data A data set to validate the model or for which predictions are required
#' @param ... Other arguments to caret's train function
#' @return A list containing two objects. A tibble containing a summary of the metrics per model,
#' a tibble containing predicted values and information concerning the model
#' @details Most of the details of the parameters can be found in the caret package documentation.
#' This function is meant to help in exploratory analysis to
#' make an informed choice of the best models
#' @references
#' Kuhn (2014), "Futility Analysis in the Cross-Validation of Machine Learning Models" http://arxiv.org/abs/1405.6974,
#'
#' Kuhn (2008), "Building Predictive Models in R Using the caret" (http://www.jstatsoft.org/article/view/v028i05/v28i05.pold_data)
#' @examples
#' data("yields", package="manymodelr")
#' train_set<-caret::createDataPartition(yields$normal,p=0.8,list=FALSE)
#' valid_set<-yields[-train_set,]
#' train_set<-yields[train_set,]
#' ctrl<-caret::trainControl(method="cv",number=5)
#' set.seed(233)
#' m<-multi_model_1(train_set,"normal",".",c("knn","rpart"),
#' "Accuracy",ctrl,new_data =valid_set)
#' m$Predictions
#' m$Metrics
#' m$modelInfo
#' @export
multi_model_1<-function (old_data, yname, xname, method=NULL, metric=NULL, control=NULL,new_data=NULL,  ...)
{
  UseMethod("multi_model_1")
}
#' @export
multi_model_1<-function (old_data, yname, xname, method=NULL, metric=NULL, control=NULL,new_data=NULL,
                         ...) {

  if(any(is.null(new_data),is.null(metric),is.null(method), is.null(control))){
    stop("new_data,metric,method, and control must all be supplied")
  }



model_formula <- as.formula(paste0(yname, "~", xname))
fitted_model <- lapply(method, function(met) {
    set.seed(520)
    fit <- do.call("train", list(data = quote(old_data), model_formula, metric = metric,
                                 trControl = control, method = met, ...))
  })
  predictions <- lapply(fitted_model, function(x) predict(x, new_data))
  predicted_values <- as.data.frame(sapply(predictions, function(x) do.call(unlist,list(x))))
  new_metric <- tolower(metric)
  names(predicted_values) <- method



metrics <- lapply(predicted_values, function(x) do.call(new_metric, list(new_data[,yname],x)))


final_results <- list(metric = as_tibble(metrics), predictions =
                        as_tibble(predicted_values),
                      model_info=fitted_model)

names(final_results$metric) <- paste(names(final_results$metric),new_metric,sep = "_")
final_results



}

