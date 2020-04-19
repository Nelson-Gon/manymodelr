testthat::test_that(desc="Test that multi_model_1 works as intended",
                    code={
                      
                  ctrl <- trainControl(method="cv",number=5)    
                testthat::expect_error(multi_model_1(iris[1:120,],"Species",".",c("knn","svmRadial"),
                                                     "Accuracy",ctrl),
              "Please provide a data frame to perform validation or predict on unseen data.",
              fixed=TRUE)
              
              # yname does not exist
            testthat::expect_error(multi_model_1(iris[1:120,],"gibberish",".",c("knn","svmRadial"),
                                                           "Accuracy",ctrl,newdata = iris[1:120,]),
                          "yname should be a valid column name in the data set.",
                                             fixed=TRUE)
            # need both control and metric
            testthat::expect_error(multi_model_1(iris[1:120,],"Species",".",c("knn","svmRadial"),
                                                 metric=NULL,ctrl,newdata = iris[1:120,]),
                                   "Both metric and control must be supplied",
                                   fixed=TRUE)
            # need method
            testthat::expect_error(multi_model_1(iris[1:120,],"Species",".",method=NULL,
                                                 metric="Accuracy",ctrl,newdata = iris[1:120,]),
                                   "A method or vector of methods must be supplied.",
                                   fixed=TRUE)
                    })