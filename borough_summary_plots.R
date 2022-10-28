library(tidyverse)

dat <- read.csv("derived_data/airbnb_processed.csv")

# boxplot of prices by borough
bnb_plot1 <- dat %>%
  drop_na(neighbourhood.group) %>%
  ggplot(aes(neighbourhood.group, price, fill = neighbourhood.group)) + geom_boxplot() +
  labs(x = "Borough", y = "Price per Night", title = "Price by NYC Borough") +
  theme(legend.position = "none")+
  scale_fill_brewer(palette = "BuGn")

ggsave("figures/prices_by_borough.png", plot = bnb_plot1)

#boxplot of number of reviews by borough
bnb_plot2 <- dat %>%
  drop_na(neighbourhood.group) %>%
  ggplot(aes(neighbourhood.group, number.of.reviews, fill = neighbourhood.group)) + geom_boxplot() +
  labs(x = "Borough", y = "Number of Reviews", title = "Number of Reviews by NYC Borough") + 
  theme(legend.position = "none") +
  scale_fill_brewer(palette = "BuGn")

ggsave("figures/reviews_by_borough.png", plot = bnb_plot2)


