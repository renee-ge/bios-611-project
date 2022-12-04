library(tidyverse)
library(gridExtra)
library(scales)
air <- read.csv("derived_data/airbnb_processed.csv")

blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )

sum1 <- air %>% 
  drop_na(cancellation_policy) %>%
  group_by(cancellation_policy) %>%
  summarise(n = n()) %>%
  mutate(per = round(n/sum(n),3),
         labels = percent(per)) %>%
  ggplot(aes(x = "", y = per, fill=cancellation_policy)) +
  geom_bar(width = 1, stat = "identity")+
  coord_polar("y") +
  labs(fill = "Cancellation Policy") +
  scale_fill_brewer(palette = 1) +
  blank_theme +
  theme(axis.text.x=element_blank()) +
  geom_label(aes(label = labels),
             position = position_stack(vjust = 0.5),
             show.legend = FALSE)

sum2 <- air %>% 
  drop_na(instant_bookable) %>%
  group_by(instant_bookable) %>%
  summarise(n = n()) %>%
  mutate(per = round(n/sum(n),3),
         labels = percent(per)) %>%
  ggplot(aes(x = "", y = per, fill=instant_bookable)) +
  geom_bar(width = 1, stat = "identity")+
  coord_polar("y") +
  labs(fill = "Instant Bookability") +
  scale_fill_brewer(palette = 1) +
  blank_theme +
  theme(axis.text.x=element_blank()) +
  geom_label(aes(label = labels),
             position = position_stack(vjust = 0.5),
             show.legend = FALSE)

sum3<- air %>% 
  drop_na(room.type) %>%
  group_by(room.type) %>%
  summarise(n = n()) %>%
  mutate(per = round(n/sum(n),3),
         labels = percent(per)) %>%
  ggplot(aes(x = "", y = per, fill=room.type)) +
  geom_bar(width = 1, stat = "identity")+
  coord_polar("y") +
  labs(fill = "Room Type") +
  scale_fill_brewer(palette = 1) +
  blank_theme +
  theme(axis.text.x=element_blank()) +
  geom_label(aes(label = labels),
             position = position_stack(vjust = 0.5),
             show.legend = FALSE)


sum4 <- air %>% 
  drop_na(borough) %>%
  group_by(borough) %>%
  summarise(n = n()) %>%
  mutate(per = round(n/sum(n),3),
         labels = percent(per)) %>%
  ggplot(aes(x = borough, y = per, fill=borough, label = labels)) +
  geom_bar(stat = "identity")+
  labs(fill = "Borough") +
  scale_fill_brewer(palette = 1) +
  theme(legend.position = "none") +
  geom_text(vjust = -0.2) +
  labs(x = "Borough", y = "Percent", title = "Distribution of Properties among Boroughs")

sum5 <- air %>%
  drop_na(price) %>%
  ggplot(aes(price)) +
  geom_histogram(color = "black", fill = "white") +
  labs(x = "Price ($)", y = "Count", title = "Distribution of Prices")

sum6 <- air %>%
  drop_na(minimum.nights) %>%
  ggplot(aes(minimum.nights)) +
  geom_histogram(color = "black", fill = "white") +
  labs(x = "Minimum Nights per Booking", y = "Count", title = "Minimum Night Requirement Distribution")
sum7 <- air %>%
  drop_na(number.of.reviews) %>%
  ggplot(aes(number.of.reviews)) +
  geom_histogram(color = "black", fill = "white") +
  labs(x = "Number of Reviews", y = "Count", title = "Distribution of Number of Reviews")

sum8 <- air %>% 
  drop_na(review.rate.number) %>%
  group_by(review.rate.number) %>%
  summarise(n = n()) %>%
  mutate(per = round(n/sum(n),3),
         labels = percent(per)) %>%
  ggplot(aes(x = review.rate.number, y = per, fill=factor(review.rate.number), label = labels)) +
  geom_bar(stat = "identity")+
  labs(fill = "Rating") +
  scale_fill_brewer(palette = 1) +
  theme(legend.position = "none") +
  geom_text(vjust = -0.2) +
  labs(x = "Rating", y = "Percent", title = "Distribution of Review Ratings")

sum9 <- air %>%
  drop_na(rules_word_count) %>%
  ggplot(aes(rules_word_count)) +
  geom_histogram(color = "black", fill = "white") +
  labs(x = "House Rules Word Count", y = "Count", title = "Distribution of House Rules Word Count")

sum10 <- air %>%
  drop_na(name_word_count) %>%
  ggplot(aes(name_word_count)) +
  geom_histogram(color = "black", fill = "white") +
  labs(x = "Listing Name Word Count", y = "Count", title = "Distribution of Listing Name Word Count")

sum11 <- air %>%
  drop_na(availability.365) %>%
  ggplot(aes(availability.365)) +
  geom_histogram(color = "black", fill = "white") +
  labs(x = "Availability in next 365 Days", y = "Count", title = "Distribution of Future Availability")
sum12 <- air %>%
  drop_na(Construction.year) %>%
  ggplot(aes(Construction.year)) +
  geom_bar() +
  labs(x = "Construction Year", y = "Count", title = "Distribution of Property Construction Year")
sum13 <- air %>% 
  drop_na(host_identity_verified) %>%
  group_by(host_identity_verified) %>%
  summarise(n = n()) %>%
  mutate(per = round(n/sum(n),3),
         labels = percent(per)) %>%
  ggplot(aes(x = "", y = per, fill=host_identity_verified)) +
  geom_bar(width = 1, stat = "identity")+
  coord_polar("y") +
  labs(fill = "Host Identity Verified") +
  scale_fill_brewer(palette = 1) +
  blank_theme +
  theme(axis.text.x=element_blank()) +
  geom_label(aes(label = labels),
             position = position_stack(vjust = 0.5),
             show.legend = FALSE)

ggsave("figures/summary_pie_statistics.png", plot = grid.arrange(sum1,sum2,sum3, sum13,nrow = 2, ncol = 2), width = 10, height = 4)

ggsave("figures/summary_stats.png", plot = grid.arrange(sum4,sum8, sum9,sum10,sum6,sum7,sum11, sum12, ncol = 2, nrow = 4), height = 12, width = 14)
