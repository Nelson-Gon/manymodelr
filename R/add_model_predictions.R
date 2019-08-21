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
add_model_predictions<- function(model,old_data,new_data){
  UseMethod("add_model_predictions")
}
#' @export
add_model_predictions<- function(model,old_data, new_data){
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
add_model_residuals <- function(model, old_data){
UseMethod("add_model_residuals")
  
}
#' @export
add_model_residuals <- function(model, old_data){
  old_data$residuals <-extract_model_info(model,"residuals")
  old_data
}















