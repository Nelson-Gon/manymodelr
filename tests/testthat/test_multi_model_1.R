testthat::test_that(desc="Test that multi_model_1 works as intended",
                    code={
                      set.seed(520)
                      train_set<-createDataPartition(iris$Species,p=0.8,list=FALSE)
                      valid_set<-iris[-train_set,]
                      train_set<-iris[train_set,]
                      ctrl<-trainControl(method="cv",number=5)
                      m<-multi_model_1(train_set,"Species",".",c("knn","rpart"), "Accuracy",ctrl,new_data =valid_set)
                       
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
            # ensure that no value is null
            testthat::expect_false(any(is.null(m$metric),is.null(m$predictions)))
                    })