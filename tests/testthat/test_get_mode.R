library(manymodelr)
test_that(desc = "expect get_mode error",
                    code={
                      skip_on_oldrel()
                expect_error(get_mode(iris$Species),
            "No implementation available for objects of class factor",
                      fixed=TRUE)
                    })

test_that(desc="test get_mode",
                    code={
                      
                      skip_on_oldrel()
          test_vec <- c(1,1,1,2,2,3)
          test_chr <- c("Apples","Apples","Pineapples",
                        "Apples")
        expect_equal(get_mode(test_vec), 1)
        expect_equal(get_mode(test_chr),"Apples")
        
expect_warning(get_mode(iris),"factor columns converted to character",fixed=TRUE)
        
                    })



