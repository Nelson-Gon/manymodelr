testthat::test_that(desc="Test that multi_model_1 works as intended",
                    code={
                      
                  ctrl <- trainControl(method="cv",number=5)    
                testthat::expect_error(multi_model_1(iris[1:120,],"Species",".",c("knn","svmRadial"),
                                                     "Accuracy",ctrl),
              "new_data,metric,method, and control must all be supplied",
              fixed=TRUE)
              
             
            # need both control and metric
            testthat::expect_error(multi_model_1(iris[1:120,],"Species",".",c("knn","svmRadial"),
                                                 metric=NULL,ctrl,new_data = iris[1:120,]),
                                   "new_data,metric,method, and control must all be supplied",
                                   fixed=TRUE)
            # need method
            testthat::expect_error(multi_model_1(iris[1:120,],"Species",".",method=NULL,
                                                 metric="Accuracy",ctrl,new_data = iris[1:120,]),
                                   "new_data,metric,method, and control must all be supplied",
                                   fixed=TRUE)
                    })