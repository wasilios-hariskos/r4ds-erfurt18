# Source: https://moderndive.com/6-regression.html

# Needed packages

# install.packages("moderndive")
# install.packages("glue")
library(ggplot2)
library(dplyr)
library(moderndive)
library(gapminder)
library(skimr)

# One numerical explanatory variable

## Exploratory data analysis ----

help(evals)

View(evals)

evals2 <- evals

evals_ch6 <- evals %>%
  select(score, 
         bty_avg, 
         age)

evals_ch6 %>% 
  sample_n(5)

glimpse(evals_ch6)

evals_ch6 %>% 
  select(score, 
         bty_avg) %>% 
  skim()

evals_ch6 %>% 
  get_correlation(formula = score ~ bty_avg)

cor(x = evals_ch6$bty_avg, 
    y = evals_ch6$score)

ggplot(data = evals_ch6) +
  geom_point(mapping = aes(x = bty_avg, 
                           y = score)) +
  labs(x = "Beauty Score", 
       y = "Teaching Score", 
       title = "Relationship of teaching and beauty scores")

ggplot(data = evals_ch6) +
  geom_jitter(mapping = aes(x = bty_avg, 
                            y = score)) +
  labs(x = "Beauty Score", 
       y = "Teaching Score", 
       title = "Relationship of teaching and beauty scores")

ggplot(evals_ch6, aes(x = bty_avg, y = score)) +
  geom_point() +
  labs(x = "Beauty Score", y = "Teaching Score", 
       title = "Relationship of teaching and beauty scores") +  
  geom_smooth(method = "lm")

ggplot(evals_ch6, aes(x = bty_avg, y = score)) +
  geom_point() +
  labs(x = "Beauty Score", y = "Teaching Score", 
       title = "Relationship of teaching and beauty scores") +
  geom_smooth(method = "lm", se = FALSE)

## Simple linear regression ----

score_model <- lm(score ~ bty_avg, data = evals_ch6)
score_model

get_regression_table(score_model)

## Observed/fitted values and residuals

regression_points <- get_regression_points(score_model)
regression_points[21:24,]

index <- which(evals_ch6$bty_avg == 7.333 & evals_ch6$score == 4.9)


target_point <- score_model %>% 
  get_regression_points() %>% 
  slice(index)

x_obs <- target_point$bty_avg
y_obs <- target_point$score
y_hat <- target_point$score_hat
best_fit_plot <- ggplot(evals_ch6, 
                        aes(x = bty_avg, y = score)) +
  geom_point() +
  labs(x = "Beauty Score", y = "Teaching Score", 
       title = "Relationship of teaching and beauty scores") + 
  geom_smooth(method = "lm", se = FALSE) +
  annotate("point", x = x_obs, y = y_obs, col = "red", size = 3) +
  annotate("point", x = x_obs, y = y_hat, col = "red", shape = 15, size = 3) +
  annotate("segment", x = x_obs, xend = x_obs, y = y_obs, yend = y_hat, color = "blue",
           arrow = arrow(type = "closed", length = unit(0.02, "npc")))
best_fit_plot

## Residual analysis

ggplot(regression_points, aes(x = bty_avg, y = residual)) +
  geom_point() +
  labs(x = "Beauty Score", y = "Residual") +
  geom_hline(yintercept = 0, col = "blue", size = 1)

resid_ex <- evals_ch6
resid_ex$ex_1 <- ((evals_ch6$bty_avg - 5) ^ 2 - 6 + rnorm(nrow(evals_ch6), 0, 0.5)) * 0.4
resid_ex$ex_2 <- (rnorm(nrow(evals_ch6), 0, 0.075 * evals_ch6$bty_avg ^ 2)) * 0.4
resid_ex <- resid_ex %>%
  select(bty_avg, ex_1, ex_2) %>%
  gather(type, eps, -bty_avg) %>% 
  mutate(type = ifelse(type == "ex_1", "Example 1", "Example 2"))
ggplot(resid_ex, aes(x = bty_avg, y = eps)) +
  geom_point() +
  labs(x = "Beauty Score", y = "Residual") +
  geom_hline(yintercept = 0, col = "blue", size = 1) +
  facet_wrap(~type)

ggplot(regression_points, aes(x = residual)) +
  geom_histogram(binwidth = 0.25, color = "white") +
  labs(x = "Residual")

resid_ex <- evals_ch6
resid_ex$`Ideal` <- rnorm(nrow(resid_ex), 0, sd = sd(regression_points$residual))
resid_ex$`Less than ideal` <-
  rnorm(nrow(resid_ex), 0, sd = sd(regression_points$residual))^2
resid_ex$`Less than ideal` <- resid_ex$`Less than ideal` - mean(resid_ex$`Less than ideal` )
resid_ex <- resid_ex %>%
  select(bty_avg, `Ideal`, `Less than ideal`) %>%
  gather(type, eps, -bty_avg)
ggplot(resid_ex, aes(x = eps)) +
  geom_histogram(binwidth = 0.25, color = "white") +
  labs(x = "Residual") +
  facet_wrap( ~ type, scales = "free")


# One categorical explanatory variable

## Exploratory data analysis

gapminder2007 <- gapminder %>%
  filter(year == 2007) %>% 
  select(country, continent, lifeExp, gdpPercap)

View(gapminder2007)

glimpse(gapminder2007)

gapminder2007 %>% 
  select(continent, lifeExp) %>% 
  skim()


ggplot(gapminder2007, aes(x = lifeExp)) +
  geom_histogram(binwidth = 5, color = "white") +
  labs(x = "Life expectancy", y = "Number of countries", 
       title = "Worldwide life expectancy")

lifeExp_by_continent <- gapminder2007 %>%
  group_by(continent) %>%
  summarize(median = median(lifeExp), mean = mean(lifeExp))
lifeExp_by_continent

ggplot(gapminder2007, aes(x = lifeExp)) +
  geom_histogram(binwidth = 5, color = "white") +
  labs(x = "Life expectancy", y = "Number of countries", 
       title = "Life expectancy by continent") +
  facet_wrap(~ continent, nrow = 2)

ggplot(gapminder2007, aes(x = continent, y = lifeExp)) +
  geom_boxplot() +
  labs(x = "Continent", y = "Life expectancy (years)", 
       title = "Life expectancy by continent") 

## Linear regression

lifeExp_model <- lm(lifeExp ~ continent, 
                    data = gapminder2007)
get_regression_table(lifeExp_model)


## Observed/fitted values and residuals

regression_points <- get_regression_points(lifeExp_model)
regression_points

## Residual analysis

ggplot(regression_points, aes(x = continent, y = residual)) +
  geom_jitter(width = 0.1) + 
  labs(x = "Continent", y = "Residual") +
  geom_hline(yintercept = 0, col = "blue")

gapminder2007 %>%
  filter(continent == "Asia") %>%
  arrange(lifeExp)

ggplot(regression_points, aes(x = residual)) +
  geom_histogram(binwidth = 5, color = "white") +
  labs(x = "Residual")

