#' Extract important model attributes
#' @description Provides a convenient way to extract any kind of model information from
#' common model objects
#' @importFrom stats coef
#' @param model_object A model object for example a linear model object, generalized linear model object,
#' analysis of variance object.
#' @param what character. The attribute you would like to obtain for instance p_value
#' @return An object with the requested model info.
#' @examples 
#' #fit a linear model
#' lm_model <- lm(Sepal.Length ~ Petal.Length, iris)
#' extract_model_info(lm_model, "p_value")
#' @export
extract_model_info <- function(model_object, what){
  UseMethod("extract_model_info")
}
#' @export
extract_model_info.default <- function(model_object, what){
  stop(paste0("Expecting a model object not an object of class",
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
possible_what <- c("df","ssq","f_value","p_value")
what <- match.arg(what, possible_what)
  switch (what,
          df = model_summary[[1]][1],
          ssq = model_summary[[1]][2],
          f_value = model_summary[[1]][3],
          p_value = model_summary[[1]][4]
          
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
