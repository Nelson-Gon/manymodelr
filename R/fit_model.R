#' @param df A data.frame object
#' @inheritParams multi_model_1
#' @param modeltype A character specifying the model type e.g lm for linear model
#' @param ... Other arguments to specific model types.
#' @name fit_model
#' @title Fit and predict in a single function.
#' @examples
#' fit_model(iris,"Sepal.Length","Species","lm")
#' fit_model(iris,"Sepal.Width","Sepal.Length + Petal.Length + I(Petal.Width)**2","lm")

#' @export
fit_model <- function (df=NULL, yname=NULL, xname=NULL, modeltype=NULL,...){
  if(any(is.null(df), is.null(yname),is.null(xname),is.null(modeltype))){
    stop("All arguments must be supplied.")
  }

 model_formula <- as.formula(paste(yname, "~", xname))
  do.call(modeltype, list(data = quote(df), model_formula,...))
}







