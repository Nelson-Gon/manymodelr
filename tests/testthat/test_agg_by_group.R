library(manymodelr)
# expect error
testthat::test_that(desc = "agg_by_group test",
                    code={
      testthat::expect_error(agg_by_group(1:4),
  "Don't know how to deal with an object of class integer",fixed=TRUE)
      
    testthat::expect_error(agg_by_group(iris),"You should provide a data.frame, formula, and a function.",fixed=TRUE)
    
    testthat::expect_equal(agg_by_group(iris,.~Species,length)[1,2],50)
    # ensure tow groups are identified
    call_func <- agg_by_group(iris,.~Species + Sepal.Length,length)
    # expect two groups
    testthat::expect_equal(length(attributes(call_func)$Groups),2)
                    })




