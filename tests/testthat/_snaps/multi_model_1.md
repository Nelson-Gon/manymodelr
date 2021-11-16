# Test that multi_model_1 works as intended

    Code
      expect_error(multi_model_1(yields[1:120, ], "normal", ".", c("knn", "svmRadial"),
      "Accuracy", ctrl))
      expect_error(multi_model_1(yields[1:120, ], "normal", ".", c("knn", "svmRadial"),
      metric = NULL, ctrl, new_data = yields[1:120, ]))
      expect_error(multi_model_1(yields[1:120, ], "normal", ".", method = NULL,
      metric = "Accuracy", ctrl, new_data = yields[1:120, ]))

