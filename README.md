# manymodelr

**This branch read-only. For the developer version, please see: [develop](https://github.com/Nelson-Gon/manymodelr/tree/develop).**

**Build and Tune Several Machine Learning models.**

[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/manymodelr)](https://cran.r-project.org/package=manymodelr)
[![Build Status](https://travis-ci.org/Nelson-Gon/manymodelr.png?branch=master)](https://travis-ci.org/Nelson-Gon/manymodelr)
[![Rdoc](http://www.rdocumentation.org/badges/version/manymodelr)](http://www.rdocumentation.org/packages/manymodelr) 
[![license](https://img.shields.io/badge/license-GPL--2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html)
[![](https://cranlogs.r-pkg.org/badges/manymodelr)](https://cran.r-project.org/package=manymodelr)
[![TotalDownloads](http://cranlogs.r-pkg.org/badges/grand-total/manymodelr?color=yellow)](https://cran.r-project.org/package=manymodelr)

## **Installing the package**

* **Installing from CRAN**
```

install.packages("manymodelr")

```

* **Installing from GitHub**

```
remotes::install_github("Nelson-Gon/manymodelr")
devtools::install_github("Nelson-Gon/manymodelr")
```


### **Loading the package**

`library(manymodelr)`

#### **What's in this version of the package?**

The aim of this package is to build on `caret`'s powerful machine learning algorithms while leveraging user convenience and `tidyverse` like syntax. To this end, the author has developed a number of convenience functions that make it easy to build and tune machine learning algorithms in one go. 

##### **Key functions in this version**

* **1.** `modeleR`
   
   This function is useful if one would like to fit linear models or perform analysis of variance(currently). The function allows one to predict within the same function by providing new data for which predictions are needed.  
   
  *Sample usage*
 
 ```
  iris1<-iris[1:60,]
iris2<-iris[60:nrow(iris),]
m1<-modeleR(iris1,Sepal.Length,Petal.Length,
        lm,na.rm=TRUE,iris2)
   
  ```

Three objects are returned. A `data.frame` object containing stats:

```
m1$DataFrame
  Residuals coefficients R.squared adj.r.squared fstatistic  Explanatory     Response
1  0.134664     4.394245 0.5920943     0.5850615   84.18974 Petal.Length Sepal.Length

```

Summary stats:

```
m1$Summary_data

```

Predictions:

```
head(m1$Predictions)
  predict.lm.fit.
1        4.965336
2        4.965336
3        4.924544
4        5.006128
5        4.965336
6        5.087713

```

* **2** `multi_model_1`

This is the core function of this package and it aims to enable one perform several kinds of models in one function.
 
 *sample usage*

```
 library(caret)
train_set<-createDataPartition(iris$Species,p=0.8,list=FALSE)
valid_set<-iris[-train_set,]
train_set<-iris[train_set,]
ctrl<-trainControl(method="cv",number=5)
set.seed(233)
m<-multi_model_1(train_set,"Species",".",c("knn","rpart"),
                 "Accuracy",ctrl,newdata =valid_set)
```

In the above function, we have trained our model on two model types. The function returns a list continaing predictions and metrics as shown below.


```
m$Predictions
# A tibble: 30 x 2
   knn    rpart 
   <fct>  <fct> 
 1 setosa setosa
 2 setosa setosa
 3 setosa setosa
 4 setosa setosa
 5 setosa setosa
 6 setosa setosa
 7 setosa setosa
 8 setosa setosa
 9 setosa setosa
10 setosa setosa
# ... with 20 more rows

```

To get the metrics used:

```
m$Metrics
# A tibble: 1 x 2
    knn rpart
  <dbl> <dbl>
1 0.967 0.933

```

For more help, please see `?multi_model_1`.





**Other Convenience Functions**
These functions are mainly for convenience and may be removed in future versions of the package.

* **3**  `get_data_Stats`

As the name suggests, this function is useful for very fast data exploration, for instance if one wants to find the maximum,minimum,mode or any known summary stats. It is particularly useful once used together with `get_mode`

*sample usage*

`get_data_Stats(airquality,mean)`

![IMG](http://i67.tinypic.com/2sb6gyp.png)

```
library(dplyr)
mtcars %>%
  get_data_Stats(get_mode) %>% 
  ggplot2::ggplot(aes(variable,value,fill=variable))+geom_col()+
  theme_minimal()+
  ggtitle("Distribution of variables by mode")+
  theme(plot.title = element_text(hjust=0.5,color="steelblue3"))
  ```
  ![IMG](http://i68.tinypic.com/2qwkab5.png)
  
 Other functions in the package are mainly experimental and may also be removed in future versions. For a complete list of available functions, please use:
 
 `help(package="manymodelr")`
 
 Thank You and Happy Coding!
 
