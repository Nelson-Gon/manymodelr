---
title: "manymodelr's changelog"
author: "Nelson Gonzabato"
output: html_document
---

# manymodelr 0.3.8

* We now use `testthat` edition 3 which makes it easier to deal with warnings
and errors in a cleaner way. See https://github.com/r-lib/testthat/issues/1471,
https://github.com/Nelson-Gon/manymodelr/pull/22. 

# manymodelr 0.3.7 

* We no longer use any URLs in vignettes to avoid issues with CRAN checks. 

# manymodelr 0.3.6


* Updated all examples to use the new dataset, `yields`.

* Topic based vignettes are now available. 

* Added a new dataset `yields` that may be useful for testing purposes. 

* Fixed issues with `knitr` causing failing builds. 

* Updated docs with newer examples.

# manymodelr 0.3.5

* Extended `fit_models` to support model fitting for several variables for several model types. 

# manymodelr 0.3.2

* Patch related to failing tests on old R releases, skip tests on these. 

# manymodelr 0.3.1

* Fixed issues for CRAN

# manymodelr 0.3.0


**Major additions**


- **extract_model_info** now supports `glmerMod` and `glmmTMB`

- **get_this** now works with numeric input and also supports `data.frame` objects.

- **fit_models** extends **fit_model** by building many models at once.


**Other changes**

- `get_stats` now drops columns via a vector and not "non_numeric" as previously.

- Metrics from `multi_model_1` are now more informative with the metric and method wrapped in the naming of the result. 


- `df` was renamed as `old_data` in `multi_model_1`, `newdata` to `new_data`.


- `plot_corr` now directly accepts `data.frame` objects. Arguments like `round_values` have also been dropped.


- Fixed DOI to Max Kuhn's paper


- Refactored `get_mode` to be `tidy` compliant. 


- The argument `valid` was dropped in `multi_model_1`.


- `get_all` was dropped in `select_percentile`. 


- `select_col`, `select_percentile`, `row_mean_na` will be removed in the next release.


- `row_mean_na` is now defunct. Use `na_replace` instead.


- `na_replace` no longer allows using functions such as `mean`,`min`, etc. These have been reimplemented in the package [mde](https://github.com/Nelson-Gon/mde)


- `modeleR` is now defunct. Use `fit_model` instead.

- `get_this` no longer accepts non quoted character strings. 

- Better coverage and code tests


# manymodelr 0.2.4

Fixes paper citation

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

---


# manymodelr 0.2.2

Minor bug fixes with respect to the vignette.

---

# manymodelr 0.2.1

**Major Changes**

**Additions**

1. `agg_by_group` is a new function that manipulates grouped data. It is fast and robust for many kinds of functions.

2. `rowdiff` is another new function that enable one to find differences between rows in a data.frame object. `

3. `get_var_corr` provides a user-friendly way to find correlations between data.

4. `get_var_corr_` provides a user-friendly way to find combination-wise correlations. It is relatively fast depending on how big one's data is and/or machine specifications.

5. `get_this` is an easy to use helper function to get metrics,predictions, etc. Currently supports lists and data.frame objects.

6. `modeleR` and `row_mean_na` were removed. 

**Major Modifications**

6. `get_data_Stats` now supports removal of missing data as well as using only numeric data.

7. `modeleR` has been fixed to handle new data as expected. It also now supports glm.

8. `multi_model_1` now supports either validation or working with new data.

9. `row_mean_na` has been replaced with na_replace which is more robust. `row_mean_na` will be removed in future versions.
