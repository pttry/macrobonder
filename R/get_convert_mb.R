#' Read series from Macrobond to a data.frame.
#'
#' The function is used to read one or several time series from
#' the Macrobond. If time series have different frequency they are converted
#' to same frequency. Other conversions in macrobond are also available.
#'
#' For time series of same frequnecy the \code{\link{get_mb}} is faster.
#'
#' @param series A vector of Macrobond serie codes.
#' @param frequency An option for frequncy conversion. Default is \code{Highest},
#'   for others see \code{\link[MacrobondAPI]{TimeSeriesFrequency}}.
#' @param currency An option for currency conversion. Default is \code{""}
#'   (no conversion), for conversions use currency codes ("USD", "EUR", etc).
#'   List of supported currencies: \url{https://www.macrobond.com/index.php/currencylist}.
#' @param start_date, A starting date. A format of available absolute and
#'   relative date formulations see \code{\link[MacrobondAPI]{SeriesRequest-class}}
#' @param end_date, A ending date. A format of available absolute and
#'   relative date formulations see \code{\link[MacrobondAPI]{SeriesRequest-class}}
#'
#' @return A data.frame with dates in \code{time} column.
#' Time series are on other columns.
#'
#' @examples
#'   xx <- get_convert_mb(series = c("usgdp", "uscpi"))
#'   yy <- get_convert_mb(series = c("usgdp", "uscpi"), frequency = "Annual")
#'  zz <- get_convert_mb(series = c("usnaac0057", "eunaac0019"),
#'                frequency = "Annual", currency = "USD",
#'                start_date = "", end_date = ""))



get_convert_mb <- function(series, frequency = "Highest", currency = "",
                           start_date = "", end_date = ""){

  seriesRequest <- CreateUnifiedTimeSeriesRequest()
  setFrequency(seriesRequest, TimeSeriesFrequency[[frequency]])
  setCurrency(seriesRequest, currency = currency)
  setStartDate(seriesRequest, startDate = start_date)
  serie_expressions <- lapply(series, addSeries, m = seriesRequest)

  ser_lst <- FetchTimeSeries(seriesRequest)

  xts_lst <- lapply(ser_lst, as.xts)

  res <- as.data.frame(do.call("merge", xts_lst))
  res <- data.frame(time = as.Date(rownames(res)), res)
  row.names(res) <- NULL
  res
}
