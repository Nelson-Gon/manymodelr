# test fit_model
library(manymodelr)
testthat::test_that(desc="test fit_model",
                    code={
                      
testthat::expect_error(fit_model(iris,"Sepal.Length","Petal.Length"),
                           "All arguments must be supplied.", fixed=TRUE)
    testthat::expect_equal(
      class(fit_model(iris,"Sepal.Length","Petal.Length","lm")),"lm")
  
      testthat::expect_equal(class(fit_model(iris,"Sepal.Width","Petal.Length","glm"))[[1]],
                           "glm")
            
                    })


