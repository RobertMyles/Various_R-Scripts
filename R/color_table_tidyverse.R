
# R colors minus 100 shades of grey 
# tidyverse version of the R Color Table made here:
# https://github.com/hdugan/rColorTable/blob/master/rColorTable.R

library(stringr)
library(tidyverse)


colour <- data_frame(colours = colors()) %>%
  filter(!grepl("gray", colours),
         !grepl("grey", colours)) %>%
  mutate(general_colour = gsub("[0-9]", "", colours),
         c1 = ifelse(grepl("1", colours), 1, 0),
         c2 = ifelse(grepl("2", colours), 1, 0),
         c3 = ifelse(grepl("3", colours), 1, 0),
         c4 = ifelse(grepl("4", colours), 1, 0)) %>% 
  select(-1) %>% 
  group_by(general_colour) %>% 
  summarise_each(funs(sum)) %>% 
  ungroup() %>% 
  mutate(c1 = ifelse(grepl(1, c1), paste0(general_colour, c1), NA),
         c2 = ifelse(grepl(1, c2), paste0(general_colour, "2"), NA),
         c3 = ifelse(grepl(1, c3), paste0(general_colour, "3"), NA),
         c4 = ifelse(grepl(1, c4), paste0(general_colour, "4"), NA),
         c1 = ifelse(is.na(c1), general_colour, c1),
         c2 = ifelse(is.na(c2), general_colour, c2),
         c3 = ifelse(is.na(c3), general_colour, c3),
         c4 = ifelse(is.na(c4), general_colour, c4))

  
g0 <- ggplot(colour, aes(x = general_colour)) +
  geom_bar(position = "stack", alpha = 0) +
  coord_flip() + 
  theme_minimal() +
  theme(legend.position = "none") +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(),
        axis.title.x = element_blank(), panel.grid = element_blank(),
        axis.title.y = element_blank())

g <- ggplot(colour, aes(x = general_colour, color = general_colour,
                   fill = general_colour)) +
  geom_bar(position = "stack") +
  coord_flip() + 
  scale_color_manual(values = colour$general_colour) +
  scale_fill_manual(values = colour$general_colour) +
  theme_minimal() +
  theme(legend.position = "none") +
  theme(axis.text = element_blank(), axis.ticks = element_blank(),
        axis.title = element_blank(), panel.grid = element_blank())

g_1 <- ggplot(colour, aes(x = c1, color = c1,
                        fill = c1)) +
  geom_bar(position = "stack") +
  coord_flip() + 
  scale_color_manual(values = colour$c1) +
  scale_fill_manual(values = colour$c1) +
  theme_minimal() +
  theme(legend.position = "none") +
  theme(axis.text = element_blank(), axis.ticks = element_blank(),
        axis.title = element_blank(), panel.grid = element_blank())

g_2 <- ggplot(colour, aes(x = c2, color = c2,
                        fill = c2)) +
  geom_bar(position = "stack") +
  coord_flip() + 
  scale_color_manual(values = colour$c2) +
  scale_fill_manual(values = colour$c2) +
  theme_minimal() +
  theme(legend.position = "none") +
  theme(axis.text = element_blank(), axis.ticks = element_blank(),
        axis.title = element_blank(), panel.grid = element_blank())

g_3 <- ggplot(colour, aes(x = c3, color = c3,
                        fill = c3)) +
  geom_bar(position = "stack") +
  coord_flip() + 
  scale_color_manual(values = colour$c3) +
  scale_fill_manual(values = colour$c3) +
  theme_minimal() +
  theme(legend.position = "none") +
  theme(axis.text = element_blank(), axis.ticks = element_blank(),
        axis.title = element_blank(), panel.grid = element_blank())

g_4 <- ggplot(colour, aes(x = c4, color = c4,
                        fill = c4)) +
  geom_bar(position = "stack") +
  coord_flip() + 
  scale_color_manual(values = colour$c4) +
  scale_fill_manual(values = colour$c4) +
  theme_minimal() +
  theme(legend.position = "none") +
  theme(axis.text = element_blank(), axis.ticks = element_blank(),
        axis.title = element_blank(), panel.grid = element_blank())

library(cowplot)

pdf(file = "color_chart_dplyr.pdf", height = 35, width = 8)
plot_grid(g0, g, g_1, g_2, g_3, g_4, align = "h", ncol = 6, 
          rel_widths = c(.75, 1.05, 1.05, 1.05, 1.05, 1.05))
dev.off()
