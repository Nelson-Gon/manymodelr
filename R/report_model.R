#' Create a simplified report of a model's summary
#' @param model_object A model object
#' @param response_name Name of the response variable. Defaults to "Score".
#' @return A data.frame object showing a simple model report that includes the
#' effect of each predictor variable on the response.
#' @importFrom dplyr mutate select everything
#' @importFrom stringr str_replace_all
#' @examples
#' models<-fit_models(df=yields,yname=c("height","yield"),xname="weight",
#' modeltype=c("lm", "glm"))
#' report_model(models[[2]][[1]])
#' @export
report_model <- function(model_object = NULL,
                         response_name = "Score") {
  UseMethod("report_model")
}

#' @export

report_model.default <- function(model_object=NULL,
                                 response_name = "Score"){
  if(is.null(model_object)){
    stop("No model object was supplied. Please provide one.")
  }
  stop(paste0("We currently do not support reports for ",
              class(model_object), " objects, sorry!"))
}
#' @export
report_model.glm <- function(model_object = NULL,
                         response_name = "Score") {

  model_coeffs <- summary(model_object)$coefficients[, c(1, 4)]

  model_coeffs %>%
    data.frame() %>%
    mutate(Type = row.names(.)) %>%
    select(Type, everything()) -> model_coeffs
  row.names(model_coeffs) <- NULL
  names(model_coeffs)[3] <- "P_Value"
  model_coeffs %>%
    mutate(
      Exp_Estimate = ifelse(Type == "(Intercept)", exp(Estimate),
                            exp(Estimate)),
      Effect = ifelse(
        Type != "(Intercept)",
        ifelse(
          grepl("-", Estimate),
          paste0("-",
                 round(100 -
                         Exp_Estimate * 100, 2), "%"),
          paste0("+", round(Exp_Estimate * 100 -
                              100, 2), "%")
        ),
        round(Exp_Estimate, 2)
      ),
      Type = stringr::str_replace_all(
        Type,
        "^\\(.*",
        paste0("Estimated ",
               response_name,
               collapse = "")
      ))

      }
