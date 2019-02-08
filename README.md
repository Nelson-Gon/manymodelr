# manymodelr

**Tune and build several Machine learning models.**
 [![CRAN status](https://www.r-pkg.org/badges/version/manymodelr)](https://cran.r-project.org/package=manymodelr)
[![Build Status](https://travis-ci.org/Nelson-Gon/manymodelr.png?branch=master)](https://travis-ci.org/Nelson-Gon/manymodelr)

**Installing the package**

```
remotes::install_github("https://github.com/Nelson-Gon/manymodelr")
devtools::install_github("https://github.com/Nelson-Gon/manymodelr")
```

**Loading the package**
`library(manymodelr)`

**What's in this version of the package?**

The aim of this package is to build on `caret`'s powerful machine learning algorithms while leveraging user convenience and `tidyverse` like syntax. To this end, the author has developed a number of convenience functions that make it easy to build and tune machine learning algorithms in one go. 

**Key functions in this version**

**1.** `modeleR`
    This function is useful if one would like to fit linear models or perform analysis of variance(currently). 
   
  *Sample usage*
  
  `modeleR(iris,Sepal.Length,Petal.Length,lm,na.rm=T)`
  
  The above code allows one to simply provide arguments and receieve summary stats about the model. Currently, the model doesn't allow predictions although this has been fixed and is set for release in a patch update.
 
 Two objects are returned. A `data.frame` object containing stats:
 ![IMG](http://i67.tinypic.com/w9dyms.png)

The first list contains the dataframe showing sample stats while the second(truncated) showss summary stats for the model.

**2** `multi_model`
 This is the core function of this package and it aims to enable one perform any kinds of models in one function.
 
 *sample usage*
 ```
 library(caret)
ctrl<-trainControl(method="cv",number=5)
multi_model(iris,"Species",".",c("rf","svmRadial","knn"),"Accuracy",ctrl)
```
In the above function, we have trained our model on three model types. The results of this function(currently) are summary stats that aim to help one quickly judge which model does well on the given data.

![IMG](http://i67.tinypic.com/10h0cif.png)

From the above, one can easily conclude that prototype models perform best on this data. In this version of the package, that is all the function can do. However, the function has been extended in a developer version that will be released in future updates(patch).

**Other Convenience Functions**
These functions are mainly for convenience and may be removed in future versions of the package.

**3**  `get_data_Stats`

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
 
