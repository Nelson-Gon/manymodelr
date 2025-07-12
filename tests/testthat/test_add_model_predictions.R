test_that(desc = "Test add_model_*",

                    code = {
                      skip_on_oldrel()

                      yields1 <- yields[1:50, ]
                      yields2 <- yields[51:100, ]
                      lm_model <- fit_model(yields1,
                                            "weight", "height", "lm")
         expect_snapshot({
        expect_error(add_model_predictions(old_data = yields1,
                new_data = yields2))

              expect_error(add_model_predictions(model = lm_model,
                                               old_data = yields1))

              expect_error(add_model_predictions(model = lm_model,
                                                 old_data = yields1))
              expect_error(add_model_residuals(yields1))



                      })
         expect_true("predicted" %in% names(add_model_predictions(lm_model, yields1,
                                                                  yields2)))
         expect_true("residuals" %in% names(add_model_residuals(lm_model,

                                                                yields1)))
                    })













