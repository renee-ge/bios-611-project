library(tidyverse)
library(readr)

air <- read.csv("Airbnb_Open_Data.csv", na.strings=c("", "NA"))
air <- air %>%
  mutate(neighbourhood.group = ifelse(neighbourhood.group == "brookln", "Brooklyn", neighbourhood.group),
         neighbourhood.group = ifelse(neighbourhood.group == "manhatan", "Manhattan", neighbourhood.group),
         last.review = as.Date(last.review, "%m/%d/%Y"),
         price = parse_number(price),
         name_word_count = str_count(NAME, '\\w+'),
         rules_word_count = str_count(NAME, '\\w+'))

air %>% write_csv("derived_data/airbnb_processed.csv")