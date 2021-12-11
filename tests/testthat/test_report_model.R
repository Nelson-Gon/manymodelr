test_that(desc = "Test model reports",
          code = {
            skip_on_oldrel()
            expect_snapshot(
              {
            expect_error(report_model("not_model_object")) 
            expect_error(report_model())
              }
            
            )
            # Create models   
            models<-fit_models(df=yields,yname=c("height","yield"),
                               xname="weight",
                               modeltype=c("lm", "glm"))
            glm_report<-report_model(models[[2]][[1]])
            expect_equal(ncol(glm_report), 5)
            expect_true(is.data.frame(glm_report))
          }
)