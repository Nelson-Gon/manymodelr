# test fit_model

    Code
      expect_error(fit_model(yields, "height", "weight"))
      expect_error(fit_models(df = yields, yname = c("height"), xname = "width + yield",
      modeltype = "lm"))

