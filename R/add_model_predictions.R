#' Add predictions to the data set.
#' A dplyr compatible way to add predictions to a data set.
#' @param model A model object from `fit_model`
#' @param old_data The data set to which predicted values will be added.
#' @param new_data The data set to use for predicting.
#' @return A data.frame object with a new column for predicted values
#' @seealso \code{\link{fit_model}} \code{\link{extract_model_info}}
#' @examples 
#' iris1 <- iris[1:50,]
#' iris2 <- iris[51:100,]
#' lm_model <- fit_model(iris1,"Sepal.Length","Sepal.Width","lm") 
#' head(add_model_predictions(lm_model,iris1,iris2))
#' @export
add_model_predictions<- function(model=NULL,old_data=NULL, new_data=NULL){
  UseMethod("add_model_predictions")
}
#' @export
add_model_predictions<- function(model=NULL,old_data=NULL, new_data=NULL){
  
  if(any(is.null(old_data), is.null(new_data), is.null(model))) stop("A model, old_data, and new_data must be provided")
  
 
  if(nrow(old_data)!=nrow(new_data)) stop("old_data and new_data must have equal lengths.")
  
  predictions <- predict(model,new_data)

  old_data$predicted <- predictions
  old_data
}

#' Add model residuals
#' @description A dplyr compatible convenience function to add residuals to a data set
#' @inheritParams add_model_predictions
#' @return A data.frame object with residuals added.
#' @examples 
#' iris1 <- iris[1:50,]
#' iris2 <- iris[51:100,]
#' lm_model <- fit_model(iris1,"Sepal.Length","Sepal.Width","lm") 
#' head(add_model_residuals(lm_model,iris1))
#' @export
add_model_residuals <- function(model=NULL, old_data=NULL){
UseMethod("add_model_residuals")
  
}
#' @export
add_model_residuals <- function(model=NULL, old_data=NULL){
  if(any(is.null(model), is.null(old_data))) stop("Both model and old_data are required.")
  old_data$residuals <- residuals(model)
  old_data
}















