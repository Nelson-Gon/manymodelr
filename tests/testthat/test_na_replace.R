# Missing Value Replacement
library(manymodelr)
testthat::test_that(desc="NA replacement works",
                    code={
                      
                  test_data <- data.frame(ID=c("A","A",
                                               "B","B"),
                                          Val=c(1,NA,2,NA),
                                          stringsAsFactors = FALSE)
              testthat::expect_equal(na_replace(test_data,
                             how="value","Replaced")[2,2],
                             "Replaced",
                             fixed= TRUE)
              testthat::expect_equal(as.numeric(na_replace(test_data,
                                                how="max")[2,2]),
                                     2)
              
              
                    
                  })

testthat::test_that(desc="Test grouped replacement",
                    code={
                      
              test_data <- data.frame(ID=c("A","A","A",
                                                   "B","B","B"),
                                              Val=c(1,NA,3,2,NA,5),
                                              stringsAsFactors = FALSE)
              testthat::expect_equal(na_replace_grouped(test_data,
                                                        group_by_cols = "ID",
                                                        how="mean")[2,2],
                                     2)
              testthat::expect_equal(na_replace_grouped(test_data,
                                                        group_by_cols = "ID",
                                                        how="mean")[5,2],
                                     3.5)
                    })

