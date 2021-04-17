
test_that("Test rowdiff",
                    code={
  
                      skip_on_oldrel()
                      
  dummy_data <- data.frame(A=c(1,1,2,3), B=c(4,5,3,7))
  
  the_test <- rowdiff(dummy_data,
                      direction="reverse")[3,2]
 expect_equal(the_test, -2)
  
  another_test <- rowdiff(dummy_data, direction="forward")[3,2]
  expect_equal(another_test, -4)
  
 # Replace NAs frrom calculation
expect_equal(rowdiff(dummy_data, na.rm=TRUE,na_action = "value", value=0)[4,1],0)

expect_error(rowdiff(yields,direction = "gibberish"),
             "Only forward and reverse are supported", fixed=TRUE)

expect_equal(ncol(rowdiff(yields,exclude="factor")), 3)
})



