# test fit_model
library(manymodelr)
test_that(desc="test fit_model",
                    code={
                      
                       skip_on_oldrel()
expect_error(fit_model(iris,"Sepal.Length","Petal.Length"),
                           "All arguments must be supplied.", fixed=TRUE)
   
    
      # check that model can be ran and results obtained
      # fit an lm
      lm_fit <-fit_model(iris,"Sepal.Length","Petal.Length","lm")
      glm_fit <- fit_model(iris,"Sepal.Length","Petal.Length","glm")
      total_attrs<-length(manymodelr::extract_model_info(lm_fit,
                                            c("p_value","coeffs")))
      
      expect_equal(total_attrs,2)
      expect_true(inherits(lm_fit,"lm"))
      expect_true(inherits(glm_fit,"glm"))
      
      # fit models
fit_many <- fit_models(df=iris,yname=c("Sepal.Length", "Sepal.Width"),
                       xname="Petal.Length + Petal.Width",
                       modeltype="lm")
   expect_error( fit_models(df=iris,yname=c("Sepal.Length"),
                            xname="Petal.Length + Petal.Width",
                            modeltype="lm"),
                 "fit_models is used for several yname, use fit_model for single predictors",
                 fixed =TRUE)
   expect_equal(length(fit_many[[1]]),2)
   
                    })


