test_that(desc = "Test equal lengths",
                    code = {
                      skip_on_oldrel()
            expect_error(multi_model_2(yields[1:50,],
                                       yields[50:95,],
                                        "height","weight",
                                       "lm"),
                    "Both old_data and new_data must have the same lengths",
                                   fixed = TRUE)   
            expect_error(multi_model_2(yields[1:50,],yields[50:99,],
                                            "invalid_yname","height",
                                            "lm"),
                "yname must be a valid column name in both datasets."
                ,
                          fixed = TRUE) 
            model_fit <- multi_model_2(yields[1:50,],
                                       yields[50:99,],
                                       "height","weight","glm")
            
            expect_true("predicted" %in% names(model_fit))
                    })



