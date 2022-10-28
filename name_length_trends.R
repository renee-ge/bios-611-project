library(tidyverse)
air <- read.csv("derived_data/airbnb_processed.csv")


name_plot1 <- air %>%
  ggplot(aes(name_word_count,price)) + geom_point() +
  labs(x = "Word count in Listing Name", y = "Listing Price", title = "Listing Price by Word Count in Listing Name")
ggsave("figures/name_wcount_price.png", plot = name_plot1)

name_plot2 <- air %>%
  ggplot(aes(name_word_count,number.of.reviews)) + geom_point() +
  labs(x = "Word count in Listing Name", y = "Number of Reviews for Listing", title = "Number of Reviews by Word Count in Listing Name")
ggsave("figures/name_wcount_reviews.png", plot = name_plot2)

rules_plot1 <- air %>%
  ggplot(aes(rules_word_count,price)) + geom_point() +
  labs("Word count in House Rules", y = "Listing Price", title = "Listing Price by Word Count in House Rules")
ggsave("figures/rules_wcount_price.png", plot = rules_plot1)

rules_plot2 <- air %>%
  ggplot(aes(rules_word_count,number.of.reviews)) + geom_point() +
  labs(x = "Word count in House Rules", y = "Number of Reviews for Listing", title = "Number of Reviews by Word Count in Listing Name")
ggsave("figures/rules_wcount_reviews.png", plot = rules_plot2)