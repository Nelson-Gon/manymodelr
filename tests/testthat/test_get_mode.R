library(manymodelr)
testthat::test_that(desc = "expect get_mode error",
                    code={
                testthat::expect_error(get_mode(iris$Species),
            "No implementation available for objects of class factor",
                      fixed=TRUE)
                    })

testthat::test_that(desc="test get_mode",
                    code={
                      
          test_vec <- c(1,1,1,2,2,3)
          test_chr <- c("Apples","Apples","Pineapples",
                        "Apples")
        testthat::expect_equal(get_mode(test_vec), 1)
        testthat::expect_equal(get_mode(test_chr),"Apples")
        
testthat::expect_warning(get_mode(iris),"factor columns converted to character",fixed=TRUE)
        
                    })



