test_that(desc="test get_this",
                    code={
                      skip_on_oldrel()
            expect_equal(ceiling(get_this(yields,"yield")[1, ]),
                         521)
            # expect that unnamed lists throw an error as required
            unnamed_list <- list(1:5,1:4)
            test_nested =list(A=list(A=1:3),B=list(B=1:4))
            named_list <- list(A=1:4,B=7:10)
            expect_equal(get_this(unnamed_list,2)[[1]][2],2)
            expect_equal(length(get_this(test_nested,"A")[[1]]),3)
            expect_equal(get_this(named_list, "A")[[1]][3],3)
            expect_true(is.data.frame(get_this(yields,"normal")))
            expect_snapshot({
              expect_error(get_this(yields,
                                    "non_existent"))  
              expect_error(get_this(unnamed_list))
              expect_error(get_this(test_nested,what="C"))
            }
              
            )
})