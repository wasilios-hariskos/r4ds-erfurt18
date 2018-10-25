# Basics

## Zuweisung einer Variablen

(meine_variable <- 4)
print(meine_variable)
meine_variable

## Rechenoperationen

a <- 2
b <- 5
c <- 3

a + b

a + c

a - c

a * c

a / b
a / 0

a^b

b %% a # modulo

4 %% 2 

## Datentypen

d <- 4.5 # numeric

class(d)

e <- TRUE
e <- T
e <- FALSE
e <- F

class(e)

f <- "Hans"

g <- 2 < 3

class(f)
# Vektoren

## Erstellen

v1 <- 1:5

v2 <- c(2, 2, 3, 4, 5)
c(2, 2:5)

## Benennen

some_vector <- c("John Doe", "poker player")
names(some_vector) <- c("Name", "Profession")

some_vector

## Addition

v1 + v2

v3 <- c(1, 2, 3) + c(4, 5, 6)
v4 <- c(1 + 4, 2 + 5, 3 + 6)


2 -> h # exkurs

## Summieren 

sum(c(1, 2, 5))

sum(v4)

sum(v3 == v4)

## Auswählen

v2[1]
v1[1]

v2[2]
v1[2]

some_vector[c("Profession", "Name")]

some_vector[c(2, 1)]

v1[c(1, 5)]

v1[2:4]

v1[v1 > 3]

## Auswählen durch Vergleich

x <- c(2, 5, 7)
y <- 2

x > y

x >= y

x == y

idx <- x != y

x
x[idx]

# Matrix

## Erstellen

help(matrix)

matrix(data = 1:9, 
       nrow = 3,
       byrow = TRUE)

matrix(1:9, 3, 3, TRUE)

matrix(nrow = 3,
       byrow = TRUE,
       data = 1:9)

help(c)

my_matrix <- matrix(data = 1:9,
                    nrow = 3,
                    ncol = 3,
                    byrow = FALSE)

?c

## Benennen
help(rownames)
rownames(my_matrix) <- c("row 1", "row 2", "row 3")
my_matrix
colnames(my_matrix) <- c("col 1", "col 2", "col 3")
my_matrix

help(matrix)

matrix(data = 1:9,
       nrow = 3,
       ncol = 3,
       byrow = FALSE,
       dimnames = list(c("row 1", "row 2", "row 3"),
                       c("col 1", "col 2", "col 3"))
       )

??matrix # exkurs

## Summieren von Zeilen

rowSums(my_matrix)

## Summieren von Spalten

colSums(my_matrix)

## Zeilen oder Spalten hinzufügen

v5 <- c(3, 5, 7)

rbind(my_matrix, my_matrix, v5)

cbind(my_matrix, my_matrix, c(1, 1, 1))

rbind(my_matrix, my_matrix, c("3", "5", "7"))

## Auswählen

my_matrix[1, 2]

my_matrix[1:2, 2:3]

my_matrix[, 1]

my_matrix[1, ]

my_matrix[1, 1:3]

dim(matrix(1:8, 4))

x <- 1:12 ; dim(x) <- c(3,4)
x

## Rechenoperationen

my_matrix * my_matrix

my_matrix ^ 2

my_matrix + my_matrix

my_matrix - my_matrix

my_matrix / my_matrix

my_matrix %*% my_matrix

2 * my_matrix

# Faktoren

## Erstellen
?factor

sex_vector <- c("Male", "Female", "Female", "Male")

factor(sex_vector)

## Nominalskalierte kategoriale Variable (unordered factor)

pet_vector <- c("Dog", "Cat", "Dog")
factor_pet_vector <- factor(pet_vector)
factor_pet_vector

## Ordinalskalierte kategoriale Variable (ordered factor)

temperature_vector <- c("High", "Low", "Low", "Medium")
factor_temperature_vector <- factor(temperature_vector,
                                    ordered = TRUE,
                                    levels = c("Low", "Medium", "High")
                                    )
factor_temperature_vector



## Änderung des Faktorlevels

help(levels) # ...

## Kurzdarstellung

summary(factor_temperature_vector)
summary(pet_vector)
summary(factor_pet_vector)

  
