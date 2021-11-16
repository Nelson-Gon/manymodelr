test_that(desc="Correlation tests",
                    code={
skip_on_oldrel()
test_data <- data.frame(A=rep(NA,12),B=rep(12,12))
# Test that when a user changes the method, it actually works.
# Expect that intervals exist if user uses default values(ie pearson)
expect_true("lower_ci" %in% names(get_var_corr(mtcars,"mpg")))
# Now switch things up, expect length 4
expect_true(length(names(get_var_corr(mtcars,"mpg",
            method = "spearman",exact = FALSE))) == 4)

expect_snapshot(
  {
    expect_error(get_var_corr(test_data,comparison_var = "A"))
    expect_error(get_var_corr(yields))
    
    expect_warning( get_var_corr(yields,"weight",
                                 drop_columns = c("factor"))) 
  }
)                

})
  
    




