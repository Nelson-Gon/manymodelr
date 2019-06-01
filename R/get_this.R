#' Helper function to easily access elements
#' @param what What do you want to extract from the `data.frame` or `list`? No quotes. See
#' examples below.
#' @param where Where do you want to get it from? Currently only supports `list`s
#' and `data.frame`objects.
#' @details This is a helper function useful if you would like to extract data from
#' the output of `multi_model_1`.
#' @examples
#' my_list<-list(list(A=520),list(B=456))
#' get_this(A,my_list)
#' @export
get_this<-function (what, where)
{
  what <- deparse(substitute(what))
  deeper<-deparse(substitute(deeper))
  if (is.list(where) & !is.data.frame(where)) {
    if (is.null(names(where))) {
      Filter(Negate(is.null), Map(function(x) x[[what]],
                                  where))
    }

    else {
      what_matched <- match.arg(what, names(where))
      where[[what_matched]]
    }
  }
  else if (is.data.frame(where)) {
    what_matched <- match.arg(what, names(where))
    where[,what_matched]


  }
}

