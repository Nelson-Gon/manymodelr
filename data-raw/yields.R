## code to prepare `yields` dataset goes here

set.seed(520)
# Create a simple dataset with a binary target
# Here normal is a fictional target where we assume that it meets
# some criterion means
yields <- data.frame(normal = rep(c("Yes", "No"), 500),
                          height=rnorm(100, mean=0.5, sd=0.2),
                          weight=runif(100,0, 0.6),
                          yield = rnorm(100, mean =520, sd = 10))

use_data(yields, overwrite = TRUE)
