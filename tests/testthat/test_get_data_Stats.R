library(manymodelr)
# Tests error
testthat::test_that(desc="test get_data_Stats",
                    code={
    dummy_data <- data.frame(A=c(1,2,3,4,5))
    test_dummy_data <- get_data_Stats(dummy_data,max)
    final_res <- unname(test_dummy_data)[1]
    testthat::expect_error(get_data_Stats(as.matrix(iris),max),
              "get_data_Stats is only implemented(currently) for
       data.frame objects. Please convert to a data.frame object.",
              fixed = TRUE)
    testthat::expect_warning(get_data_Stats(iris,max,
                                  exclude = "non_numeric"),
                             "Non numeric columns have been discarded.")
    testthat::expect_equal(final_res,5)
    
                    })



