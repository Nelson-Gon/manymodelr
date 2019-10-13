#' Extract important model attributes
#' @description Provides a convenient way to extract any kind of model information from
#' common model objects
#' @importFrom stats coef residuals AIC
#' @param model_object A model object for example a linear model object, generalized linear model object,
#' analysis of variance object.
#' @param what character. The attribute you would like to obtain for instance p_value
#' @param ... For `glm` and `lm` "aic", additional arguments to `AIC` from `stats`. 
#' @details This provides a convenient way to extract model information for any kind of model. For linear models,
#' one can extract such attributes as coefficients, p value("p_value"), standard error("std_err"),
#' estimate, t value("t_value"), residuals, aic and other known attributes.
#' For analysis of variance (aov), other attributes like sum sqaured(ssq),
#' mean squared error(msq), degrees of freedom(df),p_value. 
#' @examples 
#' # perform analysis of variance
#' aov_mod <- fit_model(iris, "Sepal.Length","Petal.Length + Species","aov")
#' extract_model_info(aov_mod, "ssq") 
#' # linear regression
#' lm_model <- fit_model(iris, "Sepal.Length","Petal.Length","lm")
#' extract_model_info(lm_model, "p_value") 
#' extract_model_info(lm_model,"r2")
#' extract_model_info(lm_model,"aic",k=3)
#' ## glm
#' glm_model <- fit_model(iris, "Sepal.Length","Petal.Length","lm")
#' extract_model_info(glm_model,"p_value")
#' @export
extract_model_info <- function(model_object, what,...){
  UseMethod("extract_model_info")
}
#' @export
extract_model_info.default <- function(model_object, what,...){
  stop(paste0("Expecting a model object not an object of class ",
              class(model_object)))
}

#' @export
extract_model_info.lm <- function(model_object, what,...){
  

  model_summary <- summary(model_object)
  # should match args
  available_args <-  c("coeffs","p_value","resids",
                    "std_err","t_value","estimate",
                    "r2","adj_r2","rse","df", "f_stat",
                    "aic","terms","predictors","response",
                    "interactions")
  
  what <- match.arg(what, available_args)
  #available_args <- c(custom_vals,names(model_summary))
  # everything is accounted for AFAIK, negate the need to use the above

#if(! what %in% available_args){
 # stop("what should be one of ", paste0(available_args,
  #                                      collapse = ","))
  
#}
  
  coeffs <- coef(model_summary)
  aic_res <- AIC(model_object, ... )
  model_terms <- model_summary$terms
  response_var <- model_terms[[2]]
  predictor_var <- model_terms[[3]]
# Use predictor variables to get any interaction terms
# From language to character
predictor_var_as_char <- as.character(predictor_var)
# Find interacting terms
interacting_terms <- predictor_var_as_char[grep(":",predictor_var_as_char)]
# Turn them into plain English

interacting_terms <- gsub(":"," with ", interacting_terms)
 switch(what,
           coeffs = coeffs ,
           p_value = coeffs[,4],
           std_err = coeffs[,2],
           estimate = coeffs[,1],
           t_value = coeffs[,3],
           r2 = model_summary[["r.squared"]],
           adj_r2 = model_summary[["adj.r.squared"]],
           rse = model_summary$sigma,
           df = model_summary[[10]][2:3],
           f_stat = model_summary[[10]][[1]],
        resids = model_summary[[3]],
        aic = aic_res,
        terms = model_terms,
        predictors = predictor_var,
        response = response_var,
        interactions = interacting_terms)
 
  #else{
   # model_summary[[what]]
  #}
  
}
#' @export

extract_model_info.aov <- function(model_object, what,...){
  
  # Need to test that args are not null
  model_summary <- summary(model_object)
# possible arguments 
possible_what <- c("coeffs","df","ssq","msq","f_value","p_value",
                   "resids")
what <- match.arg(what, possible_what)
  switch (what,
          coeffs = coef(model_object),
          df = model_summary[[1]][1],
          ssq = model_summary[[1]][2],
          msq = model_summary[[1]][3],
          f_value = model_summary[[1]][4],
          p_value = model_summary[[1]][5],
          resids = residuals(model_summary)
          
  )
}

#' @export
extract_model_info.glm <- extract_model_info.lm

#' @export
extract_model_info.lmerMod <- function(model_object, what,...){
  # Get summary
  model_summary <- summary(model_object)
possible_what <- match.arg(what,c("fixed_effects",
                                  "resids",
                                  "log_lik",
                                  "random_groups","random_effects",
                                  "reml","formula"))
  switch(what,
         fixed_effects = model_summary[[10]],
         resids = model_summary [[16]],
         log_lik =  model_summary[[6]],
         random_groups = model_summary [[9]],
         random_effects = Filter(Negate(anyNA),
              as.data.frame(model_summary[[13]])),
         reml = model_summary [[14]],
         formula = model_summary[[15]]
         
         )
}
