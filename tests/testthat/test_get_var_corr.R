# Correlation tests
library(manymodelr)
testthat::test_that(desc="Correlation tests",
                    code={
                      
      test_data <- data.frame(A=rep(NA,12),B=rep(12,12))
      
    testthat::expect_error(get_var_corr(test_data,
                  comparison_var = "A",
                   get_all = TRUE),
      "Cannot perform correlation tests on columns with only NAs. Please
         remove these or impute missing values with known methods. Alternatively, set use='complete.obs'
         to use complete observations. See details in help(get_var_corr)",
      fixed=TRUE)
    
    testthat::expect_warning( get_var_corr(iris,"Sepal.Length",
                                           drop_columns = TRUE),
                             "Non-numeric columns have been discarded. You
              can manually do this yourself by setting drop_columns
              to FALSE.",
                             fixed=TRUE)
    testthat::expect_warning(get_var_corr_(iris),
              "Factor columns were found in the data set, these have 
          been discarded.", 
              fixed=TRUE)
                    })


