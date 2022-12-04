library(tidyverse)
library(gridExtra)
air <- read.csv("derived_data/airbnb_processed.csv")

num_1 <- air %>%
  ggplot(aes(name_word_count,number.of.reviews)) + geom_point() +
  labs(x = "Word count in Listing Name", y = "Number of Reviews for Listing", title = "Number of Reviews by Word Count in Listing Name")

num_2 <- air %>%
  ggplot(aes(rules_word_count,number.of.reviews)) + geom_point() +
  labs(x = "Word count in House Rules", y = "Number of Reviews for Listing", title = "Number of Reviews by Word Count in House Rules")

num_3 <- air %>%
  drop_na(room.type) %>%
  group_by(room.type) %>%
  summarise(mea = round(mean(number.of.reviews, na.rm = TRUE),2)) %>%
  ggplot(aes(room.type, mea, fill = room.type, label = mea)) +
  geom_bar(stat = "identity") +
  labs(x = "Room Type", y = "Average Number of Reviews ", title = "Avg No. of Reviews per Property by Room Type") +
  scale_fill_brewer(palette = "BuGn") +
  theme(legend.position = "none") +
  geom_text(vjust = -0.2)

num_4 <- air %>%
  drop_na(Construction.year) %>%
  group_by(Construction.year) %>%
  summarise(mea = mean(number.of.reviews, na.rm = TRUE)) %>%
  ggplot(aes(x=Construction.year, y=mea)) +
  geom_line() +
  labs(x = "Construction Year", y = "Mean Number of Reviews", title = "Avg No. of Reviews by Property Construction Year")

num_5 <- air %>%
  drop_na(instant_bookable) %>%
  group_by(instant_bookable) %>%
  summarise(mea = round(mean(number.of.reviews, na.rm = TRUE),2)) %>%
  ggplot(aes(instant_bookable, mea, fill = instant_bookable, label = mea)) +
  geom_bar(stat = "identity") +
  labs(x = "Instant Bookability", y = "Average Number of Reviews ", title = "Avg No. of Reviews per Property by Instant Bookability") +
  scale_fill_brewer(palette = "BuGn") +
  theme(legend.position = "none") +
  geom_text(vjust = -0.2)

num_6 <- air %>%
  drop_na(price_cat) %>%
  group_by(price_cat) %>%
  summarise(sum = sum(number.of.reviews, na.rm = TRUE)) %>%
  ggplot(aes(price_cat, sum, fill = price_cat, label = sum)) +
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette = "BuGn") +
  theme(legend.position = "none") +
  labs(x = "Price Category", y = "Total Number of Reviews", title = "Total Reviews by Price Category") +
  geom_text(vjust = -0.2) 

num_7 <- air %>%
  drop_na(cancellation_policy) %>%
  group_by(cancellation_policy) %>%
  summarise(sum = sum(number.of.reviews, na.rm = TRUE)) %>%
  ggplot(aes(cancellation_policy, sum, fill = cancellation_policy, label = sum)) +
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette = "BuGn") +
  theme(legend.position = "none") +
  labs(x = "Cancellation Policy", y = "Total Number of Reviews", title = "Total Reviews by Cancellation Policy") +
  geom_text(vjust = -0.2) 

num_8 <- air %>%
  drop_na(minimum.nights) %>%
  group_by(minimum.nights) %>%
  summarise(mea = mean(number.of.reviews, na.rm = TRUE)) %>%
  ggplot(aes(x=minimum.nights, y=mea)) +
  geom_line() +
  labs(x = "Minimum Nights", y = "Mean Number of Reviews", title = "Avg No. of Reviews by Minimum Stay")

num_9 <- air %>%
  drop_na(borough) %>%
  group_by(borough) %>%
  summarise(mea = round(mean(number.of.reviews, na.rm = TRUE),2)) %>%
  ggplot(aes(borough, mea, fill = borough, label = mea)) +
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette = "BuGn") +
  theme(legend.position = "none") +
  labs(x = "Borough", y = "Avg. Number of Reviews", title = "Avg No. Reviews by Borough") +
  geom_text(vjust = -0.2) 

num_10 <- air %>%
  drop_na(borough) %>%
  group_by(borough) %>%
  summarise(mea = sum(number.of.reviews, na.rm = TRUE)) %>%
  ggplot(aes(borough, mea, fill = borough, label = mea)) +
  geom_bar(stat = "identity") +
  scale_fill_brewer(palette = "BuGn") +
  theme(legend.position = "none") +
  labs(x = "Borough", y = "Total Number of Reviews", title = "Total No. Reviews by Borough") +
  geom_text(vjust = -0.2) 

ggsave("figures/wcount_reviews.png", plot=grid.arrange(num_1,num_2, ncol = 2),height = 5, width = 14)
ggsave("figures/barplots_reviews.png", grid.arrange(num_3,num_5,num_6,num_7, nrow=2,ncol=2), height = 8, width = 10)
ggsave("figures/line_reviews.png", grid.arrange(num_4,num_8, ncol = 2), height = 5, width = 10)
ggsave("figures/borough_reviews.png", grid.arrange(num_9,num_10, ncol = 2), height = 5, width = 10)

