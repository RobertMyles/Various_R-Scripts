library(tidyverse)
rm(list = ls())

# this script replicates the graph (not exactly, the data appear different) 
# from this news story on fivethirtyeight.com: 
# http://fivethirtyeight.com/datalab/how-baltimores-young-black-men-are-boxed-in/

wh <- read_csv("various/data/white_2015_income.csv",
               skip = 1) %>% 
  select(Id, Geography, 4) %>% 
  rename(white_income = `Estimate; Per capita income in the past 12 months (in 2015 Inflation-adjusted dollars)`)


bl <- read_csv("various/data/black_2015_income.csv",
               skip = 1) %>% 
  select(Id, Geography, 4) %>% 
  rename(black_income = `Estimate; Per capita income in the past 12 months (in 2015 Inflation-adjusted dollars)`)



pop <- read_csv("various/data/population.csv", skip = 1) %>% 
  select(Id, Geography,
         `2015 Estimate; RACE - One race - Black or African American`) %>% 
  rename(percent_black = `2015 Estimate; RACE - One race - Black or African American`)


income <- left_join(bl, wh)

income <- left_join(income, pop)

rm(bl, pop, wh)

# What is the name for the Baltimore region?

income$Geography[grep("Baltimore", income$Geography)]
# Baltimore-Columbia-Towson, MD Metro Area

income <- income %>% 
  mutate(gap = white_income - black_income,
         baltimore = ifelse(
           Geography == "Baltimore-Columbia-Towson, MD Metro Area",
                            1, 0),
         percent_black = as.numeric(percent_black)) %>% 
  filter(percent_black >= 10)

US <- income %>% 
  mutate(US_b = mean(black_income),
         US_w = mean(white_income),
         US_g = mean(gap)) %>% 
  distinct(US_b, US_w, US_g, .keep_all = T) %>% 
  mutate(Geography = "US mean", Id = "US")

baltimore <- income %>%
  filter(baltimore == 1)

income1 <- income %>% 
  filter(baltimore == 0)

# the colours of the various elements can be got from
# typing:
# library(ggthemes)
# theme_fivethirtyeight
# in the console. Note that you will need the ggthemes package installed.

ggplot(income1, aes(x = black_income, y = gap)) +
  geom_point(colour = "black", alpha = 0.7, size = 4) +
  geom_point(data = US, aes(x = US_b, y = US_g), 
             colour = "white", size = 4,
             shape = 21, fill = "goldenrod2") +
  geom_point(data = baltimore, aes(x = black_income, y = gap), 
             colour = "white", shape = 21,
             size = 4, fill = "red") +
  geom_hline(yintercept = 0) +
  theme(legend.position = "none", 
        panel.background = element_rect(fill = "#F0F0F0"),
        plot.background = element_rect(fill = "#F0F0F0"),
        panel.grid.major = element_line(color = "#D2D2D2"),
        panel.grid.minor = element_blank(),
        axis.title = element_text(face = "bold"),
        axis.text = element_text(family = "Courier"),
        axis.ticks = element_blank(),
        title = element_text(face = "bold")) +
  labs(list(title = "Baltimore is (maybe) an outlier", 
            subtitle = "Black-White income gap vs. black income, in cities where at least\n 10 percent of the population is black", 
            x = "Black Income", 
            y = "Black-white income gap")) +
  scale_y_continuous(breaks = c(0, 10000, 20000, 30000), labels = c("0", "+$10k", "+$20k", "+$30k")) +
  scale_x_continuous(breaks = c(10, 10000, 15000, 20000, 25000, 30000), labels = c("$0k", "10k", "15", "20", "25", "30")) +
  annotate(geom = "text", colour = "red", label = "Baltimore", 
           x = 26000, y = 24000, fontface = 2) +
  annotate(geom = "text", colour = "goldenrod2", label = "U.S.", 
           x = 13000, y = 7000, fontface = 2) +
  annotate(geom = "text", colour = "black", label = "Whites\n earn more",
           x = 32000, y = 30000, fontface = "italic") +
  annotate(geom = "point", colour = "black", shape = 17,
           x = 32000, y = 32000, size = 3) +
  annotate(geom = "text", colour = "black", label = "Blacks\n earn more",
           x = 32000, y = 8000, fontface = "italic") +
  annotate(geom = "point", colour = "black", shape = 25, fill = "black",
           x = 32000, y = 5800, size = 3)





