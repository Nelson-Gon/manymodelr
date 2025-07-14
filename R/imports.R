#' @importFrom stats aggregate coef residuals AIC na.omit cor.test predict as.formula complete.cases setNames BIC logLik deviance df.residual
#' @importFrom lme4 lmer
#' @importFrom utils combn globalVariables packageVersion
#' @importFrom dplyr "%>%" arrange desc everything mutate summarise select pull filter group_by lead lag sym across tibble as_tibble
#' @importFrom stringr str_replace_all
#' @importFrom usethis use_data
#' @importFrom testthat test_that skip
#' @importFrom caret train trainControl confusionMatrix createDataPartition
#' @importFrom Metrics rmse accuracy auc mae se ae f1 sse rse rrse
#' @importFrom ggplot2 ggplot aes geom_point scale_color_gradient2 labs geom_tile scale_fill_gradient2 geom_text theme theme_minimal waiver aes_string element_text element_blank ggplot_build
NULL
