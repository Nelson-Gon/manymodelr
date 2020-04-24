# Development Version 0.2.5.9000



[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/manymodelr)](https://cran.r-project.org/package=manymodelr)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3764309.svg)](https://doi.org/10.5281/zenodo.3764309)
[![Build Status](https://travis-ci.org/Nelson-Gon/manymodelr.png?branch=master)](https://travis-ci.org/Nelson-Gon/manymodelr)
[![R CMMDCheck](https://github.com/Nelson-Gon/manymodelr/workflows/R-CMD-check/badge.svg)](https://github.com/Nelson-Gon/manymodelr)
[![license](https://img.shields.io/badge/license-GPL--2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html)
[![Rdoc](http://www.rdocumentation.org/badges/version/manymodelr)](http://www.rdocumentation.org/packages/manymodelr) 
[![Downloads](https://cranlogs.r-pkg.org/badges/manymodelr)](https://cran.r-project.org/package=manymodelr)
[![TotalDownloads](http://cranlogs.r-pkg.org/badges/grand-total/manymodelr?color=yellow)](https://cran.r-project.org/package=manymodelr) 
[![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://www.tidyverse.org/lifecycle/#stable) 
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Nelson-Gon/manymodelr/graphs/commit-activity) 
[![Project Status](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) 
[![Codecov test coverage](https://codecov.io/gh/Nelson-Gon/manymodelr/branch/develop/graph/badge.svg)](https://codecov.io/gh/Nelson-Gon/manymodelr?branch=develop)
 [![GitHub last commit](https://img.shields.io/github/last-commit/Nelson-Gon/manymodelr.svg)](https://github.com/Nelson-Gon/manymodelr/commits/master)
[![GitHub issues](https://img.shields.io/github/issues/Nelson-Gon/manymodelr.svg)](https://GitHub.com/Nelson-Gon/manymodelr/issues/)
[![GitHub issues-closed](https://img.shields.io/github/issues-closed/Nelson-Gon/manymodelr.svg)](https://GitHub.com/Nelson-Gon/manymodelr/issues?q=is%3Aissue+is%3Aclosed)
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/Nelson-Gon/manymodelr.svg)](http://isitmaintained.com/project/Nelson-Gon/manymodelr "Average time to resolve an issue")
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)







*  **Installing the package**

* **From CRAN(0.2.4)**

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

To install the less stable dev version:


```
devtools::install_github("Nelson-Gon/manymodelr@develop")

```


For previous users, please see the `NEWS.md` [file](https://github.com/Nelson-Gon/manymodelr/blob/master/NEWS.md) for a list of changes and/or additions.  


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
1     1 0.933

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

2. A related function is `multi_model_2` that aims to allow fitting and prediction in the same function. This builds on top of other modeling functions meaning that it can work with any model from any package. For demonstration purposes, only linear models will be shown.

```
# fit a linear model and get predictions
head(multi_model_2(iris[1:50,],iris[50:99,],"Sepal.Length","Petal.Length","lm"))
 
 Sepal.Length Sepal.Width Petal.Length Petal.Width Species predicted
1          5.1         3.5          1.4         0.2  setosa  4.972378
2          4.9         3.0          1.4         0.2  setosa  6.761943
3          4.7         3.2          1.3         0.2  setosa  6.653485
4          4.6         3.1          1.5         0.2  setosa  6.870402
5          5.0         3.6          1.4         0.2  setosa  6.382339
6          5.4         3.9          1.7         0.4  setosa  6.707714

```

We can also fit a multilinear model as shown below:

```
head(multi_model_2(iris[1:50,],iris[50:99,],"Sepal.Length",
    "Petal.Length + Sepal.Width","lm"))
    
 Sepal.Length Sepal.Width Petal.Length Petal.Width Species predicted
1          5.1         3.5          1.4         0.2  setosa  4.902999
2          4.9         3.0          1.4         0.2  setosa  5.771541
3          4.7         3.2          1.3         0.2  setosa  5.714857
4          4.6         3.1          1.5         0.2  setosa  5.761483
5          5.0         3.6          1.4         0.2  setosa  4.972473
6          5.4         3.9          1.7         0.4  setosa  5.476232

```

As stated, the function can work with any model type and any package. However it uses a few other functions that have only been tested on models built with `lm`, `glm`, `aov`, `lme4`. 

3. `fit_model`

What if I just want to fit a model and not predict? `fit_model` does just that. It provides user friendly syntax and is more readable. Again you can build any model type.  Example usage is as shown below:

```

# Make some data
iris1 <- iris[1:50,]
iris2 <-iris[51:100,]
lm_model <- fit_model(iris1,"Sepal.Width","Sepal.Length", "lm")
aov_model <- fit_model(iris,"Sepal.Width","Species", "aov")

# Multilinear

mlm_model <- fit_model(iris1,"Sepal.Width","Sepal.Length + Petal.Length", "lm")

# glm
glm_model <- fit_model(iris1,"Sepal.Width","Sepal.Length", "glm")


```

To extract model attributes from the above models, we can use `extract_model_info` as shown below:

```
# extract coefficients
extract_model_info(lm_model, "coeffs")

          Estimate Std. Error   t value     Pr(>|t|)
(Intercept)  -0.5694327  0.5217119 -1.091470 2.805148e-01
Sepal.Length  0.7985283  0.1039651  7.680738 6.709843e-10

extract_model_info(lm_model, "p_value")

(Intercept) Sepal.Length 
2.805148e-01 6.709843e-10 

# get predictors
extract_model_info(lm_model,"predictors")

Sepal.Length

# get response variable
extract_model_info(lm_model,"response")
Sepal.Width

# glm
extract_model_info(glm_model, "aic")

[1] 9.800332

```

To get several values:

```
extract_model_info(lm_model,c("p_value","coeffs","predictors"))

$p_value
 (Intercept) Sepal.Length 
2.805148e-01 6.709843e-10 

$coeffs
               Estimate Std. Error   t value     Pr(>|t|)
(Intercept)  -0.5694327  0.5217119 -1.091470 2.805148e-01
Sepal.Length  0.7985283  0.1039651  7.680738 6.709843e-10

$predictors
Sepal.Length

```

To see currently supported model types, please see `help(extract_model_info)`. To request support for a given model, please file an issue at: [issues](https://www.github.com/Nelson-Gon/manymodelr/issues). Exploration of other available values is left to the user. 

4. `add_model_residuals` and `add_model_predictions` 

To add predictions or residuals to a data set, we can use `add_model_predictions` and `add_model_residuals` respectively.

```

head(add_model_predictions(lm_model, iris1, iris2))

   Sepal.Length Sepal.Width Petal.Length Petal.Width Species predicted
1          5.1         3.5          1.4         0.2  setosa  5.020265
2          4.9         3.0          1.4         0.2  setosa  4.541148
3          4.7         3.2          1.3         0.2  setosa  4.940413
4          4.6         3.1          1.5         0.2  setosa  3.822473
5          5.0         3.6          1.4         0.2  setosa  4.621001
6          5.4         3.9          1.7         0.4  setosa  3.982179


head(add_model_residuals(lm_model, iris1))

  Sepal.Length Sepal.Width Petal.Length Petal.Width Species   residuals
1          5.1         3.5          1.4         0.2  setosa -0.00306166
2          4.9         3.0          1.4         0.2  setosa -0.34335600
3          4.7         3.2          1.3         0.2  setosa  0.01634966
4          4.6         3.1          1.5         0.2  setosa -0.00379751
5          5.0         3.6          1.4         0.2  setosa  0.17679117
6          5.4         3.9          1.7         0.4  setosa  0.15737985

# dplyr compatible
#library(dplyr)
iris1 %>% 
add_model_predictions(model=lm_model, new_data = iris2) %>% 
head()

   Sepal.Length Sepal.Width Petal.Length Petal.Width Species predicted
1          5.1         3.5          1.4         0.2  setosa  5.020265
2          4.9         3.0          1.4         0.2  setosa  4.541148
3          4.7         3.2          1.3         0.2  setosa  4.940413
4          4.6         3.1          1.5         0.2  setosa  3.822473
5          5.0         3.6          1.4         0.2  setosa  4.621001
6          5.4         3.9          1.7         0.4  setosa  3.982179
```

5. `get_var_corr`

As can probably(hopefully) be guessed from the name, this provides a convenient way to get variable correlations. It enables one to get correlation between one variable and all other variables in the data set.

**Previously, one would set `get_all` to `TRUE` if they wanted to get correlations between all variables. This argument has been dropped in favor of simply supplying an optional `other_vars` vector if one does not want to get all correlations.** 

Sample usage:

```

# get all correlations
corrs <- get_var_corr(mtcars,comparison_var="mpg")


```

The result is as follows(default pearson):

```

head(corrs)

    comparison_Var other_Var      p_value  correlation    lower_ci   upper_ci
1            mpg       cyl   6.112687e-10  -0.8521620 -0.92576936 -0.7163171
2            mpg      disp   9.380327e-10  -0.8475514 -0.92335937 -0.7081376
3            mpg        hp   1.787835e-07  -0.7761684 -0.88526861 -0.5860994
4            mpg      drat   1.776240e-05   0.6811719  0.43604838  0.8322010
5            mpg        wt   1.293959e-10  -0.8676594 -0.93382641 -0.7440872
6            mpg      qsec   1.708199e-02   0.4186840  0.08195487  0.6696186


```

**Previously, one would also set `drop_columns` to `TRUE` if they wanted to drop factor columns.** Now, a user simply provides a character vector specifying which column types(classes) should be dropped. It defaults to `c("character","factor")`.

```
# purely demonstrative
get_var_corr(iris,"Sepal.Length",other_vars="Petal.Length",drop_columns= c("factor","character"), method="spearman", exact=FALSE)

#  comparison_Var    other_var      p.value   correlation
# 1   Sepal.Length Petal.Length 3.443087e-50   0.8818981

```


6. A closely related function is `get_var_corr_`(note the underscore) that enables finer control over which correlations to obtain with the ability to perform combination wise correlations. 


```
head(get_var_corr_(mtcars, method="spearman", exact=FALSE))

   comparison_var  other_var      p.value correlation
1            mpg       cyl 4.690287e-13  -0.9108013
2            mpg      disp 6.370336e-13  -0.9088824
3            mpg        hp 5.085969e-12  -0.8946646
4            mpg      drat 5.381347e-05   0.6514555
5            mpg        wt 1.487595e-11  -0.8864220
6            mpg      qsec 7.055765e-03   0.4669358

```

To use only a few columns, we specify a list of columns in  `subset_cols`:

```

head(get_var_corr_(mtcars, method="spearman", exact=FALSE, subset_cols=list(c("mpg","disp"),  c("wt","drat"))))
  
      comparison_Var  other_var      p.value  correlation
4             mpg      drat     5.381347e-05   0.6514555
5             mpg        wt    1.487595e-11  -0.8864220
21           disp      drat    1.613884e-05  -0.6835921
22           disp        wt    3.346362e-12   0.8977064


```

7. To plot the above, one can use `plot_corr` as shown below:

```

corrs <- get_var_corr_(iris)


plot_corr(corrs, round_values = TRUE, round_which = "correlation")


```

![Correlations Plot](https://imgur.com/biB23AD)

To show significance instead(ie based on `p values`), one can set `show_which` to "signif". The default is `show_which="corr"` which will display the correlations. 


```

plot_corr(corrs, x="other_var", y="comparison_var",show_which="signif")


```

![Signif plot](https://ibb.co/9VG4dH4)

You can explore more options via `help(plot_corr)` or `?plot_corr`. Since the function uses `ggplot2` backend, one can change themes by adding `theme` components to the plot. 

8. `rowdiff`

If one needs to obtain differences between rows, `rowdiff` is designed to do exactly that.


```

head(rowdiff(iris,direction="reverse", exclude="factor"))


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
head(rowdiff(mtcars,direction="reverse", na.rm=TRUE, na_action="value", value=0))

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
na_replace(test_data, how="get_mode")
  A B
1 1 1
2 2 3
3 1 4
4 1 1

```


The above is less useful since one might want to replace values by group. Using `na_replace_grouped`, one can achieve just that.

```

test_groups = data.frame(groups=c(1,1,1,2,2,2), values = c(2,NA,2,3,NA,3))

na_replace_grouped(test_groups,group_by="groups",how="get_mode")

 groups values
1      1      2
2      1      2
3      1      2
4      2      3
5      2      3
6      2      3

```
The use of `mean`,`sd`,etc is no longer supported. Use [mde](https://www.github.com/Nelson-Gon/mde) instead which is focused on missingness. 

Space constraints mean that a detailed exploration of the package cannot be made.  A more thorough walkthrough is provided in the vignettes that can be opened as shown below:

```

browseVignettes("manymodelr")


```


For a complete list of available functions, please use:
 
```
 
help(package="manymodelr")

 
```

---

Please note that the 'manymodelr' project is released with a
[Contributor Code of Conduct](.github/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.


 > Thank You and Happy Coding!
 
