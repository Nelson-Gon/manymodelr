#' @title Replace missing values
#' @param df The data set(data.frame or vector) for which replacements are required
#' @param how How should missing values be replaced?  One of ffill, samples,value or any other known
#' method e.g mean, median, max ,min. The default is NULL meaning no  imputation is done. For character vectors,
#' the use of `get_mode` is also supported. No implementation for class factor(yet).
#' @param value If how is set to value, this allows the user to provide a specific fill value for the NAs.
#' @details This function currently does not support grouping although this may be achieved with some
#' inaccuracies using grouping functions from other packages.
#' @return A data.frame object with missing values replaced.
#' @examples
#' head(na_replace(airquality,how="value", value="Missing"))
#' @export
na_replace<-function(df,how=NULL,value=NULL){
  UseMethod("na_replace")
}
#' @export

na_replace.data.frame<-function(df,how=NULL,value=NULL){
 df %>%
    mutate(across(everything(),
                  ~na_replace.character(.,how=how,value = value)))

}
#' @export
na_replace.numeric<-function(df=NULL,how=NULL,value=NULL){



if(all(is.null(how),is.null(value))) stop("One of how or value should be provided")


  # individually get replacements
  if(! how%in%c("ffill","samples","value", "get_mode")){
    stop("how should be one of ffill, samples, value or get_mode.")
  }
  # fill missing values with next value
  to_replace<-df[!is.na(df)]


switch(how,
         ffill =  ifelse(is.na(df), to_replace[1:length(df[is.na(df)])],df),
         samples =
           ifelse(is.na(df),sample(na.omit(df),length(df[is.na(df)]),
                                   replace = TRUE),df),
         value = ifelse(is.na(df),value, df),
         get_mode = ifelse(is.na(df),do.call("get_mode",list(na.omit(df))),df))


}
#' @export
na_replace.character<- na_replace.numeric
