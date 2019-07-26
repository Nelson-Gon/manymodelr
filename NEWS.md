---
title: "manymodelr-News"
author: "Nelson Gonzabato"
---

# manymodelr 0.2.3

**New functions**

1. `plot_corr` has been added to allow plotting of correlation matrices produced by `get_var_corr_`.

**Major Changes**

1. `modeleR` has been replaced with `fit_model` which is an easier to remember name. Usage remains the same.

2. `na_replace` has been extended to allow for user defined values. Grouping is not yet implemented. It may work with grouping functions(no guarantees, sorry!)

3. `rowdiff` now accepts replacement of the calculation induced `NA`s. It does so by using `na_replace`. 

4. `get_var_corr_` now supports using only a subset of the data. 


