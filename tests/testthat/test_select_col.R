test_that(desc="Test column selection",
                    code = {
                    
                      skip_on_oldrel()
                  expect_equal(ncol(select_col(yields, normal)),1)
                  expect_equal(ncol(select_col(yields,height, yield)),2)
                      
                    })