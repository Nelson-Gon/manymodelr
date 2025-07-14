library(manymodelr)
# Test that user sets valid column names.
test_that(desc = "column names are valid",
          code =  {
            skip_on_oldrel()

            expect_error(
              plot_corr(
                mtcars,
                show_which = "corr",
                custom_cols =  c("blue", "yellow", "gray"),
                value_size = 12,
                colour_by = "p_value",
                round_which =   "foo"
              )
            )

            expect_warning(plot_corr(mtcars, colour_by = "p.value"))
            expect_error(plot_corr(mtcars, plot_style = "box"))
            full_plot <-
              plot_corr(
                mtcars,
                round_which = "correlation",
                decimals = 2,
                colour_by = "correlation",
                show_which = "corr",
                plot_style = "squares"
              )
            full_plot_1 <-
              plot_corr(
                mtcars,
                round_which = "correlation",
                decimals = 2,
                colour_by = "correlation",
                show_which = "signif",
                plot_style = "squares",
                legend_title = "test"
              )
            expect_error(
              plot_corr(
                mtcars,
                round_which = "gibberish",
                decimals = 2,
                colour_by = "correlation",
                show_which = "corr",
                plot_style = "squares"
              )
            )
            expect_warning(
              plot_corr(
                mtcars,
                round_which = "correlation",
                decimals = 2,
                colour_by = "correlation",
                show_which = "corr",
                plot_style = "squares"
              )
            )
            expect_true(inherits(full_plot, "ggplot"))
            expect_true(inherits(full_plot_1, "ggplot"))
            # check signif works as required
            expect_true(all(unique(
              ggplot_build(full_plot_1)$data[[2]]$label
            ) %in% c("***", "ns")))

            expect_warning(plot_corr(mtcars, legend_title = "test"))
          })
