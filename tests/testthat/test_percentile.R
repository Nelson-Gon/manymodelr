test_that(desc="Test percentile selection",
                    code={
                    
        expect_error(select_percentile(iris),"Must provide both df and percentile.",
                               fixed=TRUE) 
        expect_true(ceiling(select_percentile(df=iris,percentile = 25,descend=TRUE)[[1]])==8)
        expect_true(select_percentile(iris,25)[[5]]=="setosa")
                      
                    })