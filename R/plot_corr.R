#' Plot a correlations matrix
#' @import ggplot2
#' @description This function plots the results produced by 
#' `get_var_corr_`.
#' @param data The data to be plotted. A `data.frame` object produced
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
#' @param ... Other arguments to specific methods.
#' @details 
#' This function uses `ggplot2` backend. `ggplot2` is thus required for the plots to work.
#' @return A `ggplot2` object.
#' @examples 
#' # compute correlations
#' res<-get_var_corr_(mtcars)
#' plot_corr(res, decimals = 2, plot_style = "squares",
#' show_value = TRUE, size = 13,
#' value_angle =20, colour_by = "Correlation")

#' 
#' @export
#' 
#' 
plot_corr<-function(data,x="Comparison_Var",
                            y="Other_Var",show_value=TRUE,
                            round_values=TRUE,
                            decimals = 2,
                            custom_cols=c("skyblue",
                                          "indianred2"),
                            title="Correlations Plot",
                            xlabel="Comparison_Variable",
                            ylabel="Other_Variable",
                            title_just = 0.5,
                            plot_style = "squares",
                            size= 12,
                            colour_by = NULL,
                            shape=NULL,
                            value_col="blue",
                            value_angle=360,
                            value_size=4.5,
                            
                            ...){
  UseMethod("plot_corr")
}
#' @export
plot_corr<- function(data,x="Comparison_Var",
                     y="Other_Var",show_value=TRUE,
                     round_values=TRUE,
                     decimals = 2,
                     custom_cols=c("skyblue",
                                   "indianred2"),
                     title="Correlations Plot",
                     xlabel="Comparison_Variable",
                     ylabel="Other_Variable",
                     title_just = 0.5,
                     plot_style = "squares",
                     size= 12,
                     colour_by = NULL,
                     shape=NULL,
                     value_col="blue",
                     value_angle=360,
                     value_size=4.5,
                    
                    ...){
  #visible binding
  if(is.null(colour_by)){
    colour_by <- data$Correlation
  }

  # Basic plot
  if(round_values){
    data["Correlation"] <- round(data["Correlation"],
                              decimals)
  
  }
  base_plot<-ggplot2::ggplot(data=data,
                  mapping = 
            ggplot2::aes_string(x=x,
                                y=y))
if(plot_style == "squares"){
  base_plot <- base_plot+
               geom_tile(size=size,
                         aes_string(fill=colour_by),
                         
                         ...)+
    scale_fill_gradient(low=custom_cols[1],
                        high=custom_cols[2],
                        ...)
}
  
else if(plot_style =="circles"){
  base_plot <- base_plot+
               geom_point(size=size,
                          aes_string(col=colour_by),
                          shape=shape,
                          ...)+
    scale_color_gradient(low=custom_cols[1], 
                         high=custom_cols[2],
                         ...)
}
if(show_value){
  base_plot <- base_plot + 
    geom_text(aes_string(label=colour_by),
                  color=value_col,
              angle=value_angle,size=value_size)
}
 
  
# set basic colours
actual_plot<-base_plot
# Themes 
actual_plot+
  labs(x=xlabel, y=ylabel, title = title)+
  theme(plot.title = element_text(hjust=title_just,
                                  ...),
        panel.grid = element_blank(),
        panel.background = element_blank())

  
    
}



