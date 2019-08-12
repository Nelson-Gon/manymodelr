library(manymodelr)
testthat::test_that(desc = "exponential value",
                    code={
                      
           # Test get_exponent
            result <- get_exponent(2,3)
            another_res <- get_exponent(12,3)
            testthat::expect_equal(result$Res, 8)
            testthat::expect_equal(another_res$Res, 1728)
                    })

