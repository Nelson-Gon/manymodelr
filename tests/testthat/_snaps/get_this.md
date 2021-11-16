# test get_this

    Code
      expect_error(get_this(yields, "non_existent"))
      expect_error(get_this(unnamed_list))
      expect_error(get_this(test_nested, what = "C"))

