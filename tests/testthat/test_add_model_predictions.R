testthat::test_that(desc="Test add_model_*",
                    code={
                      
                      iris1 <- iris[1:50,]
                      iris2 <- iris[51:100,]
                      lm_model <- fit_model(iris1,"Sepal.Length","Sepal.Width","lm") 
   testthat::expect_error(add_model_predictions(old_data = iris1,new_data = iris2),
                          "A model object must be provided.",
                          fixed=TRUE)
   
  testthat::expect_error(add_model_predictions(model = lm_model,old_data = iris1),
                         "Both old_data and new_data must be provided",
                         fixed=TRUE)      
  testthat::expect_error(add_model_predictions(model = lm_model,old_data = iris1,
                                               new_data = iris[1:5,]),
                         "old_data and new_data must have equal lengths.",
                         fixed=TRUE)   
  testthat::expect_error(add_model_residuals(iris1),
                         "Both model an old_data are required.",
                         fixed=TRUE)   
                      })