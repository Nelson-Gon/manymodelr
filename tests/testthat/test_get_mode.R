test_that(desc = "expect get_mode error",
                    code={
                      skip_on_oldrel()
                expect_snapshot(expect_error(get_mode(yields$normal)))
                    })

test_that(desc="test get_mode",
                    code={
skip_on_oldrel()
test_vec <- c(1,1,1,2,2,3)
test_chr <- c("Apples","Apples","Pineapples",
                        "Apples")
expect_equal(get_mode(test_vec), 1)
expect_equal(get_mode(test_chr),"Apples")

expect_warning(get_mode(yields))
})



