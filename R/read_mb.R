#' Read series from Macrobond in a data.frame.
#'
#' @param series a vector of Macrobond serie codes.
#'
#' @examples x <- read_mb(series = c("usgdp", "figdp"))


read_mb <- function(series){
  ser_lst <- FetchTimeSeries(series)
  freqs <- unlist(lapply(ser_lst, getFrequency))
  if (!(all(freqs == mean(freqs)))) stop(
    "Series have different frequencies.\n",
    names(freqs))
  xts_lst <- lapply(ser_lst, as.xts)

  res <- as.data.frame(do.call("merge", xts_lst))
  res$time <- as.Date(rownames(res))
  row.names(res) <- NULL
  res
}


