---
title: "manymodelr-News"
author: "Nelson Gonzabato"
---
# manymodelr(development version)

# manymodelr 0.2.1

* `agg_by_group` is a new function that manipulates grouped data. It is fast and
   robust for many kinds of functions.

* `rowdiff` is another new function that enable one to find differences between rows
   in a `data.frame` object. 
  `
* `get_var_corr` provides a user-friendly way to find correlations between data.

* `get_data_Stats` now supports removal of missing data as well as using only numeric data.

* `modeleR` has been fixed to handle new data as expected. 

* `multi_model_1` now supports either validation or working with new data. The function explicitly needs newdata to be provided for now.

* `row_mean_na`  has been replaced with `na_replace` which is more robust. `row_mean_na` will be removed in future versions. 

* `get_this` provides a convenient way to `extract` data from `data.frame` objects of `lists`. It is intended to be helpful to extract metrics, predictions as might be necessary.



