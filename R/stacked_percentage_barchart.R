library(tidyverse)

# How Cuban Americans responded to the question of whether the US should abondon
# the trade embargo with Cuba. (University of Florida survey)

# create data frame:  
cuba <- data_frame(position = rep(c("Against", "For"), times = 5),
                   years = c(1, 1, 2, 2, 3, 3, 
                             4, 4, 5, 5),
                   perc = c(.55, .45, .57, .43, .59, .41,
                            .56, .44, .42, .58))

# put in labels and position them according to the percentages:
cuba <- cuba %>% 
  mutate(label = paste0(sprintf("%.2f", .$perc), "%"),
         years = factor(years, labels = c("1959-1964", "1965-1973",
                                          "1974-1980", "1981-1994",
                                          "1995-2014"))) %>% 
  group_by(position) %>% 
  mutate(pos = if_else(position == "For", .5*perc, 1-.5*perc))




ggplot(cuba, aes(y = perc, x = as.factor(years),
                 fill = position), colour = "white") +
  geom_bar(stat = "identity", width = .7) +
  geom_text(aes(y = pos, label = label), size = 4, 
            colour = "white", family = "Times") +
  coord_flip() +
  ggtitle("Year left Cuba") +
  theme(axis.title = element_blank(),
        title = element_text(family = "Times", face = "italic",
                             size = 14, vjust = -2),
        plot.title = element_text(hjust = -0.22),
        axis.text.x = element_blank(),
        axis.text.y = element_text(family = "Times", size = 14),
        axis.ticks = element_blank(),
        panel.background = element_blank(),
        legend.position = "none",
        plot.caption = element_text(family = "Times", size = 11)) +
  scale_fill_manual(values = c("#C9C9C9", "#636363")) + 
  labs(caption = "Percentage of respondents who favor (left) or oppose (right) continuing the U.S. embargo of Cuba. \nSource: Cuba Poll 2014, Florida Int. University.")
