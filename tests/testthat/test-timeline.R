test_that("get_timeline works", {
  
  vcr::use_cassette("get_timeline1", {
    x <- get_timeline(c("cnnbrk", "cnn"), n = 400)
  })
  expect_s3_class(x, "data.frame")
  expect_true("id" %in% names(x))
  expect_gt(nrow(x), 100)
  expect_gt(ncol(x), 20)
})

test_that("get_my_timeline() works", {
  
  vcr::use_cassette("get_timeline2", {
    gmt <- get_my_timeline()
  })
  expect_s3_class(gmt, "data.frame")
  expect_true(nrow(gmt) > 50)
})

test_that("get_timelines() is deprecated", {
  
  vcr::use_cassette("get_timeline3", {
    expect_snapshot(x <- get_timelines("cnn", n = 10))
  })
})

test_that("Doesn't trim at 280 characters, #575", {
  
  vcr::use_cassette("get_timeline4", {
    timeline_users <- get_timeline(user = "mvabercron", n = 20)
  })
  text <- timeline_users$text[!is.na(timeline_users$text)]
  expect_true(any(nchar(text) > 280)|| all(!endsWith(text, "...")))
})

