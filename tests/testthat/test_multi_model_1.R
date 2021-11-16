test_that(desc="Test that multi_model_1 works as intended",
                    code={
skip_on_oldrel()
set.seed(520)
train_set<-createDataPartition(yields$normal,
 p=0.8,list=FALSE)
valid_set<-yields[-train_set,]
train_set<-yields[train_set,]
ctrl<-trainControl(method="cv", number=5)
m<-multi_model_1(train_set,"normal",".",
                 c("knn","rpart"), "Accuracy",ctrl,new_data =valid_set)
# ensure that no value is null
expect_false(any(is.null(m$metric),is.null(m$predictions)))

expect_snapshot({
expect_error(multi_model_1(yields[1:120,],"normal",
                                           ".",c("knn","svmRadial"),
                                                     "Accuracy",ctrl))
# need both control and metric
 expect_error(multi_model_1(yields[1:120,],
                                       "normal",".",
                                       c("knn","svmRadial"),
                                                 metric=NULL,ctrl,
                                       new_data = yields[1:120,]))
expect_error(multi_model_1(yields[1:120,],
                                       "normal",".",method=NULL,
                                  metric="Accuracy",ctrl,
                                  new_data = yields[1:120,]))
})
 })