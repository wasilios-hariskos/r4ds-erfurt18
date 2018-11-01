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

## Vergleich von Elementen eines "unordered factor"

factor_pet_vector[1] > factor_pet_vector[2] # Vergleich macht keinen Sinn
factor_pet_vector[1] == factor_pet_vector[2] # Vergleich macht Sinn
factor_pet_vector[1] == factor_pet_vector[3] # Vergleich macht Sinn

## Ordinalskalierte kategoriale Variable (ordered factor)

temperature_vector <- c("High", "Low", "Low", "Medium")
factor_temperature_vector <- factor(temperature_vector,
                                    ordered = TRUE,
                                    levels = c("Low", "Medium", "High")
                                    )
factor_temperature_vector

## Vergleich von Elementen eines "ordered factor"

factor_temperature_vector[1] > factor_temperature_vector[2] # Vergleich macht sinn
factor_temperature_vector[2] == factor_temperature_vector[3] # Vergleich macht sinn

## Änderung des Faktorlevels (aufgrund von Klarheit)

gender <- c(0, 1, 1, 0, 1, 0, 1) # 0 bedeutet "Female" und 1 bedeutet "Male"
gender 

help(levels) # mit der levels Funktion kann man die Kodierung anpassen 

factor_gender <- factor(gender)
factor_gender

levels(factor_gender) <- c("Female", "Male")

factor_gender

## Kurzdarstellung

summary(factor_temperature_vector)
summary(pet_vector) # aufpassen, hier wir nicht der faktorisierte vektor genutzt
summary(factor_pet_vector) # besser

# Datensätze (data frames)

## Beispiel

mtcars

class(mtcars)

help(mtcars)

## Überblick gewinnen

head(mtcars)

help(head)

tail(mtcars)

str(mtcars)

help(str)

## Erstellen

help("data.frame") # see example

(L3 <- LETTERS[1:3])

(fac <- sample(L3, 10, replace = TRUE))

help(sample)

(d <- data.frame(x = 1, # vector 1
                 y = 1:10, # vector 2
                 fac = fac)) # vector 3


data.frame(1, ## The "same" with automatic column names
           1:10, 
           sample(L3, 10, replace = TRUE))

is.data.frame(d)

## Auswählen
d
d[1, 2]
d[1:3, 2:3]
d[1, ]
d[1:5, "fac"]
d$fac
d$y

## Subset: Untermengen bilden

help(subset) # see examples

str(airquality)

df1 <- subset(airquality, 
              Temp > 80, 
              select = c(Ozone, Temp))
str(df1)

df2 <- subset(airquality, 
              Day == 1, 
              select = -Temp)

str(df2)

df3 <- subset(airquality, 
              select = Ozone:Wind)

str(df3)

help("NA")

## Order: Datensätze nach Variablen ordnen

help(order) # eigenes Beispiel

v <- c(100, 10, 1000)

order(v) # was macht order

v[order(v)]  # Aufgabe: In aufsteigender reihenfolge anordnen
v[order(-v)]  # Aufgabe: In absteigender reihenfolge anordnen

head(df1)  # subset df1 von airquality nach Ozone anordnen:
df1[order(df1$Ozone), ]

help(cor) # Exkurs: Korrelation zwischen Ozone und Temp berechnen
cor(x = df1$Ozone, 
    y = df1$Temp,
    use = "complete.obs") # default value "everything" would yield NA

# Listen ----

## Erstellen

help(list) # eigenes Bespiel

vector1 <- c(4, 6, 10)
vector2 <- c("Kleine", "Hariskos", "Königstein")
vector3 <- vector2 == "Kleine"

vector3

help(matrix)
m1 <- matrix(data = 1:15, 
                  nrow = 5)
m1

m2 <- matrix(data = 15:1,
                 ncol = 5,
                 byrow = TRUE)
m2

df1 <- data.frame(m2)
df1

df2 <- head(mtcars)
df2

df3 <- tail(airquality)
df3

my_list <- list(vector1, # liste erstellen
                vector2,
                vector3,
                m1,
                m2,
                df1,
                df2,
                df3)

my_list

## Benennen

### Existierende

names(my_list) <- c("Numeric",
                   "Character",
                   "Logical",
                   "Matrix1",
                   "Matrix2",
                   "Datensatz1",
                   "Datensatz2",
                   "Datensatz3")
my_list

### Neue Liste

my_list2 <- list(Numeric = vector1, # liste erstellen
                Character = vector2,
                Logical = vector3,
                Matrix1 = m1,
                Matrix2 = m2,
                Datensatz1 = df1,
                Datensatz2 = df2,
                Datensatz3 = df3)

my_list2

## Elemente auswählen

my_list2$Datensatz3
my_list2$Datensatz3$Temp

my_list2[[8]]
my_list2[[8]][[4]]
my_list2[[8]][4]

my_list2[["Datensatz3"]]
my_list2[["Datensatz3"]]["Temp"]

my_list2$Datensatz3
my_list2$Datensatz3[4]

## Element hinzufügen

text <- "Prima, wir sind fast fertig mit der Einführung in R."
my_list3 <- c(my_list2, text)
my_list3

my_list4 <- c(my_list2, Fazit = text)
my_list4

## Überblick gewinnen

head(my_list4)

tail(my_list4)

str(my_list4)

sum(abs(c(-10, 5, -3)))^2 * 10

help(abs)
