test_that(desc="Test column selection",
                    code = {
                    
                      skip_on_oldrel()
                  expect_equal(ncol(select_col(iris,Species)),1)
                  expect_equal(ncol(select_col(iris,Species,Sepal.Length)),2)
                      
                    })