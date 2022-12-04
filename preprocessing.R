library(tidyverse)
library(readr)

air <- read.csv("Airbnb_Open_Data.csv", na.strings=c("", "NA"))
air <- air %>%
  mutate(neighbourhood.group = ifelse(neighbourhood.group == "brookln", "Brooklyn", neighbourhood.group),
         neighbourhood.group = ifelse(neighbourhood.group == "manhatan", "Manhattan", neighbourhood.group),
         last.review = as.Date(last.review, "%m/%d/%y"),
         price = parse_number(price),
         service.fee = parse_number(service.fee),
         name_word_count = str_count(NAME, '\\w+'),
         rules_word_count = str_count(house_rules, '\\w+'))

#removing duplicate rows:
air <- air[!duplicated(air),]

#changing neighbourhood group to borough
colnames(air)[6]="borough"

#changing some character variables to factors
air$cancellation_policy <- factor(air$cancellation_policy)
air$room.type <- factor(air$room.type)
air$host_identity_verified <- ifelse(air$host_identity_verified == "unconfirmed", FALSE, ifelse(air$host_identity_verified == "verified", TRUE, NA))
air$borough <- factor(air$borough)

#availability.365 has entries > 365 and <0 which are not possible so we set to NA
air$availability.365 <- ifelse(air$availability.365 > 365 | air$availability.365 < 0, NA, air$availability.365)

#There are last reveiw dates that occur after the date the dataset was downloaded and so these are set to NA
air$last.review[air$last.review > as.Date("2022-09-01")] <- NA

#creating a price category
air$price_cat <- cut(air$price, breaks = c(0,250, 500, 750, 1000, 1250), dig.lab = 6)

# some really outrageous minimum stay entries we set to NA
air$minimum.nights <- ifelse(air$minimum.nights < 0 | air$minimum.nights >90, NA, air$minimum.nights)

air %>% write_csv("derived_data/airbnb_processed.csv")
