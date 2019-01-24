help("UCBAdmissions")

require(graphics)
## Data aggregated over departments
apply(UCBAdmissions, c(1, 2), sum)
mosaicplot(apply(UCBAdmissions, c(1, 2), sum),
           main = "Student admissions at UC Berkeley")
## Data for individual departments
opar <- par(mfrow = c(2, 3), oma = c(0, 0, 2, 0))
for (i in 1:6)
  mosaicplot(UCBAdmissions[,,i],
             xlab = "Admit", ylab = "Sex",
             main = paste("Department", LETTERS[i]))
mtext(expression(bold("Student admissions at UC Berkeley")),
      outer = TRUE, cex = 1.5)
par(opar)

# Load and inspect data
library(dplyr)
ucb_admit <- read.csv2(file = "ucb_admit.csv") 
glimpse(ucb_admit)
summary(ucb_admit)

#FIND: Number of males and females admitted

# Count number of male and female applicants admitted
ucb_counts <- ucb_admit %>%
  count(Admit, Gender)

# View result
ucb_counts

# Spread the output across columns
library(tidyr)
ucb_counts2 <- ucb_counts %>%
  spread(Admit, n)

# View result
ucb_counts2

# FIND: Proportion of males admitted overall
ucb_counts2 %>%
  # Create new variable
  mutate(Perc_Admit = Admitted / (Admitted + Rejected))

# FIND: Proportion of males admitted for each department
# Table of counts of admission status and gender for each department
admit_by_dept <- ucb_admit %>%
  count(Admit, Dept, Gender) %>%
  spread(Admit, n)

# View result
admit_by_dept


# Percentage of those admitted to each department
admit_by_dept %>%
  mutate(Perc_Admit = Admitted  / (Admitted + Rejected))
