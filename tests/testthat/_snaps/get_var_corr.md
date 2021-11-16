# Correlation tests

    Code
      expect_error(get_var_corr(test_data, comparison_var = "A"))
      expect_error(get_var_corr(yields))
      expect_warning(get_var_corr(yields, "weight", drop_columns = c("factor")))

