library(manymodelr)
testthat::test_that(desc = "exponential value",
                    code={
                      
                      
            testthat::expect_equal(get_exponent(12,3), 1728)
            testthat::expect_equal(get_exponent(2,5), 32)
            # expect errors from helpers
            testthat::expect_error(get_exponent(x="no",y=2),"Only numerics are supported", fixed=TRUE)
            testthat::expect_equal(get_exponent(mtcars,2)[1,1],441)
            
            testthat::expect_error(get_exponent(mtcars),"Both x and y should be supplied. Please see the docs for details",
                                   fixed=TRUE)
            
            testthat::expect_error(get_exponent(2),"Both x and y should be supplied. Please see the docs for details",
                                   fixed = TRUE)
                    })

