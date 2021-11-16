# extract_model_info works as expected

    Code
      expect_error(extract_model_info(lm_model))
      expect_error(extract_model_info(aov_model))
      expect_error(extract_model_info(aov_model, "nope"))
      expect_error(extract_model_info(fm2))
      expect_error(extract_model_info(fm2, "gibberish"))

