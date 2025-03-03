test_that(desc = "exponential value",
                    code={

                      skip_on_oldrel()

            expect_equal(get_exponent(12,3), 1728)
            expect_equal(get_exponent(2,5), 32)
            expect_equal(ceiling(get_exponent(yields,2)[209, 4]),264939)
            expect_equal(get_exponent(mtcars,2)[1,1],441)
            # expect errors from helpers

expect_error(get_exponent(mtcars))
expect_error(get_exponent(2))
expect_error(get_exponent(x="no",y=2))
expect_warning(get_exponent(yields,2))



})

