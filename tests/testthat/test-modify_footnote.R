context("test-modify_footnote")

test_that("modify_footnote works", {
  tbl_summary <-
    trial %>%
    dplyr::select(trt, age, grade) %>%
    tbl_summary(by = trt)

  expect_error(
    tbl_summary %>%
      modify_footnote(
        update = starts_with("stat_") ~
          "median (IQR) for continuous variables; n (%) categorical variables"
      ),
    NA
  )

  expect_error(
    tbl_summary %>%
      modify_footnote(update = everything() ~ NA),
    NA
  )

  expect_error(
    glm(response ~ age + grade, trial, family = binomial) %>%
      tbl_regression(exponentiate = TRUE) %>%
      modify_footnote(ci ~ "CI = Credible Interval", abbreviation = TRUE),
    NA
  )
})
