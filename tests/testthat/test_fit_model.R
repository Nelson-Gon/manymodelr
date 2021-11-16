test_that(desc="test fit_model",
                    code={
                      
skip_on_oldrel()
fit_many <- fit_models(df=yields,yname=c("height", 
 "weight"),
xname="yield",modeltype="lm") 
# check that model can be ran and results obtained
# fit an lm
lm_fit <-fit_model(yields,"height","weight","lm")
glm_fit <- fit_model(yields,"height","weight","glm")
total_attrs<-length(extract_model_info(lm_fit,
                   c("p_value","coeffs")))
                    
                      
expect_equal(total_attrs,2)
expect_true(inherits(lm_fit,"lm"))
expect_true(inherits(glm_fit,"glm"))
expect_equal(length(fit_many[[1]]),2)
      
expect_snapshot({
expect_error(fit_model(yields,"height","weight")) 
expect_error( fit_models(df=yields,yname=c("height"),
                           xname="width + yield",
                           modeltype="lm"))
  
})  

 

})


