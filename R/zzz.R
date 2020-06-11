# Welcome messages, nothing fancy
.onAttach <- function(...){
  # better to paste or c the message
  pkg_info <- "Welcome to manymodelr.
For the latest development version,
please see: https://www.github.com/Nelson-Gon/manymodelr.
Please file issues at https://github.com/Nelson-Gon/manymodelr/issues"
  packageStartupMessage(pkg_info)

}
