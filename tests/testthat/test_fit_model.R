# test fit_model
library(manymodelr)
testthat::test_that(desc="test fit_model",
                    code={
                      
       testthat::expect_equal(
            class(fit_model(iris,"Sepal.Length","Petal.Length",
                               "aov"))[1],
        "aov", fixed = TRUE)
            
                    })


