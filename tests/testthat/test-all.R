context("all")

test_that("naming works", {
  x <- get_mb(series = c(USA = "usgdp", Finland = "figdp"))
  x0 <- get_mb(series = c("usgdp", "figdp"))
  xx <- get_convert_mb(series = c(gdp = "usgdp", cpi = "uscpi"))
  xx0 <- get_convert_mb(series = c("usgdp", "uscpi"))
  expect_named(x, c("time", "USA", "Finland"))
  expect_named(x0, c("time", "usgdp", "figdp"))
  expect_named(xx, c("time", "gdp", "cpi"))
  expect_named(xx0, c("time", "usgdp", "uscpi"))
})
