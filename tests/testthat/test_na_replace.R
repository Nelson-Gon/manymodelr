# Missing Value Replacement
library(manymodelr)
testthat::test_that(desc="NA replacement works",
                    code={
                      
                  test_data <- data.frame(ID=c("A","A",
                                               "B","B"),
                                          Val=c(1,NA,2,NA))
              testthat::expect_equal(na_replace(test_data,
                             how="value",0)[2,2],
                             0)
              testthat::expect_equal(as.numeric(na_replace(test_data,
                                                how="get_mode")[2,2]),
                                     1)
              
              
                    
                  })

testthat::test_that(desc="Test grouped replacement",
                    code={
                      
              test_data <- data.frame(ID=c("A","A","A",
                                                   "B","B","B"),
                                              Val=c(1,NA,3,2,NA,5))
              testthat::expect_equal(na_replace_grouped(test_data,
                                                        group_by_cols = "ID",
                                                        how="get_mode")[2,2],
                                     1)
              testthat::expect_error(na_replace_grouped(test_data,
                                                        group_by_cols = "ID",
                                                        how="mean"),
                                     "how should be one of ffill, samples, value or get_mode.",
                                     fixed = TRUE)
                    })

