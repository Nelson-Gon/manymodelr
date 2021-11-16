# Test add_model_*

    Code
      expect_error(add_model_predictions(old_data = yields1, new_data = yields2))
      expect_error(add_model_predictions(model = lm_model, old_data = yields1))
      expect_error(add_model_predictions(model = lm_model, old_data = yields1))
      expect_error(add_model_residuals(yields1))

