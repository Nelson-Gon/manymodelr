test_that(desc="test get_data_Stats",
                    code={
                        
                        skip_on_oldrel()
    dummy_data <- data.frame(A=c(1,2,3,4,5))
    test_dummy_data <- get_stats(dummy_data,max)
    final_res <- unname(test_dummy_data)[1]
   
 expect_warning(get_stats(yields,max,exclude = "factor"),"Columns with classes in exclude have been discarded",fixed=TRUE)
 
 expect_error(get_stats(dummy_data),"Both df and func must be supplied",fixed=TRUE)

 expect_equal(final_res,5)
 expect_true(get_stats(airquality,func="min",na.rm = TRUE,
                       na_action = "value", value=0)[2]==0)
 expect_warning(get_stats(mtcars,"max",na.rm=TRUE,na_action = "get_mode"),
              "NA removal requested on data with no missing values", fixed=TRUE)
 
                    })



