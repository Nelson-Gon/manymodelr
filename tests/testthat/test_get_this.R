# get_this
library(manymodelr)
test_that(desc="test get_this",
                    code={
            expect_equal(get_this(iris,"Sepal.Width")[1,],
                                   3.5)
            # expect that unnamed lists throw an error as required
                      unnamed_list <- list(1:5,1:4)
              expect_error(get_this(iris,"non_existent"),"what should be a valid name in where. Perhaps you have an unnamed list?",
                                     fixed=TRUE)  
              
              expect_equal(get_this(unnamed_list,2)[[1]][2],2)
              expect_error(get_this(unnamed_list),"Both what and where are required", fixed=TRUE)
              named_list <- list(A=1:4,B=7:10)
              expect_equal(get_this(named_list, "A")[[1]][3],3)
              expect_true(is.data.frame(get_this(iris,"Species")))
              
              test_nested =list(A=list(A=1:3),B=list(B=1:4))
             expect_error(get_this(test_nested,what="C"),
                          "what should be a valid name in where. Perhaps you have an unnamed list?",
                          fixed = TRUE)
             expect_equal(length(get_this(test_nested,"A")[[1]]),3)
             
              })