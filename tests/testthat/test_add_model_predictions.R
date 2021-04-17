testthat::test_that(desc="Test add_model_*",
                    code={
                       
                       skip_on_oldrel()
                      
                      yields1 <- yields[1:50,]
                      yields2 <- yields[51:100,]
                      lm_model <- fit_model(yields1,
                                            "weight","height","lm") 
  expect_error(add_model_predictions(old_data = yields1,new_data = yields2),
               "A model, old_data, and new_data must be provided",fixed=TRUE)
   
 expect_error(add_model_predictions(model = lm_model,
                                    old_data = yields1),
              "A model, old_data, and new_data must be provided",fixed=TRUE)      
 expect_error(add_model_predictions(model = lm_model,old_data = yields1,
                                               new_data = yields[1:5,]),
              "old_data and new_data must have equal lengths.",fixed=TRUE)   
 expect_error(add_model_residuals(yields1),"Both model and old_data are required.",
              fixed=TRUE) 
 expect_true("predicted" %in% names(add_model_predictions(lm_model,yields1,
                                                          yields2)))
 expect_true("residuals" %in% names(add_model_residuals(lm_model, yields1)))
                      })