#' Extract important model attributes
#' @description Provides a convenient way to extract any kind of model information from
#' common model objects
#' @importFrom stats coef residuals AIC
#' @param model_object A model object for example a linear model object, generalized linear model object,
#' analysis of variance object.
#' @param what character. The attribute you would like to obtain for instance p_value
#' @param ... Arguments to other functions eg AIC, BIC, deviance etc
#' @details This provides a convenient way to extract model information for any kind of model. For linear models,
#' one can extract such attributes as coefficients, p value("p_value"), standard error("std_err"),
#' estimate, t value("t_value"), residuals, aic and other known attributes.
#' For analysis of variance (aov), other attributes like sum sqaured(ssq),
#' mean squared error(msq), degrees of freedom(df),p_value. 
#' @examples 
#' # perform analysis of variance
#' aov_mod <- fit_model(iris, "Sepal.Length","Petal.Length + Species","aov")
#' extract_model_info(aov_mod, "ssq")
#' extract_model_info(aov_mod, c("ssq","predictors")) 
#' # linear regression
#' lm_model <- fit_model(iris, "Sepal.Length","Petal.Length","lm")
#' extract_model_info(lm_model,c("aic","bic"))
#' ## glm
#' glm_model <- fit_model(iris, "Sepal.Length","Petal.Length","lm")
#' extract_model_info(glm_model,"aic")
#' @export
extract_model_info <- function(model_object=NULL, what=NULL,...){
  UseMethod("extract_model_info")

}


extract_model_info.default<- function(model_object=NULL, what=NULL,...){

if(any(is.null(model_object), is.null(what))) stop("model_object and what are both required")
model_call <- model_object$call
model_formula <- gsub(".*=","",model_call)[2]
formula_build <- trimws(unlist(strsplit(model_formula,"~")))
predictor_var <- formula_build[2]
response_var <- formula_build[1]
model_summary <- summary(model_object)
model_attrs_list <- list(call=model_call,
                         aic = AIC(model_object,...), bic = stats::BIC(model_object,...),
                       log_lik= stats::logLik(model_object,...), deviance = stats::deviance(model_object,...),
                       df.resid= stats::df.residual(model_object,...),
                      coeffs = stats::coef(model_object,...) , predictors = predictor_var,
                      residuals = stats::residuals(model_object,...),
                      resids = stats::residuals(model_object,...),
                           response = response_var,
                      r2 = model_summary$r.squared,
                      adj_r2 = model_summary$adj.r.squared,
                      p_value = coef(model_summary)[,4])
  
  
  attrs_to_select<-match(what,names(model_attrs_list))
  
  if(length(what) == 1) model_attrs_list[[attrs_to_select]] else model_attrs_list[attrs_to_select]
}

#' @export

extract_model_info.lm <- extract_model_info.default




#' @export

extract_model_info.aov <- function(model_object=NULL, what=NULL,...){
  if(any(is.null(model_object), is.null(what))) stop("model_object and what are both required")

  model_summary <- summary(model_object)
possible_what <- c("coeffs","df","ssq","msq","f_value","p_value", "resids","aic","predictors","response",
                   "interactions","residuals")

if(any(! what %in% possible_what)) stop(paste0(c("what should be one of",possible_what), collapse=" "))


model_attrs_list<-list( coeffs = coef(model_object), df = model_summary[[1]][1], ssq = model_summary[[1]][2],
          msq = model_summary[[1]][3], f_value = model_summary[[1]][4],
          p_value = model_summary[[1]][5], resids = residuals(model_summary),
          residuals = residuals(model_summary), aic = extract_model_info.default(model_object,"aic"),
          predictors = extract_model_info.default(model_object,"predictors"),
          response = extract_model_info.default(model_object, "response"))

attrs_to_select <- match(what,names(model_attrs_list))

if(length(what)==1) model_attrs_list[[attrs_to_select]] else model_attrs_list[attrs_to_select]


}

#' @export
extract_model_info.glm <- extract_model_info.lm

#' @export
extract_model_info.lmerMod <- function(model_object=NULL, what=NULL,...){
if(any(is.null(model_object), is.null(what))) stop("model_object and what are both required")

model_summary <- summary(model_object)
possible_what <- c("fixed_effects","resids", "log_lik","random_groups","random_effects","reml","formula",
                                  "coefficients", "residuals")
if(any(! what %in% possible_what)) stop(paste0(c("what should be one of",possible_what), collapse=" "))

model_attrs_list <-list(fixed_effects = model_summary[[10]], resids = model_summary [[16]],
         residuals= extract_model_info.default(model_object,"resids"), 
         log_lik =  extract_model_info.default(model_object, "log_lik"),
         random_groups = model_summary [[9]],random_effects = Filter(Negate(anyNA),as.data.frame(model_summary[[13]])),
         reml = model_summary [[14]],formula = model_summary[[15]], coefficients = extract_model_info.default(model_object,"coeffs") )

attrs_to_select <- match(what, names(model_attrs_list))

if(length(what) ==1) model_attrs_list[[attrs_to_select]] else model_attrs_list[attrs_to_select]


}

#' @export

extract_model_info.glmerMod <- extract_model_info.lmerMod

#' @export

extract_model_info.glmmTMB <- extract_model_info.default