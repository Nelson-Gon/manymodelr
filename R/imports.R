#' @importFrom stats aggregate stats coef residuals AIC na.omit cor.test
#' @importFrom lme4 lmer
#' @importFrom dplyr %>%
#' @importFrom utils combn globalVariables packageVersion
#' @importFrom dplyr "%>%" "arrange" "desc" "everything" "mutate" "summarise"
#' "select" "pull" "filter" "group_by" "lead" "lag" "sym" "across"  "tibble"
#'  "as_tibble"
#' @importFrom stats "as.formula"  "complete.cases" "setNames" "na.omit" "predict"
#' "AIC" "aggregate" "cor.test" "residuals" "BIC" "logLik" "deviance" "df.residual"
#' @importFrom stringr "str_replace_all"
#' @importFrom utils "combn" "globalVariables" "packageVersion"
#' @importFrom usethis "use_data"
#' @importFrom testthat "test_that" "skip"
#' @importFrom lme4 "lmer"
#' @importFrom caret "train"
# @import e1071   e1071 (>= 1.7.8)
#todo: allow override for more flexibility
#' @importFrom Metrics  "rmse" "accuracy" "auc" "mae" "se" "ae" "f1" "sse" "rse"
#' "rrse"
#' @importFrom ggplot2 "ggplot" "aes" "geom_point" "scale_color_gradient2" "labs"
#'  "geom_tile" "scale_fill_gradient2" "geom_text" "theme" "theme_minimal" "waiver"
#'  "aes_string" "element_text" "element_blank" "ggplot_build"
#' @importFrom dplyr mutate select everything
#' @importFrom stringr str_replace_all

