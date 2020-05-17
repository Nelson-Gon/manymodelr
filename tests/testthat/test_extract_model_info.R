test_that(desc= "extract_model_info works as expected",
                    code= {
            lm_model <- fit_model(iris, "Sepal.Length","Petal.Length","lm")
            aov_model <- fit_model(iris, "Sepal.Length","Petal.Length","aov")
            # Still need to figure out the best way to expect an equal value
            # say p values, r2, etc.
            # for now:
          expect_error(extract_model_info(lm_model), "model_object and what are both required", fixed= TRUE)
          expect_error(extract_model_info(aov_model), "model_object and what are both required", fixed= TRUE)
          expect_equal(nrow(extract_model_info(aov_model,"msq")), 2)
          expect_error(extract_model_info(aov_model,"nope"),
          "what should be one of coeffs df ssq msq f_value p_value resids aic predictors response interactions residuals",
          fixed=TRUE)
          expect_equal(extract_model_info(aov_model,"predictors"), "Petal.Length")
          expect_type(extract_model_info(lm_model,"resids"),"double")
          expect_type(extract_model_info(lm_model,"residuals"),"double")
        
              
                    })