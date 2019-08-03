library(manymodelr)
# expect error
testthat::test_that(desc = "agg_by_group test",
                    code={
      testthat::expect_error(agg_by_group(1:4),
                             "Don't know how to deal with an 
               object of class integer",
                             fixed=TRUE)
                    })




