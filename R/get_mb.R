#' Get series from Macrobond in a data.frame.
#'
#' The function is used to get one or several time series of same frequency from
#' the Macrobond.
#'
#' For time series of different frequnecies use \code{\link{get_convert_mb}}.
#'
#' @param series a vector of Macrobond serie codes.
#'
#' @return A data.frame with dates in \code{time} column.
#' Time series are on other columns.
#'
#' @import MacrobondAPI
#'
#' @examples
#'   x <- get_mb(series = c("usgdp", "figdp"))


get_mb <- function(series){
  ser_lst <- MacrobondAPI::FetchTimeSeries(series)
  freqs <- unlist(lapply(ser_lst, getFrequency))
  if (!(all(freqs == mean(freqs)))) stop(
    "Series have different frequencies.\n",
    names(freqs),
    "\nUse read_mb() instead")

  xts_lst <- lapply(ser_lst, as.xts)

  res <- as.data.frame(do.call("merge", xts_lst))
  res <- data.frame(time = as.Date(rownames(res)), res)
  row.names(res) <- NULL
  res
}
