library(manymodelr)
testthat::test_that(desc = "Test equal lengths",
                    code = {
                      
            testthat::expect_error(multi_model_2(iris[1:50,],iris[50:95,],
                                        "Sepal.Length","Petal.Length","lm"),
                                   "Both old_data and new_data must have the same lengths",
                                   fixed = TRUE)   
            testthat::expect_error(multi_model_2(iris[1:50,],iris[50:99,],
                                            "invalid_yname","Petal.Length",
                                            "lm"),
                "yname must be a valid column name in both datasets."
                ,
                          fixed = TRUE) 
                    })



