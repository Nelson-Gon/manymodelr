testthat::test_that(desc="Test add_model_*",
                    code={
                       
                       skip_on_oldrel()
                      
                      iris1 <- iris[1:50,]
                      iris2 <- iris[51:100,]
                      lm_model <- fit_model(iris1,"Sepal.Length","Sepal.Width","lm") 
  expect_error(add_model_predictions(old_data = iris1,new_data = iris2),"A model, old_data, and new_data must be provided",fixed=TRUE)
   
 expect_error(add_model_predictions(model = lm_model,old_data = iris1),"A model, old_data, and new_data must be provided",fixed=TRUE)      
 expect_error(add_model_predictions(model = lm_model,old_data = iris1,
                                               new_data = iris[1:5,]),"old_data and new_data must have equal lengths.",fixed=TRUE)   
 expect_error(add_model_residuals(iris1),"Both model and old_data are required.",fixed=TRUE) 
 expect_true("predicted" %in% names(add_model_predictions(lm_model,iris1,iris2)))
 expect_true("residuals" %in% names(add_model_residuals(lm_model, iris1)))
                      })