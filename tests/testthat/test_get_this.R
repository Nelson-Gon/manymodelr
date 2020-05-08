# get_this
library(manymodelr)
testthat::test_that(desc="test get_this",
                    code={
            testthat::expect_equal(get_this(iris,"Sepal.Width")[1,],
                                   3.5)
            # expect that unnamed lists throw an error as required
                      unnamed_list <- list(1:5,1:4)
                
              
              testthat::expect_equal(get_this(unnamed_list,2)[[1]][2],2)
              testthat::expect_error(get_this(unnamed_list),"Both what and where are required", fixed=TRUE)
              named_list <- list(A=1:4,B=7:10)
              testthat::expect_equal(get_this(named_list, "A")[[1]][3],3)
              testthat::expect_true(is.data.frame(get_this(iris,"Species")))
                    })