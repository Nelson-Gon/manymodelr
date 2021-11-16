# expect get_mode error

    Code
      expect_error(get_mode(yields$normal))

# test get_mode

    Code
      expect_warning(get_mode(yields))
    Warning <warning>
      Predicate functions must be wrapped in `where()`.
      
        # Bad
        data %>% select(is.factor)
      
        # Good
        data %>% select(where(is.factor))
      
      i Please update your code.
      This message is displayed once per session.

