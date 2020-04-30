library(manymodelr)
# Test that user sets valid column names.
testthat::test_that(desc= "column names are valid",
                    code =  {
                     
                      testthat::expect_error(plot_corr(mtcars, 
                                 show_which = "corr", 
                                 custom_cols =  c("blue","yellow","gray"),
                                   value_size = 12, 
                                 colour_by = "p_value",
                                   round_which =   "foo"),
                                 "round_which and colour_by must be valid column names.",
                                 fixed = TRUE)
              testthat::expect_error(plot_corr(mtcars, show_which = "corr", 
                                    custom_cols = c("blue","yellow","gray"),
                                               value_size = 12,
                                               colour_by = "bar"),
                        "round_which and colour_by must be valid column names.",
                        fixed = TRUE)
              testthat::expect_warning(plot_corr(mtcars,colour_by = "p.value"),
                                       "Using colour_by for the legend title.",
                                       fixed=TRUE)
              testthat::expect_error(plot_corr(mtcars,plot_style = "box"),
                                     "plot_style must be one of circles or squares",
                                     fixed=TRUE)
                    })
