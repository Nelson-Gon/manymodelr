#' Extract important model attributes
#' @description Provides a convenient way to extract any kind of model information from
#' common model objects
#' @importFrom stats coef
#' @param model_object A model object for example a linear model object, generalized linear model object,
#' analysis of variance object.
#' @param what character. The attribute you would like to obtain for instance p_value
#' @details This provides a convenient way to extract model information for any kind of model. For linear models,
#' one can extract such attributes as coefficients, p value("p_value"), standard error("std_err"),
#' estimate, t value("t_value"), residuals.
#' For analysis of variance (aov), other attributes like sum sqaured(ssq),
#' mean squared error(msq), degrees of freedom(df),p_value. 
#' @examples 
#' # perform analysis of variance
#' aov_mod <- fit_model(iris, "Sepal.Length","Petal.Length + Species","aov")
#' extract_model_info(aov_mod, "ssq") 
#' # linear regression
#' lm_model <- fit_model(iris, "Sepal.Length","Petal.Length","lm")
#' extract_model_info(lm_model, "p_value") 
#' @export
extract_model_info <- function(model_object, what){
  UseMethod("extract_model_info")
}
#' @export
extract_model_info.default <- function(model_object, what){
  stop(paste0("Expecting a model object not an object of class ",
              class(model_object)))
}

#' @export
extract_model_info.lm <- function(model_object, what){
  model_summary <- summary(model_object)
  coeffs <- coef(model_summary)
  if(grepl("coef",what)){
    coeffs
  }
  else if(what %in%  c("p_value","std_err","t_value","estimate")){
    switch(what,
           p_value = coeffs[,4],
           std_err = coeffs[,2],
           estimate = coeffs[,1],
           t_value = coeffs[,3])
  }
  else{
    model_summary[[what]]
  }
  
}
#' @export

extract_model_info.aov <- function(model_object, what){
  model_summary <- summary(model_object)
  # possible what
possible_what <- c("df","ssq","msq","f_value","p_value")
what <- match.arg(what, possible_what)
  switch (what,
          df = model_summary[[1]][1],
          ssq = model_summary[[1]][2],
          msq = model_summary[[1]][3],
          f_value = model_summary[[1]][4],
          p_value = model_summary[[1]][5]
          
  )
}
extract_model_info.glm <- function(model_object, what){
model_summary <- summary(model_object)
what <- match.arg(what, c(names(model_summary),
                          c("p_value","std_err","t_value","estimate")))
coeffs <- coef(model_summary)
if(grepl("coef",what)){
  coeffs
}
else if(what %in%  c("p_value","std_err","t_value","estimate")){
  switch(what,
         p_value = coeffs[,4],
         std_err = coeffs[,2],
         estimate = coeffs[,1],
         t_value = coeffs[,3])
}
else{
model_summary[[what]]
}
}
#' @export
extract_model_info.lmerMod <- function(model_object, what){
  # Get summary
  model_summary <- summary(model_object)
possible_what <- match.arg(what,c("fixed_effects",
                                  "residuals",
                                  "log_lik",
                                  "random_groups","random_effects",
                                  "reml","formula"))
  switch(what,
         fixed_effects = model_summary[[10]],
         residuals = model_summary [[16]],
         log_lik =  model_summary[[6]],
         random_groups = model_summary [[9]],
         random_effects = Filter(Negate(anyNA),
              as.data.frame(model_summary[[13]])),
         reml = model_summary [[14]],
         formula = model_summary[[15]]
         
         )
}
