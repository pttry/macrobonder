#' Get series from Macrobond in a data.frame.
#'
#' The function is used to get one or several time series of same frequency from
#' the Macrobond.
#'
#' For time series of different frequnecies use \code{\link{get_convert_mb}}.
#'
#' @param series a (named) vector of Macrobond serie codes.
#'
#' @return A data.frame with dates in \code{time} column and
#'   time series on other (named) columns.
#'
#' @import MacrobondAPI
#' @export
#'
#' @examples
#'   x <- get_mb(series = c("usgdp", "figdp"))
#'   x <- get_mb(series = c(USA = "usgdp", Finland = "figdp"))


get_mb <- function(series){
  ser_lst <- FetchTimeSeries(series)
  freqs <- unlist(lapply(ser_lst, getFrequency))
  if (!(all(freqs == mean(freqs)))) stop(
    "Series have different frequencies.\n",
    names(freqs),
    "\nUse read_mb() instead")

  xts_lst <- lapply(ser_lst, xts::as.xts)

  res <- as.data.frame(do.call("merge", xts_lst))
  res <- data.frame(time = as.Date(rownames(res)), res)
  if (!is.null(names(series))) names(res) <- names(series)
  row.names(res) <- NULL
  res
}
