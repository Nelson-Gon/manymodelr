# Test equal lengths

    Code
      expect_error(multi_model_2(yields[1:50, ], yields[50:95, ], "height", "weight",
      "lm"), )
      expect_error(multi_model_2(yields[1:50, ], yields[50:99, ], "invalid_yname",
      "height", "lm"))

