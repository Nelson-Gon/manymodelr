test_that(desc="Tests that get_var_corr
                    returns a warning",
                    code={
                      
                        skip_on_oldrel()
    expect_snapshot(expect_warning(get_var_corr_(yields)))
    # Uses get_var_corr but we cannot just assume that it works.
    # Verify that things work as intended
    expect_true("upper_ci" %in% names(get_var_corr_(mtcars)))
    # Test method changes
    expect_false(any(c("upper_ci","lower_ci") %in% 
                                 names(get_var_corr_(mtcars,
                              method = "spearman", exact = FALSE))))
    # Expect length
    expect_true(length(names(get_var_corr_(mtcars,
                                  method = "kendall", exact = FALSE))) == 4)
    
    expect_equal(nrow(get_var_corr_(mtcars,
                  subset_cols = list(c("mpg","vs"),
                                     c("disp","wt")),
                  method="spearman",exact=FALSE)), 2)
                    })