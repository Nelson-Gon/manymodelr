# test fit_model
library(manymodelr)
testthat::test_that(desc="test fit_model",
                    code={
                      
          iris1<-iris[1:60,]
          iris2<-iris[60:nrow(iris),]
    testthat::expect_error(
            fit_model(iris1,Sepal.Length,Petal.Length,
                               anova,na.rm=TRUE,iris2),
        "Model Type Not Suitable.")
            
                    })


