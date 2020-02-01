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

5. `extract_model_info` allows easy extraction of common model attributes such as p values, residuals, coefficients, etc as per the specific model type. It supports extraction of multiple attributes. 

6. `multi_model_2` allows fitting and predicting in one function. It is similar to `multi_model_1` except it does not require metrics. 

**Major Changes**

1. `modeleR` has been replaced with `fit_model` which is an easier to remember name. Usage remains the same.

2. `fit_model` no longer allows direct addition of predictions. Use `add_model_predictions` to achieve the same.


3. `na_replace` has been extended to allow for user defined values.

4. `rowdiff` now accepts replacement of the calculation induced `NA`s. It does so by using `na_replace`. 

5. `get_var_corr_` now supports using only a subset of the data.

6. Helper functions are no longer exported. 

7. `get_data_Stats` is now aliased with `get_stats` for ease.

8. `get_var_corr` no longer has the `get_all` argument. Instead, users can provide an option `other_vars` vector of subset columns. `drop_columns` has also been changed from `boolean` to a character vector. 


# manymodelr 0.2.2

Minor bug fixes with respect to the vignette.


# manymodelr 0.2.1

**Major Changes**

**Additions**

1. `agg_by_group` is a new function that manipulates grouped data. It is fast and robust for many kinds of functions.

2. `rowdiff` is another new function that enable one to find differences between rows in a data.frame object. `

3. `get_var_corr` provides a user-friendly way to find correlations between data.

4. `get_var_corr_` provides a user-friendly way to find combination-wise correlations. It is relatively fast depending on how big one’s data is and/or machine specifications.

5. `get_this` is an easy to use helper function to get metrics,predictions, etc. Currently supports lists and data.frame objects.

**Major Modifications**

6. `get_data_Stats` now supports removal of missing data as well as using only numeric data.

7. `modeleR` has been fixed to handle new data as expected. It also now supports glm.

8. `multi_model_1` now supports either validation or working with new data.

9. `row_mean_na` has been replaced with na_replace which is more robust. `row_mean_na` will be removed in future versions.
