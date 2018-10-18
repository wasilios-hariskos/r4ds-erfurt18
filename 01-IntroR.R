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

x > y

x >= y

x == y

idx <- x != y

x
x[idx]

# Matrix

## Erstellen

## Benennen

## Summieren von Zeilen

## Summieren von Spalten

## Auswählen

## Rechenoperationen

# Faktoren

## Erstellen

## Nominalskalierte kategoriale Variable (unordered factor)

## Ordinalskalierte kategoriale Variable (ordered factor)

## Änderung des Faktorlevels

## Kurzdarstellung

  
