---
title: "manymodelr-News"
author: "Nelson Gonzabato"
---

# manymodelr 0.2.3

**New functions**

1. `plot_corr` has been added to allow plotting of correlation matrices produced by `get_var_corr_`.

2. `na_replace_grouped` extends `na_replace` by allowing replacement of missing values(`NA`s) by group.

3. `add_model_predictions` allows addition of predicted values to  a data set.

4. `add_model_residuals` is an easy to use and `dplyr` compatible wrapper that allows addition of residuals to a data set.

5. `extract_model_info` allows easy extraction of common model attributes such as p values, residuals, coefficients, etc as per the specific model type.

**Major Changes**

1. `modeleR` has been replaced with `fit_model` which is an easier to remember name. Usage remains the same.

2. `fit_model` no longer allows direct addition of predictions. Use `add_model_predictions` to achieve the same.


3. `na_replace` has been extended to allow for user defined values.

4. `rowdiff` now accepts replacement of the calculation induced `NA`s. It does so by using `na_replace`. 

5. `get_var_corr_` now supports using only a subset of the data. 


