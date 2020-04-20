testthat::test_that(desc="Test column selection",
                    code = {
                    
                      
                  testthat::expect_equal(ncol(select_col(iris,Species)),1)
                  testthat::expect_equal(ncol(select_col(iris,Species,Sepal.Length)),2)
                      
                    })