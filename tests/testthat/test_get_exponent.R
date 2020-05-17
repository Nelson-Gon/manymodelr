library(manymodelr)
test_that(desc = "exponential value",
                    code={
                      
                      
            expect_equal(get_exponent(12,3), 1728)
            expect_equal(get_exponent(2,5), 32)
            # expect errors from helpers
            expect_error(get_exponent(x="no",y=2),"Only numerics are supported", fixed=TRUE)
            expect_equal(get_exponent(mtcars,2)[1,1],441)
            
            expect_error(get_exponent(mtcars),"Both x and y should be supplied. Please see the docs for details",
                                   fixed=TRUE)
            
            expect_error(get_exponent(2),"Both x and y should be supplied. Please see the docs for details",
                                   fixed = TRUE)
            expect_warning(get_exponent(iris,2), "Replacing all numeric columns with their exponents inplace", fixed=TRUE)
            expect_equal(get_exponent(iris,2)[41, 1],25)
            
                    })

