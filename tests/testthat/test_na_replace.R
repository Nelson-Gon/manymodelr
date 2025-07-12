test_that(desc="NA replacement works",
                    code={

                      skip_on_oldrel()

                  test_data <- data.frame(ID=c("A","A",
                                               "B","B"),
                                          Val=c(1,2,2,NA))
             expect_equal(na_replace(test_data,
                             how="value",0)[4,2],
                             0)
             expect_equal(as.numeric(na_replace(test_data,
                                                how="get_mode")[4,2]),
                                     2)
             expect_equal(na_replace(df=test_data,how="ffill")[4,2],1)
             set.seed(123)
             expect_equal(na_replace(df=test_data,how="samples")[4,2],2)

            expect_error(na_replace(test_data))


                  })

test_that(desc="Test grouped replacement",
                    code={

              test_data <- data.frame(ID=c("A","A","A",
                                                   "B","B","B"),
                                              Val=c(1,NA,3,2,NA,5))
            expect_equal(na_replace_grouped(test_data,
                                                        group_by_cols = "ID",
                                                        how="get_mode")[2,2],
                                     1)
              expect_error(na_replace_grouped(test_data,
                                                        group_by_cols = "ID",
                                                        how="mean"))
                    })

