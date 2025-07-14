#' Plot a correlations matrix
#' @description This function plots the results produced by
#' `get_var_corr_`.
#' @param df The data to be plotted. A `data.frame` object produced
#' by `get_var_corr_`
#' @param x Value for the x axis. Defaults to "comparison_var"
#' @param y Values for the y axis. Defaults to "other_var."
#' @param show_which Character. One of either corr or signif to control whether to show the
#' correlation values or significance stars of the correlations. This is case sensitive and defaults to
#' corr i.e. correlation values are shown.
#' @param round_which Character. The column name to be rounded off.
#' @param decimals     Numeric. To how many decimal places should the rounding be done?
#' Defaults to 2.
#' @param custom_cols A vector(length 2) of colors to use for the plot. The first colour specifies the lower end of the
#' correlations. The second specifies  the higher end.
#' @param title plot title.
#' @param xlabel label for the x axis
#' @param ylabel label for the y axis
#' @param title_just Justification of the title. Defaults to 0.5, title is centered.
#' @param plot_style One of squares and circles(currently).
#' @param size Size of the circles for plot_style set to circles
#' @param colour_by The column to use for coloring. Defaults to  "correlation". Colour strength thus
#' indicates the strength of correlations.
#' @param shape Values for the shape if plot_style is circles
#' @param value_col What colour should the text in the squares/circles be?
#' @param value_angle What angle should the text be?
#' @param value_size Size of the text.
#' @param width width value for plot_style set to squares.
#' @param legend_labels Text to use for the legend labels. Defaults to the default
#' labels produced by the plot method.
#' @param legend_title Title to use for the legend.
#' @param signif_cutoff Numeric. If show_signif is TRUE, this defines the cutoff point for significance. Defaults to
#' 0.05.
#' @param signif_size Numeric. Defines size of the significance stars.
#' @param signif_col  Character. Defines the col for the significance stars.
#' @param ... Other arguments to get_var_corr_
#' @details
#' This function uses `ggplot2` backend. `ggplot2` is thus required for the plots to work.
#' Since the correlations are obtained by `get_var_corr_`, the default is to omit correlation between a variable and itself. Therefore
#' blanks in the plot would indicate a correlation of 1.
#' @return A `ggplot2` object showing the correlations plot.
#' @examples
#' plot_corr(mtcars,show_which = "corr",
#' round_values = TRUE,
#' round_which = "correlation",decimals = 2,x="other_var",
#' y="comparison_var",plot_style = "circles",width = 1.1,
#' custom_cols = c("green","blue","red"),colour_by = "correlation")


#' @export
#'
#'
plot_corr <- function(df,
                      x = "comparison_var",
                      y = "other_var",
                      xlabel = "Comparison Variable",
                      ylabel = "Other Variable",
                      title = "Correlations Plot",
                      plot_style = "circles",
                      title_just = 0.5,
                      round_values = TRUE,
                      round_which = "correlation",
                      decimals = 2,
                      colour_by = "correlation",
                      show_which = "corr",
                      size = 12.6,
                      value_angle = 360,
                      shape = 16,
                      value_size = 3.5,
                      value_col = "black",
                      width = 1.1,
                      custom_cols = c("indianred2", "green2",
                                      "gray34"),
                      legend_labels = waiver(),
                      legend_title = waiver(),

                      signif_cutoff=0.05,
                      signif_size = 7,
                      signif_col = "gray13",




                      ...) {
  UseMethod("plot_corr")
}
#' @export
plot_corr <- function(df,
                      x = "comparison_var",
                      y = "other_var",
                      xlabel = "comparison_variable",
                      ylabel = "other_variable",
                      title = "Correlations Plot",
                      plot_style = "circles",
                      title_just = 0.5,
                      round_which = NULL,
                      colour_by = NULL,
                      decimals = 2,
                      show_which = "corr",
                      size = 12.6,
                      value_angle = 360,

                      shape = 16,
                      value_size = 3.5,
                      value_col = "black",
                      width =1.1,
                      custom_cols = c("indianred2", "green2",
                                      "gray34"),
                      legend_labels=waiver(),
                       legend_title = NULL,
                       signif_cutoff=0.05,
                       signif_size = 7,
                       signif_col ="gray13",




                      ...) {

  df <- get_var_corr_(df,...)


#since R 4.0.0?

stopifnot("plot_style must be one of circles or squares"= plot_style %in% c("circles","squares"))



# Basic plot
if (!is.null(round_which)){
  # check that the column actually exists
  if(!round_which %in% names(df)) stop("round_which must exist in get_var_corr_(df)")

  df[[round_which]] <- round(df[[round_which]],decimals)


}
# For use with `.data`
colour_by_string <- colour_by
if (is.null(colour_by)) {
    warning("Using correlation in colour_by")
    colour_by <- df$correlation
    colour_by_string <- "correlation"

  }


  if(is.null(legend_title)){
    warning("Using colour_by for the legend title.")
    legend_title <- colour_by_string
  }



    base_plot <- ggplot(data = df, aes(x = !!sym(x) ,
                                                         y = !!sym(y)))
    base_plot_final <- base_plot +
      geom_point(size = size,
                 aes_string(col = colour_by),
                 shape = shape) +
      scale_color_gradient2(low = custom_cols[1],
                            high = custom_cols[2],
                            mid = custom_cols[3],
                            labels=legend_labels)+
      labs(x = xlabel, y = ylabel, title = title,
           color=legend_title)

  if (plot_style == "squares") {
    base_plot_final <- base_plot +
      geom_tile(size = size,
                aes(fill = !!sym(colour_by)),
                width = width) +
      scale_fill_gradient2(low = custom_cols[1],
                           mid = custom_cols[2],
                           high = custom_cols[3],
                           labels=legend_labels)+
      labs(x = xlabel, y = ylabel, title = title,
           fill=legend_title)
  }





    # set basic colours

    # Themes
    # can override with theme
    # No need to set default(imho)
    # if useing p values,format
    # 2show || !2show : That is the question -----> p_value signif

    switch(show_which,
           corr= {
             base_plot_final <-base_plot_final +
               geom_text(
                 aes_string(label = colour_by),
                 color = value_col,
                 angle = value_angle,
                 size = value_size
               )

           },
           signif={
             base_plot_final <- base_plot_final +
               geom_text(aes_string(label='ifelse(.data[[colour_by_string]] < signif_cutoff,
                                "***","ns")'),
                         size=signif_size,
                         color=signif_col)+
               labs(title="Significance Plot")

           })



 base_plot_final +
    theme_minimal()+

   theme(
      plot.title = element_text(hjust = title_just),
      panel.background = element_blank()
    )






}
