# manymodelr(Development Version 0.2.3.9000)

**Tune and build several Machine Learning models.**

[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/manymodelr)](https://cran.r-project.org/package=manymodelr)
[![Build Status](https://travis-ci.org/Nelson-Gon/manymodelr.png?branch=master)](https://travis-ci.org/Nelson-Gon/manymodelr)
[![Rdoc](http://www.rdocumentation.org/badges/version/manymodelr)](http://www.rdocumentation.org/packages/manymodelr) 
[![license](https://img.shields.io/badge/license-GPL--2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html)
[![](https://cranlogs.r-pkg.org/badges/manymodelr)](https://cran.r-project.org/package=manymodelr)
[![TotalDownloads](http://cranlogs.r-pkg.org/badges/grand-total/manymodelr?color=yellow)](https://cran.r-project.org/package=manymodelr)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)

*  **Installing the package**

* **From CRAN(0.2.2)**

```
install.packages("manymodelr")

```

* **From GitHub**

```
# development version(more stable)
remotes::install_github("Nelson-Gon/manymodelr")
devtools::install_github("Nelson-Gon/manymodelr")
devtools::install_github("Nelson-Gon/manymodelr",build_vignettes=TRUE) #Builds vignettes
```

For the current(unstable) developer version, please see [develop](https://www.github.com/Nelson-Gon/manymodelr/tree/develop).


* **Loading the package**

```

library(manymodelr)

```

**Example usage of major functions**

1.  `multi_model_1`

```
suppressMessages(library(caret))
set.seed(520)
train_set<-createDataPartition(iris$Species,p=0.8,list=FALSE)
valid_set<-iris[-train_set,]
train_set<-iris[train_set,]
ctrl<-trainControl(method="cv",number=5)

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

2. `fit_model`

This provides a convenient way to build linear models, generalised linear models and carry out analysis of variance(currently). Example usage is as shown below:

```

iris1<-iris[1:60,]
iris2<-iris[60:nrow(iris),]
m1<-fit_model(iris1,Sepal.Length,Petal.Length,
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

In case of data sets with factor columns, we can set `drop_columns` to `TRUE` as shown below.

```
# purely demonstrative
get_var_corr(iris,"Sepal.Length","Petal.Length",get_all = FALSE,drop_columns= TRUE, method="spearman", exact=FALSE)

#  Comparison_Var    Other_Var      p.value Correlation
# 1   Sepal.Length Petal.Length 3.443087e-50   0.8818981
```


4. A closely related function is `get_var_corr_`(note the underscore) that enables finer control over which correlations to obtain with the ability to perform combination wise correlations. To get correlations for `mpg` and `vs` "against" `cyl` and `displ`, one could do:

```
head(get_var_corr_(mtcars, method="spearman",
exact=FALSE))

  Comparison_Var Other_Var      p.value Correlation
1            mpg       cyl 4.690287e-13  -0.9108013
2            mpg      disp 6.370336e-13  -0.9088824
3            mpg        hp 5.085969e-12  -0.8946646
4            mpg      drat 5.381347e-05   0.6514555
5            mpg        wt 1.487595e-11  -0.8864220
6            mpg      qsec 7.055765e-03   0.4669358

```

To use only a few columns, we can set `subset_df` to `TRUE` and specify `subset_cols`:

```
head(get_var_corr_(mtcars, method="spearman",
exact=FALSE, subset_df=TRUE, subset_cols=list(c("mpg","disp"),
  c("wt","drat"))))
  
      Comparison_Var  Other_Var      p.value Correlation
4             mpg      drat     5.381347e-05   0.6514555
5             mpg        wt    1.487595e-11  -0.8864220
21           disp      drat    1.613884e-05  -0.6835921
22           disp        wt    3.346362e-12   0.8977064

```

5. To plot the above, one can use `plot_corr` as shown below:

```

corrs <- get_var_corr_(iris)

plot_corr(corrs)

```

![Correlations Plot](https://imgur.com/yCvrzH2)

6. `rowdiff`

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

To replace the calculation induced `NA`s, we can set `na.rm` to `TRUE` and specify `na_action`(uses `na_replace`).

```
# since reverse, first value is replaced with 0.
head(rowdiff(mtcars,direction="reverse", na.rm=TRUE,
na_action="value", value=0))

   mpg  cyl disp  hp  drat     wt  qsec vs am gear carb
1  0.0   0    0   0  0.00  0.000  0.00  0  0    0    0
2  0.0   0    0   0  0.00  0.255  0.56  0  0    0    0
3  1.8  -2  -52 -17 -0.05 -0.555  1.59  1  0    0   -3
4 -1.4   2  150  17 -0.77  0.895  0.83  0 -1   -1    0
5 -2.7   2  102  65  0.07  0.225 -2.42 -1  0    0    1
6 -0.6  -2 -135 -70 -0.39  0.020  3.20  1  0    0   -1


```

`na_replace` used above works as shown below.

```
test_data <- data.frame(A=c(1,2,NA,NA), B= c(1,3,4,NA))
# replace NAs with the mean of the non NA values
na_replace(test_data, how="mean")
    A        B
1 1.0 1.000000
2 2.0 3.000000
3 1.5 4.000000
4 1.5 2.666667

```

The above is less useful since one might want to replace values by group. Using `na_replace_grouped`, one can achieve just that.

```

test_groups = data.frame(groups=c(1,1,1,2,2,2), values = c(2,NA,2,3,NA,3))

na_replace_grouped(test_groups,group_by="groups",
how="mean")

    groups values
1      1      2
2      1      2
3      1      2
4      2      3
5      2      3
6      2      3

```

Space constraints mean that a detailed exploration of the package cannot be made.  A more thorough walkthrough is provided in the vignettes that can be opened as shown below:

```
browseVignettes("manymodelr")

```


For previous users, please see the `NEWS.md` [file](https://github.com/Nelson-Gon/manymodelr/blob/master/NEWS.md) for a list of changes and/or additions.  For a complete list of available functions, please use:
 
 ```
 
 help(package="manymodelr")
 
 ```
 
 > Thank You and Happy Coding!
 
