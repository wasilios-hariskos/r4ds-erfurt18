library(ggplot2)
library(dplyr)
library(moderndive)
# install.packages("ISLR")
library(ISLR)
library(skimr)

glimpse(Credit)

Credit <- Credit %>%
  select(Balance, Limit, Income, Rating, Age)

glimpse(Credit)

View(Credit)

Credit %>% 
  select(Balance, Limit, Income) %>% 
  skim()

Credit %>% 
  get_correlation(Balance ~ Limit)

Credit %>% 
  get_correlation(Balance ~ Income)

Credit %>%
  select(Balance, Limit, Income) %>% 
  cor()

library(ISLR)
library(plotly)
plot_ly(showscale=FALSE) %>%
  add_markers(
    x = Credit$Income,
    y = Credit$Limit,
    z = Credit$Balance,
    hoverinfo = 'text',
    text = ~paste("x1 - Income: ", Credit$Income, 
                  "</br> x2 - Limit: ", Credit$Limit, 
                  "</br> y - Balance: ", Credit$Balance)
  ) %>% 
  layout(scene = list(
      xaxis = list(title = "x1 - Income (in $10K)"),
      yaxis = list(title = "x2 - Limit ($)"),
      zaxis = list(title = "y - Balance ($)")
    )
  )

Balance_model <- lm(Balance ~ Limit + Income, data = Credit)
get_regression_table(Balance_model)

summary(Balance_model)

regression_points <- get_regression_points(Balance_model)
print(regression_points, n = Inf)
tail(regression_points)

evals_ch7 <- evals %>%
  select(score, age, gender) %>% 
  mutate(gender = as.numeric(gender))

evals_ch7 <- evals_ch7 %>%
  mutate(gender = ifelse(gender == 1, 
                         "female", "male"),
         gender = as.factor(gender))

View(evals_ch7)

evals_ch7 %>% 
  skim()

evals_ch7 %>% 
  get_correlation(formula = score ~ age)

ggplot(evals_ch7, aes(x = age, y = score, color = gender)) +
  geom_point() +
  labs(x = "Age", y = "Teaching Score", color = "Gender") +
  geom_smooth(method = "lm", se = FALSE)


score_model_2 <- lm(score ~ age + gender, data = evals_ch7)
get_regression_table(score_model_2)


score_model_interaction <- lm(score ~ age * gender, data = evals_ch7)
get_regression_table(score_model_interaction)


regression_points <- get_regression_points(score_model_interaction)
regression_points

score_model_interaction2 <- lm(score ~ age + gender:age, data = evals_ch7)
get_regression_table(score_model_interaction)



