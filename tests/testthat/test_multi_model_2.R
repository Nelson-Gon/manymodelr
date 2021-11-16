test_that(desc = "Test equal lengths",
                    code = {
                      skip_on_oldrel()
            expect_snapshot(
              {
                
              
            
            expect_error(multi_model_2(yields[1:50,],
                                       yields[50:95,],
                                        "height","weight",
                                       "lm"),)   
            expect_error(multi_model_2(yields[1:50,],yields[50:99,],
                                            "invalid_yname","height",
                                            "lm"))
              }
            )
            model_fit <- multi_model_2(yields[1:50,],
                                       yields[50:99,],
                                       "height","weight","glm")
            
            expect_true("predicted" %in% names(model_fit))
                    })



