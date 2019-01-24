# Load packages
library(ggplot2)
library(dplyr)
library(gapminder)

# Plot at country level ----
gapminder_1997 <- gapminder %>% filter(year == 1997)

p1 <- ggplot(data = gapminder_1997) +
  geom_point(mapping = aes(x = gdpPercap,
                           y = lifeExp,
                           color = continent,
                           size = pop)) +
  scale_x_log10() + 
  geom_hline(yintercept = median(gapminder_1997$lifeExp)) +
  geom_vline(xintercept = median(gapminder_1997$gdpPercap)) +
  ggtitle(label = "The 1997 gampinder world map",
          subtitle = "Medians at country level")
p1

# Country level vs. population level ----

## lifeExp: Country level
median(gapminder_1997$lifeExp)

# lifeExp: Individual level
medianObs <- sum(gapminder_1997$pop)/2
hl <- gapminder_1997 %>% 
  arrange(lifeExp) %>%
  mutate(cumsumPop = cumsum(as.numeric(pop))) %>% 
  filter(cumsumPop >= medianObs) %>% 
  summarize(median_lifeExp_pop = min(lifeExp))

# gdpPercap: Country level
median(gapminder_1997$gdpPercap)

# gdpPercap: Individual level
medianObs <- sum(gapminder_1997$pop)/2
vl <- gapminder_1997 %>% 
  arrange(gdpPercap) %>%
  mutate(cumsumPop = cumsum(as.numeric(pop))) %>% 
  filter(cumsumPop >= medianObs) %>% 
  summarize(median_gdpPercap_pop = min(gdpPercap))

# Plot at population level ----
p2 <- ggplot(data = gapminder_1997) +
  geom_point(mapping = aes(x = gdpPercap,
                           y = lifeExp,
                           color = continent,
                           size = pop)) +
  scale_x_log10() + 
  geom_hline(yintercept = as.numeric(hl)) +
  geom_vline(xintercept = as.numeric(vl)) +
  ggtitle(label = "The 1997 gampinder world map",
          subtitle = "Medians at population level")
p2

# Display both plots p1 and p2 side by side ----
gridExtra::grid.arrange(p1, p2, ncol = 2)

# Improve (one legend and one y axis title with text and ticks) ----

p1.1 <- p1 + 
  theme(legend.position = "none")
p2.1 <- p2 + 
  theme(legend.position = "none",
        axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank())
  
library(cowplot)
theme_set(theme_grey()) # loading cowplot changes the theme, we go back to grey
# theme_set(theme_bw()) # try some other themes if you want, e.g. bw

plot_grid(
  p1.1, 
  p2.1, 
  get_legend(p1.1 + theme(legend.position = "right")),
  nrow = 1, 
  rel_widths = c(4, 4, 1) # here we can adjust the relative width
)

# How to add text annotations ----

p2 + 
  geom_text(mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          label = country))

# How to add text annotations ----
library(ggrepel)
p2 + 
  geom_text_repel(mapping = aes(x = gdpPercap,
                                y = lifeExp,
                                label = country))

# How to add text annotations ----
library(ggrepel)

p2 + 
  geom_text_repel(mapping = aes(x = gdpPercap,
                                y = lifeExp,
                                label = country),
                  data = filter(gapminder_1997,
                                continent == "Oceania"))

p2 + 
  geom_text_repel(mapping = aes(x = gdpPercap,
                                y = lifeExp,
                                label = country),
                  data = filter(gapminder_1997,
                                continent == "Europe"))

p2 + 
  geom_text_repel(mapping = aes(x = gdpPercap,
                                y = lifeExp,
                                label = country),
                  data = filter(gapminder_1997,
                  continent == "Americas"))

p2 + 
  geom_text_repel(mapping = aes(x = gdpPercap,
                                y = lifeExp,
                                label = country),
                  data = filter(gapminder_1997,
                                continent == "Asia"))

p2 + 
  geom_text_repel(mapping = aes(x = gdpPercap,
                                y = lifeExp,
                                label = country),
                  data = filter(gapminder_1997,
                                continent == "Africa"))

friends <- c("Afghanistan",              
"Argentina",              
"Australia",               
"Austria",                 
"Bangladesh",              
"Bosnia and Herzegovina",  
"Bulgaria",   
"Chile",      
"China",      
"Colombia",                
"Croatia",
"Czech Republic",         
"Denmark",
"Finland",
"France", 
"Germany",
"Greece", 
"Hong Kong, China",      
"Hungary",
"India",  
"Indonesia",               
"Iran",   
"Ireland",
"Israel", 
"Italy",  
"Japan",  
"Korea, Dem. Rep.",       
"Netherlands",
"New Zealand",
"Poland", 
"Portugal",
"Romania",
"Serbia", 
"Singapore",
"Spain",  
"Sweden", 
"Switzerland",          
"Turkey", 
"United Kingdom",          
"United States")
  

p2 + 
  geom_text_repel(mapping = aes(x = gdpPercap,
                                y = lifeExp,
                                label = country),
                  data = filter(gapminder_1997,
                                country %in% friends))


# Calculate medians at population level with for loops ----

gapminder_1997 %>% 
  arrange(gdpPercap) %>% 
  attach()

gdpPercap
pop

# First attempt
gdpPercap_pop <- c()
for (i in 1:length(pop)) {
  gdpPercap_pop <- c(gdpPercap_pop, 
                     rep(gdpPercap[i], pop[i]))
  print(c(i, length(gdpPercap_pop)))
}

# Second attempt
gc()
gdpPercap_pop <- rep(NA, sum(pop))
for (i in 1:length(pop)) {
  gdpPercap_pop <- c(gdpPercap_pop, 
                     rep(gdpPercap[i], pop[i]))
  print(c(i, length(gdpPercap_pop)))
}

# Third attempt
min(pop)

(pop2 <- round(pop/(min(pop))))

gc()
gdpPercap_pop <- c()
for (i in 1:length(pop2)) {
  gdpPercap_pop <- c(gdpPercap_pop, 
                     rep(gdpPercap[i], pop2[i]))
  print(c(i, length(gdpPercap_pop)))
}

length(gdpPercap_pop) 
sum(pop2)

median(gdpPercap_pop, na.rm = TRUE)
vl


# Application to lifeExp
min(pop)

(pop2 <- round(pop/(min(pop))))

gc()
lifeExp_pop <- c()
for (i in 1:length(pop2)) {
  lifeExp_pop <- c(lifeExp_pop, 
                     rep(lifeExp[i], pop2[i]))
  print(c(i, length(lifeExp_pop)))
}

length(lifeExp_pop) 
sum(pop2)

median(lifeExp_pop, na.rm = TRUE)
hl
