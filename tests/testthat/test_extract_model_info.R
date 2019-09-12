library(manymodelr)
testthat::test_that(desc= "extract_model_info works as expected",
                    code= {
            lm_model <- fit_model(iris, "Sepal.Length","Petal.Length","lm")
            # Still need to figure out the best way to expect an equal value
            # say p values, r2, etc.
            # for now:
            testthat::expect_equal(ncol(extract_model_info(lm_model,
                                                            "coeffs")),4)
              testthat::expect_error(extract_model_info(iris,
                                                        "p_value"),
                                     "Expecting a model object not an object of class data.frame",
                                     fixed = TRUE)        
                    })