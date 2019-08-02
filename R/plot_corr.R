#' Plot a correlations matrix
#' @import ggplot2
#' @description This function plots the results produced by
#' `get_var_corr_`.
#' @param df The data to be plotted. A `data.frame` object produced
#' by `get_var_corr_`
#' @param x Value for the x axis. Defaults to "Comparison_Var"
#' @param y Values for the y axis. Defaults to "Other_Var."
#' @param show_value Logical. Should correlation coefficients be shown on the plot?
#' Defaults to TRUE.
#' @param round_values Logical. Should values be rounded off? Defaults to TRUE.
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
#' @param colour_by The column to use for coloring. Defaults to  "Correlation". Colour strength thus
#' indicates the strength of correlations.
#' @param shape Values for the shape if plot_style is circles
#' @param value_col What colour should the text in the squares/circles be?
#' @param value_angle What angle should the text be?
#' @param value_size Size of the text.
#' @param width width value for plot_style set to squares.
#' @param legend_labels Text to use for the legend labels. Defaults to the default
#' labels produced by the plot method.
#' @param legend_title Title to use for the legend.
#' @param show_signif  Logical. Should significance stars be shown on the plot? Defaults to FALSE.
#' @param signif_cutoff Numeric. If show_signif is TRUE, this defines the cutoff point for significance. Defaults to 
#' 0.05. 
#' @param signif_size Numeric. Defines size of the significance stars.
#' @param signif_col  Charcater. Defines the col for the significance stars. 
#' @param ... Other arguments to specific methods(`geom_text`) Useful once `show_signif` is set to  TRUE.
#' @details
#' This function uses `ggplot2` backend. `ggplot2` is thus required for the plots to work.
#' Since the correlations are obtained by `get_var_corr_`, the default is to omit correlation between a variable and itself. Therefore
#' blanks in the plot would indicate a correlation of 1. 
#' @return A `ggplot2` object showing the correlations plot.
#' @examples
#' # compute correlations
#' res<-get_var_corr_(mtcars)
#' # defaults
#' plot_corr(res)
#' plot_corr(res, decimals = 2, plot_style = "circles",
#' show_value = TRUE, size = 7,
#' value_angle =360, colour_by = "Correlation",
#' shape = 16,
#' value_size = 3.5,
#' width = 1.1,
#' custom_cols = c("white","green2",
#' "gray34"),
#'              value_col = "black",
#'              x="Other_Var",y="Comparison_Var",
#'              xlabel = "Other_Variable",
#'              ylabel="Comaprison_Variable",
#'              legend_label="Correlations",
#'               legend_labels = c("Very_Low",
#'               "Low","Mid","High","VeryHigh"))

#'
#' @export
#'
#'
plot_corr <- function(df,
                      x = "Comparison_Var",
                      y = "Other_Var",
                      xlabel = "Comparison_Variable",
                      ylabel = "Other_Variable",
                      title = "Correlations Plot",
                      plot_style = "circles",
                      title_just = 0.5,
                      round_values = TRUE,
                      colour_by = "Correlation",
                      decimals = 2,
                      show_value = TRUE,
                      size = 12.6,
                      value_angle = 360,
                      shape = 16,
                      value_size = 3.5,
                      value_col = "black",
                      width = 1.1,
                      custom_cols = c("white", "green2",
                                      "gray34"),
                      legend_labels = waiver(),
                      legend_title = "Correlation",
                      
                      show_signif =FALSE,
                      signif_cutoff=0.05,
                      signif_size = 7,
                      signif_col = "gray13",
                      
                      
                      
                      
                      ...) {
  UseMethod("plot_corr")
}
#' @export
plot_corr <- function(df,
                      x = "Comparison_Var",
                      y = "Other_Var",
                      xlabel = "Comparison_Variable",
                      ylabel = "Other_Variable",
                      title = "Correlations Plot",
                      plot_style = "circles",
                      
                      title_just = 0.5,
                      round_values = TRUE,
                      colour_by = "Correlation",
                      decimals = 2,
                      show_value = TRUE,
                      size = 12.6,
                      value_angle = 360,
                      
                      shape = 16,
                      value_size = 3.5,
                      value_col = "black",
                      width =1.1,
                      custom_cols = c("white", "green2",
                                      "gray34"),
                      legend_labels=waiver(),
                      legend_title = "Correlation",
                      show_signif =FALSE,
                      signif_cutoff=0.05,
                      signif_size = 7,
                      signif_col ="gray13",
                      
                      
                      
                      
                      ...) {
  # significance

  if(all(show_value & show_signif)){
    stop("Can only show single values(currently). Either show
         significance or correlation values.")
  }
 

  #visible binding
  if (is.null(colour_by)) {
    colour_by <- df$Correlation
  }
  
  # Basic plot
  if (round_values) {
    df["Correlation"] <- round(df["Correlation"],
                                 decimals)
    
  }
  base_plot <- ggplot2::ggplot(data = df,
                               mapping =
                                 ggplot2::aes_string(x = x,
                                                     y = y))
  if (plot_style == "squares") {
    base_plot <- base_plot +
      geom_tile(size = size,
                aes_string(fill = colour_by),
                width = width) +
      scale_fill_gradient2(low = custom_cols[1],
                           mid = custom_cols[2],
                           high = custom_cols[3],
                           labels=legend_labels)+
      labs(x = xlabel, y = ylabel, title = title,
           fill=legend_title) 
  }
  
  else if (plot_style == "circles") {
    base_plot <- base_plot +
      geom_point(size = size,
                 aes_string(col = colour_by),
                 shape = shape) +
      scale_color_gradient2(low = custom_cols[1],
                            high = custom_cols[2],
                            mid = custom_cols[3],
                            labels=legend_labels)+
      labs(x = xlabel, y = ylabel, title = title,
           color=legend_title) 
  }
  if (show_value) {
    base_plot <- base_plot +
      geom_text(
        aes_string(label = colour_by),
        color = value_col,
        angle = value_angle,
        size = value_size
      )
  }
  
  
  # set basic colours
  actual_plot <- base_plot
  # Themes
  # can override with theme
  # No need to set default(imho)
  # if useing p values,format 
  # 2show || !2show : That is the question -----> p_value signif
actual_plot <- base_plot


 if(show_signif){
   actual_plot <- actual_plot +
     geom_text(aes_string(label='ifelse(df$p.value < signif_cutoff,
                                "***","ns")'),
               size=signif_size,
               color=signif_col)
     
 }
   actual_plot +
    theme_dark()+
   theme(
      plot.title = element_text(hjust = title_just),
      panel.background = element_blank()
    ) 
   
  

  
  
  
}
