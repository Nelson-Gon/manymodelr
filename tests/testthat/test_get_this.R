# get_this
library(manymodelr)
testthat::test_that(desc="test get_this",
                    code={
            testthat::expect_equal(get_this(Sepal.Wid,iris)[1,],
                                   3.5)
                    })