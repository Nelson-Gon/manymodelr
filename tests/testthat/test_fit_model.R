# test fit_model
library(manymodelr)
testthat::test_that(desc="test fit_model",
                    code={
                      
testthat::expect_error(fit_model(iris,"Sepal.Length","Petal.Length"),
                           "All arguments must be supplied.", fixed=TRUE)
   
    
      # check that model can be ran and results obtained
      # fit an lm
      lm_fit <-fit_model(iris,"Sepal.Length","Petal.Length","lm")
      glm_fit <- fit_model(iris,"Sepal.Length","Petal.Length","glm")
      total_attrs<-length(manymodelr::extract_model_info(lm_fit,
                                            c("p_value","coeffs")))
      
      testthat::expect_equal(total_attrs,2)
      testthat::expect_true(inherits(lm_fit,"lm"))
      testthat::expect_true(inherits(glm_fit,"glm"))
      
            
                    })


