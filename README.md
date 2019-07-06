# manymodelr(Development Version 0.2.1.9000)

**Tune and build several Machine Learning models.**

[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/manymodelr)](https://cran.r-project.org/package=manymodelr)
[![Build Status](https://travis-ci.org/Nelson-Gon/manymodelr.png?branch=master)](https://travis-ci.org/Nelson-Gon/manymodelr)
[![Rdoc](http://www.rdocumentation.org/badges/version/manymodelr)](http://www.rdocumentation.org/packages/manymodelr) 
[![license](https://img.shields.io/badge/license-GPL--2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html)
[![](https://cranlogs.r-pkg.org/badges/manymodelr)](https://cran.r-project.org/package=manymodelr)
[![TotalDownloads](http://cranlogs.r-pkg.org/badges/grand-total/manymodelr?color=yellow)](https://cran.r-project.org/package=manymodelr)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)

*  **Installing the package**

* **From CRAN**

```
install.packages("manymodelr")

```

* **From GitHub**

```
remotes::install_github("Nelson-Gon/manymodelr")
devtools::install_github("Nelson-Gon/manymodelr")
devtools::install_github("Nelson-Gon/manymodelr",build_vignettes=TRUE) #Builds vignettes
```

For the developer version please see [develop](https://github.com/Nelson-Gon/manymodelr/tree/develop). 



The developer version can be downloaded as follows

```

devtools::install_github("Nelson-Gon/manymodelr@develop")

devtools::install_github("Nelson-Gon/manymodelr@develop", build_vignettes=TRUE) #builds vignettes

```


* **Loading the package**

```

library(manymodelr)

```

**Example usage of major functions**

1.  `multi_model_1`

```
suppressMessages(library(caret))
train_set<-createDataPartition(iris$Species,p=0.8,list=FALSE)
valid_set<-iris[-train_set,]
train_set<-iris[train_set,]
ctrl<-trainControl(method="cv",number=5)
set.seed(233)
 m<-multi_model_1(train_set,"Species",".",c("knn","rpart"),
"Accuracy",ctrl,newdata =valid_set,valid=TRUE)

```

In the above we have trained and also got predictions(validated) on our data.

**Results:**

To get the metrics for all our models, we can  proceed as follows:

```
m$Metrics
# A tibble: 1 x 2
    knn rpart
  <dbl> <dbl>
1 0.933 0.967

```

To obtain the predicted values(validation in this case):

```
head(m$Predictions)
# A tibble: 6 x 2
  knn    rpart 
  <fct>  <fct> 
1 setosa setosa
2 setosa setosa
3 setosa setosa
4 setosa setosa
5 setosa setosa
6 setosa setosa

```

One can also get all the corresponding model statistics as follows:

```
m$modelInfo

``` 

2. `modeleR`

This provides a convenient way to build linear models, generalised linear models and carry out analysis of variance(currently). Example usage is as shown below:

```

iris1<-iris[1:60,]
iris2<-iris[60:nrow(iris),]
m1<-modeleR(iris1,Sepal.Length,Petal.Length,
        lm,na.rm=TRUE,iris2)

```

We can get the predicted values as shown below:

```
head(m1$Predictions)
 Predicted
60  5.985141
61  5.821972
62  6.107518
63  6.025933
64  6.311478
65  5.862764

```

3. `get_var_corr`

As can probably(hopefully) be guessed from the name, this provides a convenient way to get variable correlations. It enables one to get correlation between one variable and all other variables in the data set if `get_all` is set to `TRUE` or with specific variables if `get_all` is set to `FALSE`

Sample usage:

```
corrs <- get_var_corr(mtcars,comparison_var="mpg",
get_all=TRUE)

```

The result is as follows(default pearson):

```

head(corrs)

Comparison_Var Other_Var      p_value Correlation    lower_ci
1            mpg       cyl 6.112687e-10  -0.8521620 -0.92576936
2            mpg      disp 9.380327e-10  -0.8475514 -0.92335937
3            mpg        hp 1.787835e-07  -0.7761684 -0.88526861
4            mpg      drat 1.776240e-05   0.6811719  0.43604838
5            mpg        wt 1.293959e-10  -0.8676594 -0.93382641
6            mpg      qsec 1.708199e-02   0.4186840  0.08195487
    upper_ci
1 -0.7163171
2 -0.7081376
3 -0.5860994
4  0.8322010
5 -0.7440872
6  0.6696186


```

4. A closely related function is `get_var_corr_`(note the underscore) that enables enables one to obtain combination-wise correlations. Working with `mtcars`, we can do the following:

```
head(get_var_corr_(mtcars, method="kendall"))

```

The above gives us(**strictly kendall is used for demonstration purposes**):

```
Comparison_Var Other_Var      p.value Correlation    lower_ci
1            mpg       cyl 6.112687e-10  -0.8521620 -0.92576936
2            mpg      disp 9.380327e-10  -0.8475514 -0.92335937
3            mpg        hp 1.787835e-07  -0.7761684 -0.88526861
4            mpg      drat 1.776240e-05   0.6811719  0.43604838
5            mpg        wt 1.293959e-10  -0.8676594 -0.93382641
6            mpg      qsec 1.708199e-02   0.4186840  0.08195487
    upper_ci
1 -0.7163171
2 -0.7081376
3 -0.5860994
4  0.8322010
5 -0.7440872
6  0.6696186


```

5. `rowdiff`

If one needs to obtain differences between rows, `rowdiff` is designed to do exactly that.

```
head(rowdiff(iris,direction="reverse", exclude="non_numeric"))

```

This gives us the following result:

```
Sepal.Length Sepal.Width Petal.Length Petal.Width
1           NA          NA           NA          NA
2         -0.2        -0.5          0.0         0.0
3         -0.2         0.2         -0.1         0.0
4         -0.1        -0.1          0.2         0.0
5          0.4         0.5         -0.1         0.0
6          0.4         0.3          0.3         0.2

```

The `NA`s can simply be dealt with as necessary. An `NA` simply serves to show the direction in which the differences were performed. See the documentation for more details. 


Space constraints mean that a detailed exploration of the package cannot be made.  A more thorough walkthrough is provided in the vignettes that can be opened as shown below:

```
browseVignettes("manymodelr")

```


For previous users, please see the `NEWS.md` file for a list of changes and/or additions.  For a complete list of available functions, please use:
 
 ```
 
 help(package="manymodelr")
 
 ```
 
 > Thank You and Happy Coding!
 
