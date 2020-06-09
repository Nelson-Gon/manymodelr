library(manymodelr)
# Test that user sets valid column names.
test_that(desc= "column names are valid",
                    code =  {
                     
                      expect_error(plot_corr(mtcars, 
                                 show_which = "corr", 
                                 custom_cols =  c("blue","yellow","gray"),
                                   value_size = 12, 
                                 colour_by = "p_value",
                                   round_which =   "foo"),
                                 "round_which must exist in get_var_corr_(df)",
                                 fixed = TRUE)
             
              expect_warning(plot_corr(mtcars,colour_by = "p.value"),
                                       "Using colour_by for the legend title.",
                                       fixed=TRUE)
              expect_error(plot_corr(mtcars,plot_style = "box"),
                                     "plot_style must be one of circles or squares",
                                     fixed=TRUE)
full_plot<-plot_corr(mtcars,round_which = "correlation",decimals = 2, colour_by="correlation",
                     show_which = "corr",plot_style = "squares")
full_plot_1 <- plot_corr(mtcars,round_which = "correlation",decimals = 2, colour_by="correlation",
                         show_which = "signif",plot_style = "squares", legend_title="test")
expect_error(plot_corr(mtcars,round_which = "gibberish",decimals = 2, colour_by="correlation",
                       show_which = "corr",plot_style = "squares"), "round_which must exist in get_var_corr_(df)",
             fixed=TRUE)
expect_warning(plot_corr(mtcars,round_which = "correlation",decimals = 2, colour_by="correlation",
                         show_which = "corr",plot_style = "squares"), "Using colour_by for the legend title.", fixed=TRUE)
expect_true(inherits(full_plot,"ggplot"))
expect_true(inherits(full_plot_1,"ggplot"))
# check signif works as required
expect_true(all(unique(ggplot_build(full_plot_1)$data[[2]]$label) %in% c("***", "ns")))

expect_warning(plot_corr(mtcars,legend_title = "test"),"Using correlation in colour_by",
               fixed = TRUE)
                    })
