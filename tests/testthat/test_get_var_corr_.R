#' Test that get_var_corr_ returns a warning
library(manymodelr)
testthat::test_that(desc="Tests that get_var_corr
                    returns a warning",
                    code={
                      
    testthat::expect_warning(get_var_corr_(iris),
           "Factor columns were found in the data set, these have 
          been discarded.", fixed = TRUE)
                    })