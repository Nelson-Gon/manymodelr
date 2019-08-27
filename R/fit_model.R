#' @inheritParams modeleR
#' @name fit_model
#' @title Fit and predict in a single function.
#' @examples
#' fit_model(iris,"Sepal.Length","Species","aov")
#' fit_model(iris,"Sepal.Width","Sepal.Length + Petal.Length + I(Petal.Width)**2","lm")
#' @export
fit_model <- function (df, yname, xname, modeltype,...)
{
  UseMethod("fit_model")
}
#' @export
fit_model <- function (df, yname, xname, modeltype,...){
  
  model_formula <- as.formula(paste(yname, "~", xname))
  do.call(modeltype, list(data = quote(df), model_formula,
                          ...))
}







#' Perform several kinds of models in one function
#' @importFrom stats "as.formula"  "complete.cases" "setNames"
#' @importFrom stats "predict"
#' @param df The data for which analysis is required
#' @param yname The dependent variable
#' @param xname The independent variable. Supports formulae x1+x2+...
#' @param modeltype Currently one of lm, glm and aov. Other models may work with inaccuracies
#' @param na.rm Logical. Should missing values be removed from analysis?
#' @param new_data A data.frame object for which new predictions are to be made
#' @param ... Additional arguments to the modeltype
#' @return A list containing summary stats and a data.frame object of some stats.
#' @details This function provides a friendly way to perform any kind of model in one line.
#' The model uses the inbuilt R functions aov and lm to make the predictions. If the target
#' is missing in the new data frame, the function will(currently) make an empty column and
#' fill this with predictions.
#' @references
#' Chambers, J. M. (1992) Linear models. Chapter 4 of Statistical Models in S eds J. M. Chambers and T. J. Hastie, Wadsworth & Brooks/Cole.
#'
#'Wilkinson, G. N. and Rogers, C. E. (1973). Symbolic descriptions of factorial models for analysis of variance. Applied
#'Statistics, 22, 392-399. doi: 10.2307/2346786.
#' @export 
modeleR<-function (df, yname, xname, modeltype, na.rm = FALSE,
                   new_data, ...)
{
  UseMethod("modeleR")
}
modeleR<-function (df, yname, xname, modeltype, na.rm = FALSE,
                   new_data, ...)
{
  .Deprecated("fit_model")
  # use fit_model
  yname <- deparse(substitute(yname))
  xname <- deparse(substitute(xname))
  to_use <- which(names(df) == yname)
  use_type <- class(df[, to_use])
  modeltype <- deparse(substitute(modeltype))
  formula1 <- as.formula(paste(yname, "~", xname))
  if (!yname %in% names(df)) {
    new_data$yname <- vector(use_type, nrow(new_data))
    names(new_data) <- gsub("yname", yname, names(new_data))
  }
  if (!modeltype %in% c("lm", "aov","glm"))
    stop("Model Type Not Suitable.")
  if (modeltype %in% c("lm","glm")) {
    lm.fit <- do.call(modeltype, list(data = quote(df), formula1,
                                      ...))
    m <- summary(lm.fit)
    stat_data <- m[[4]]
    if(modeltype=="glm"){
      df<-as.data.frame(sapply(m,"[[",1)[c(3,4,5,12,14,15,16)])
      df <- cbind(df, Explanatory = xname, Response = yname)
    new_names<-Map(function(x) gsub(" {1,},","",
                                paste0(toupper(substring(x,1,1)),
                                       substring(x,2,nchar(x)),collapse="")),
               names(df))
      names(df)<-NULL
      names(df)<-unlist(new_names)
    }
    else{
      df <- as.data.frame(sapply(m, "[[", 1)[c(3, 4, 8, 9,
                                               10)])
      df <- cbind(df, Explanatory = xname, Response = yname)
      names(df) <- gsub("^r", "R", names(df))
    }
    res <- list(DataFrame = df, Summary_data = m, Predictions = data.frame(Predictions = as.data.frame(predict(lm.fit,
                                                                                                               new_data))), Stats = stat_data)
    names(res$Predictions) <- c("Predicted")
    res$DataFrame$Explanatory <- gsub("\\+", "", res$DataFrame$Explanatory)
    res
  }
  else if (modeltype == "aov" & na.rm) {
    lm.fit <- do.call(modeltype, list(data = quote(df), formula1,
                                      ...))
    m <- summary(lm.fit)
    stat_data <- m[[1]][1]
    df <- as.data.frame(sapply(m, "["))
    df1 <- as.data.frame(unlist(df))
    names(df1) <- c("Value")
    rownames(df1) <- gsub("V1.", "", row.names(df1))
    df1 <- dplyr::as_tibble(df1)
    df1$Var <- rownames(df1)
    df1$Value = round(df1$Value, 3)
    df1 <- df1[, c("Var", "Value")]
    df1 <- na.omit(df1)
    res <- list(DataFrame = df, Summary_data = m, Predictions = data.frame(Predictions = as.data.frame(predict(lm.fit,
                                                                                                               new_data))), Stats = stat_data)
    names(res$Predictions) <- c("Predicted")
    res
  }
  else if (modeltype == "aov" & !na.rm) {
    lm.fit <- do.call(modeltype, list(data = quote(df), formula = formula1,
                                      ...))
    m <- summary(lm.fit)
    stat_data <- m[[1]][1]
    df <- as.data.frame(sapply(m, "["))
    df1 <- as.data.frame(unlist(df))
    names(df1) <- c("Value")
    rownames(df1) <- gsub("V1.", "", row.names(df1))
    df1 <- dplyr::as_tibble(df1)
    df1$Var <- rownames(df1)
    df1$Value = round(df1$Value, 3)
    df1[, c("Value", "Var")]
    res <- list(DataFrame = df, Summary_data = m, Predictions = data.frame(Predictions = as.data.frame(predict(lm.fit,
                                                                                                               new_data))), Stats = stat_data)
    names(res$Predictions) <- c("Predicted")
    res
  }
}

