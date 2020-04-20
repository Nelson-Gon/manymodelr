testthat::test_that(desc="Test percentile selection",
                    code={
                    
        testthat::expect_error(select_percentile(iris),"Must provide both df and percentile.",
                               fixed=TRUE)              
                    })