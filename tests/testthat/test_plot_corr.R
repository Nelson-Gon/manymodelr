library(manymodelr)
# Test that user sets valid column names.
testthat::test_that(desc= "column names are valid",
                    code =  {
                      res <- get_var_corr_(mtcars)
                      testthat::expect_error(plot_corr(res, 
                                 show_which = "corr", 
                                 custom_cols =  c("blue","yellow","gray"),
                                   value_size = 12, 
                                   round_which =   "foo"),
                                 "round_which must be a valid column name.",
                                 fixed = TRUE)
              testthat::expect_error(plot_corr(res, show_which = "corr", 
                                    custom_cols = c("blue","yellow","gray"),
                                               value_size = 12,
                                               colour_by = "bar"),
                        "bar is not a valid column name in the data",
                        fixed = TRUE)
                    })
