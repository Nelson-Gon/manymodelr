# exponential value

    Code
      expect_error(get_exponent(mtcars))
    Warning <simpleWarning>
      Replacing all numeric columns with their exponents inplace
    Code
      expect_error(get_exponent(2))
      expect_error(get_exponent(x = "no", y = 2))
      expect_warning(get_exponent(yields, 2))

