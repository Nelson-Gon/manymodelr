#' Fit and predict in one function
#' @inheritParams add_model_predictions
#' @inheritParams fit_model
#' @examples 
#' # fit a linear model and get predictions
#' multi_model_2(iris[1:50,],iris[50:99,],"Sepal.Length","Petal.Length","lm")
#' # multilinear
#' multi_model_2(iris[1:50,],iris[50:99,],"Sepal.Length",
#'     "Petal.Length + Sepal.Width","lm")
#' # glm
#' multi_model_2(iris[1:50,],iris[50:99,],"Sepal.Length","Petal.Length","glm")
#' @export
multi_model_2 <- function(old_data, new_data, yname,xname,modeltype,...){
  # check that lengths are actually equal before making prediictions
  if(nrow(old_data) != nrow(new_data)){
    stop("Both old_data and new_data must have the same lengths")
  }
  # check  for name validity
  # assumes 'one to many', many to one might not work
  if(! all(yname %in% names(old_data), yname %in% names(new_data))){
    stop("yname must be a valid column name in both datasets.")
  }
   model_fit <- fit_model(old_data,yname,xname,modeltype,...)
  # Use the fit model to add  model_predictions to the new data
  
  add_model_predictions(model = model_fit,old_data, new_data)
  
  
}




