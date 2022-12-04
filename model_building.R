library(tidyverse)
library(broom)
library(gridExtra)
library(grid)

air <- read.csv("derived_data/airbnb_processed.csv")

f1 <- lm(number.of.reviews ~ rules_word_count, air)
f2 <- lm(number.of.reviews ~ name_word_count, air)
f3 <- lm(number.of.reviews ~ minimum.nights, air)
f4 <- lm(number.of.reviews ~ price, air)
f5 <- lm(number.of.reviews ~ room.type, air)
f6 <- lm(number.of.reviews ~ borough, air)
f7 <- lm(number.of.reviews ~ Construction.year, air)

names(f1$coefficients) <- c("Intercept", "Rules Word Count")
names(f2$coefficients) <- c("Intercept","Name Word Count")
names(f3$coefficients) <- c("Intercept","Minimum Nights")
names(f4$coefficients) <- c("Intercept","Price")
names(f5$coefficients) <- c("Intercept","Hotel Room", "Private Room", "Shared Room")
names(f6$coefficients) <- c("Intercept","Brooklyn", "Manhattan", "Queens", "Staten Island")
names(f7$coefficients) <- c("Intercept","Construction Year")

f1_res <- tidy(f1, conf.int = TRUE)
f2_res <- tidy(f2, conf.int = TRUE)
f3_res <- tidy(f3, conf.int = TRUE)
f4_res <- tidy(f4, conf.int = TRUE)
f5_res <- tidy(f5, conf.int = TRUE)
f6_res <- tidy(f6, conf.int = TRUE)
f7_res <- tidy(f7, conf.int = TRUE)

res <- do.call(rbind, list(f1_res,f2_res,f3_res,f4_res,f5_res,f6_res,f7_res))
res <- res %>%
  select(`Term` = `term`, `Estimate` = `estimate`, `Standard Error` = `std.error`, `Test Statistic` = `statistic`, `P-value` = `p.value`)
res[] <- lapply(res, format, digits = 2)

png("models/individual_regression.png", height = 22*nrow(res), width = 90*ncol(res))
myTable <- tableGrob(
  res, 
  rows = NULL, 
  theme = ttheme_default(core = list(bg_params = list(fill = "grey99")))
)
grid.draw(myTable)
dev.off()

f8 <- lm(number.of.reviews ~ name_word_count + minimum.nights + room.type + borough, air)
names(f8$coefficients) <- c("Intercept", "Name Word Count", "Minimum Nights", "Hotel Room", "Private Room", "Shared Room", "Brooklyn", "Manhattan", "Queens", "Staten Island")
f8_res <- tidy(f8)

f8_res <- f8_res %>% select(`Term` = `term`, `Estimate` = `estimate`, `Standard Error` = `std.error`, `Test Statistic` = `statistic`, `P-value` = `p.value`)
f8_res[] <- lapply(f8_res, format, digits = 2)

png("models/combined_regression.png", height = 25*nrow(f8_res), width = 100*ncol(f8_res))
myTable <- tableGrob(
  f8_res, 
  rows = NULL, 
  theme = ttheme_default(core = list(bg_params = list(fill = "grey99")))
)
grid.draw(myTable)
dev.off()
  
f9 <- lm(number.of.reviews ~ minimum.nights + room.type + borough, air)
names(f9$coefficients) <- c("Intercept", "Minimum Nights", "Hotel Room", "Private Room", "Shared Room", "Brooklyn", "Manhattan", "Queens", "Staten Island")
f9_res <- tidy(f9)

f9_res <- f9_res %>% select(`Term` = `term`, `Estimate` = `estimate`, `Standard Error` = `std.error`, `Test Statistic` = `statistic`, `P-value` = `p.value`)
f9_res[] <- lapply(f9_res, format, digits = 2)

png("models/adjusted_regression.png", height = 25*nrow(f9_res), width = 100*ncol(f9_res))
myTable <- tableGrob(
  f9_res, 
  rows = NULL, 
  theme = ttheme_default(core = list(bg_params = list(fill = "grey99")))
)
grid.draw(myTable)
dev.off()
