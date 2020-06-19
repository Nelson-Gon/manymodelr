# Correlation tests
library(manymodelr)
testthat::test_that(desc="Correlation tests",
                    code={
                      
                      skip_on_oldrel()
                      
      test_data <- data.frame(A=rep(NA,12),B=rep(12,12))
      
    testthat::expect_error(get_var_corr(test_data,comparison_var = "A"),
      "Found columns with only NAs. Please remove these first.",fixed=TRUE)
    testthat::expect_error(get_var_corr(iris),"comparison_var is required.", fixed=TRUE)
    
    testthat::expect_warning( get_var_corr(iris,"Sepal.Length",
                                           drop_columns = c("factor")),
                             "Columns with classes in drop_columns have been discarded. You
              can disable this by setting yourself by setting drop_columns
              to NULL.", fixed=TRUE)
  
    
    # Test that when a user changes the method, it actually works.
    # Expect that intervals exist if user uses default values(ie pearson)
    testthat::expect_true("lower_ci" %in% names(get_var_corr(mtcars,"mpg")))
    # Now switch things up, expect length 4
    testthat::expect_true(length(names(get_var_corr(mtcars,"mpg",
                                     method = "spearman",exact = FALSE))) == 4)
                    })



