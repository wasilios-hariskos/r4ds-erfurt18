# Prepare experimental data from practice periods
library(zTree)
oldwd <- getwd()
setwd("../crossOwn/")
ztt <- zTreeTables(filelist = c("181211_1151.xls",
                                "181211_1359.xls",
                                "181211_1556.xls",
                                "181212_0835.xls",
                                "181212_1140.xls",
                                "181212_1334.xls"))
detach(package:zTree)
detach(package:plyr)
setwd(oldwd)

library(dplyr)
practice <- ztt$subjects %>% 
  filter(Treatment == 1, Period < 1) %>%
  mutate(share = Share,
         group = group_indices(., Share, Date, MatchGroup),
         subject = group_indices(., Share, Date, MatchGroup, Subject),
         period = Period,
         quantity = ChoiceA) %>% 
  select(share:quantity) %>% 
  arrange(share, group, subject, period)
  
glimpse(practice)

head(practice, 35)

tail(practice, 35)

write.csv(practice,
          file = "crossOwnPractice.csv")

# Start data analysis

practice <- read.csv("crossOwnPractice.csv")

glimpse(practice)


# 20 independent observations
indObs <- practice %>% 
  group_by(share, group) %>% 
  summarize(mean(quantity)) %>%  
  print(n = Inf)

# Boxplot: quantity by share
library(ggplot2)
ggplot(data = indObs,
       mapping = aes(x = factor(share),
                     y = `mean(quantity)`)) +
  geom_boxplot() +
  geom_jitter(width = 0.02)

# Mean and standard deviation
indObs %>% 
  group_by(share) %>% 
  summarize(mean(`mean(quantity)`),
            sd(`mean(quantity)`))

# Normality is not violated
low_share <- indObs %>%
  filter(share == 0.1)
low_share <- low_share$`mean(quantity)`
 
shapiro.test(low_share)

high_share <- indObs %>%
  filter(share == 0.4)
high_share <- high_share$`mean(quantity)`

shapiro.test(high_share)

# Equal variance is not violated
library(car)
leveneTest(y = indObs$`mean(quantity)`,
           group = indObs$share)

# t-test
t.test(x = low_share,
       y = high_share,
       alternative = "two.sided",
       var.equal = TRUE)

Period <- practice %>% 
  group_by(share, period) %>% 
  summarize(mean(quantity)) %>%  
  print(n = Inf)

ggplot(data = Period,
       mapping = aes(x = period,
                     y = `mean(quantity)`,
                     color = factor(share))) +
  geom_line() +
  geom_smooth()

# install.packages("effsize")
library("effsize")
cohen.d(d = indObs$`mean(quantity)`,
        f = indObs$share)


treatment = rnorm(100,mean = 10)
control = rnorm(100,mean = 12)
d = (c(treatment, control))
f = rep(c("Treatment","Control"),each = 100)
## compute Cohen's d
## treatment and control
cohen.d(treatment,control)

# install.packages("pwr")
library("pwr")

pwr.t.test(n = 6,
           d = 14.12094)



