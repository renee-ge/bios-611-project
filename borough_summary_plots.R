library(tidyverse)
library(gridExtra)

air <- read.csv("derived_data/airbnb_processed.csv")

# boxplot of prices by borough
bor1 <- air %>%
  drop_na(borough) %>%
  ggplot(aes(borough, price, fill = borough)) + geom_boxplot() +
  labs(x = "Borough", y = "Price per Night", title = "Price by NYC Borough") +
  theme(legend.position = "none")+
  scale_fill_brewer(palette = "BuGn")

bor2 <- air %>%
  drop_na(borough) %>%
  group_by(borough, room.type) %>%
  summarise(n=n()) %>%
  ggplot(aes(borough, n, fill = room.type)) +
  geom_bar(position = "fill", stat = "identity") +
  scale_fill_brewer("Room Type", palette = 2) +
  theme(axis.text.x = element_text(angle = 45, hjust=1))+
  labs(x = "Borough", y = "Percentage", title = "Room Type Among Boroughs")

bor3 <- air %>%
  drop_na(borough) %>%
  group_by(borough, cancellation_policy) %>%
  summarise(n=n()) %>%
  ggplot(aes(borough, n, fill = cancellation_policy)) +
  geom_bar(position = "fill", stat = "identity") +
  scale_fill_brewer("Cancellation Policy", palette = 2) +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  labs(x = "Borough", y = "Percentage", title = "Cancellation Policy Among Boroughs")

bor4 <- air %>%
  drop_na(borough) %>%
  drop_na(instant_bookable) %>%
  group_by(borough, instant_bookable) %>%
  summarise(n=n()) %>%
  ggplot(aes(borough, n, fill = instant_bookable)) +
  geom_bar(position = "fill", stat = "identity") +
  scale_fill_brewer("Instantly Bookable?", palette = 2) +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  labs(x = "Borough", y = "Percentage", title = "Instant Bookability Among Boroughs")

bor5 <- air %>%
  drop_na(borough) %>%
  drop_na(host_identity_verified) %>%
  group_by(borough, host_identity_verified) %>%
  summarise(n=n()) %>%
  ggplot(aes(borough, n, fill = host_identity_verified)) +
  geom_bar(position = "fill", stat = "identity") +
  scale_fill_brewer("Host Identity Verified", palette = 2) +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  labs(x = "Borough", y = "Percentage", title = "Distribution of Host ID Verification Among Boroughs")

bor6 <- air %>%
  drop_na(borough) %>%
  group_by(borough) %>%
  summarise(mea = round(mean(review.rate.number, na.rm=TRUE),2)) %>%
  ggplot(aes(borough, mea, fill = borough, label = mea)) +
  geom_bar(stat = "identity") +
  labs(x = "Borough", y = "Average Rating", title = "Average Rating by Borough") +
  scale_fill_brewer(palette = 2) +
  theme(legend.position = "none") +
  geom_text(vjust = -0.2)

bor7 <- air %>%
  drop_na(borough) %>%
  group_by(borough) %>%
  summarise(mea = round(mean(availability.365, na.rm=TRUE),2)) %>%
  ggplot(aes(borough, mea, fill = borough, label = mea)) +
  geom_bar(stat = "identity") +
  labs(x = "Borough", y = "Average Availability", title = "Average Availability by Borough") +
  scale_fill_brewer(palette = 2) +
  theme(legend.position = "none") +
  geom_text(vjust = -0.2)


ggsave("figures/price_borough.png", plot = bor1, width = 8, height = 3)
ggsave("figures/assoc_borough.png", plot = grid.arrange(bor2,bor3,bor4,bor5,ncol = 2, nrow =2), width = 8, height = 8)
ggsave("figures/rat_avail_borough.png", plot = grid.arrange(bor6,bor7, ncol = 2), width = 8, height = 4)




