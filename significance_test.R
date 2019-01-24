# Quelle: Intro to Statistics with R: Student's T-test

# Import working memory dataset----
wm <- read.delim("working_memory_data.txt",
                 sep = "")
library("dplyr")
glimpse(wm)

wm$train <- as.factor(wm$train)
glimpse(wm)

## Dependent t-test ##----

# Preliminary statistics----
summary(wm)
library("psych")
describe(wm)

# Create training subset of wm
wm_t <- subset(wm, 
               wm$train == 1)

wm_t2 <- wm %>% filter(train == 1)

# Create a boxplot with pre- and post-training groups 
boxplot(wm_t$pre, wm_t$post , main = "Boxplot",
        xlab = "Pre- and Post-Training", ylab = "Intelligence Score", 
        col = c("red", "green"))


# Conduct a paired t-test using the t.test function----
t.test(x = wm_t$post, y = wm_t$pre, paired = TRUE)

# Calculate Cohen's d-----
cohensD(x = wm_t$post, y = wm_t$pre, method = "paired")
# Check results----

# Define the sample size
n <- nrow(wm_t)

# Mean of the difference scores
mean_diff <- sum(wm_t$gain) / n

# Standard deviation of the difference scores
sd_diff <- sqrt(sum((wm_t$gain - mean_diff)^2) / (n - 1))

# Observed t-value
t_obs <- (mean_diff - 0) / (sd_diff / sqrt(n))

# Print observed t-value
t_obs

# Compute the critical value
t_crit <- qt(p = 0.975, df = n - 1)

# Print the critical value
t_crit

# Print the observed t-value to compare 
t_obs

# Compute Cohen's d
cohens_d = mean_diff / sd_diff

# View Cohen's d
cohens_d


#install.packages("lsr")
library("lsr")




## Independent t-test ##----

# Preliminary statistics----
wm_t

# Create subsets for each training time
wm_t08 <- subset(wm_t, wm_t$cond == "t08")
wm_t12 <- subset(wm_t, wm_t$cond == "t12")
wm_t17 <- subset(wm_t, wm_t$cond == "t17")
wm_t19 <- subset(wm_t, wm_t$cond == "t19")

# Summary statistics for the change in training scores before and after training
describe(wm_t08)
describe(wm_t12)
describe(wm_t17)
describe(wm_t19)

# Create a boxplot of the different training times
library("ggplot2")
ggplot(wm_t, aes(x = cond, y = gain, fill = cond)) + geom_boxplot()

# Levene's test----
library(car)
leveneTest(wm_t$gain ~ wm_t$cond)

# Conduct an independent t-test----
t.test(x = wm_t19$gain, y = wm_t08$gain, 
       var.equal = TRUE)

# Calculate Cohen's d----
cohensD(x = wm_t19$gain, y = wm_t08$gain, method = "pooled")

# Check results----

# Find the mean intelligence gain for both the 8 and 19 training day group
(mean_t08 <- mean(wm_t08$gain))
(mean_t19 <- mean(wm_t19$gain))

# Calculate mean difference by subtracting t08 by t19
(mean_diff <- mean_t19 - mean_t08)

# Determine the number of subjects in each sample
(n_t08 <- nrow(wm_t08))
(n_t19 <- nrow(wm_t19))

# Calculate degrees of freedom
df <- n_t08 + n_t19 - 2

# Calculate variance for each group
(var_t08 <- var(wm_t08$gain))
(var_t19 <- var(wm_t19$gain))

# Compute pooled standard error
se_pooled <- sqrt(var_t08 / n_t08 + var_t19 / n_t19)

# Calculate the t-value
(t_value <- mean_diff / se_pooled)

# Calculate p-value
p_value <- 2 * (1 - pt(q = t_value, df = df))

# Calculate standard deviations
sd_t08 <- sd(wm_t08$gain)
sd_t19 <- sd(wm_t19$gain)

# Calculate the pooled standard deviation
pooled_sd <- (sd_t08 + sd_t19) / 2

# Calculate Cohen's d
(cohens_d <- mean_diff / pooled_sd)



