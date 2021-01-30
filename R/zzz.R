# Welcome messages, nothing fancy
.onAttach <- function(lib, pkg, ...){
  startup_msg <- paste0("Welcome to manymodelr. This is manymodelr version ",
                        packageVersion("manymodelr"),".\n",
                  " Please file issues and feedback at https://www.github.com/Nelson-Gon/manymodelr/issues\n",
                        "Turn this message off using 'suppressPackageStartupMessages(library(manymodelr))'\n",
                        " Happy Modelling! :)")
  packageStartupMessage(startup_msg)
}
