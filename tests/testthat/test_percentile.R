test_that(desc="Test percentile selection",
                    code={
                      skip_on_oldrel()
        expect_error(select_percentile(yields),
                     "Must provide both df and percentile.",
                               fixed=TRUE) 
        expect_true(ceiling(select_percentile(df=yields,
                                percentile = 20,descend=TRUE)[[3]])==1)
        expect_true(select_percentile(yields,20)[[1]]=="Yes")
                      
                    })


