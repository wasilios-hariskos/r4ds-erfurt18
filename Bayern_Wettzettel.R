#Bayernwahl Wette, wer hat am besten gesch?tzt (niedrigste absolute summierte Abweichung)
#Wettzettel
Frank <- c(37, 12, 18, 8, 3, 12)
Uli <- c(37.5, 12.5, 19, 7, 4.5, 12)
Siggi <- c(33, 12, 18, 7, 4, 15)
Giga <- c(30, 10, 17, 5, 4, 17)
Paul <- c(40, 11, 18, 9, 3, 13)

#alternativer Weg aber nicht so strukturiert
expectations <- c(37, 12, 18, 8, 3, 12, 37.5, 12.5, 19, 7, 4.5, 12, 33, 12, 18,
                  7, 4, 15, 30, 10, 17, 5, 4, 17, 40, 11, 18, 9, 3, 13)
# WH: Alternative
expectations2 <- c(Frank, Uli, Siggi, Giga, Paul)
alternativmatrix <- matrix(expectations, 
                           nrow = 5, 
                           byrow = TRUE,
                           dimnames = list(c("Frank", "Uli", "Siggi", "Giga", "Paul"),
                                           c("CDU", "SPD", "B90", "FDP", "Linke", "AFD")))
alternativmatrix


#strukturierter Weg
mat <- rbind(Frank, Uli, Siggi, Giga, Paul)
colnames(mat) <- c("CDU", "SPD", "B90", "FDP", "LINKE", "AFD")
mat
Wahlergebnisse <- c(37.2, 9.7, 17.5, 5.1, 3.2, 10.2)
#strukturiert
mat2 <- matrix(Wahlergebnisse, nrow = 5, ncol = 6, byrow = TRUE)

mat3 <- mat - mat2
mat3
#Zugreifen
mat3[1, ]
Endergebnis <- matrix(c(sum(abs(mat3[1, ])), 
                        sum(abs(mat3[2, ])), 
                        sum(abs(mat3[3, ])),
                        sum(abs(mat3[4, ])),
                        sum(abs(mat3[5, ]))), 
                      nrow = 5, 
                      dimnames = list(c(c("Frank", "Uli", "Siggi", "Giga", "Paul"))))
Endergebnis

## WH: Die Zeilen 30 bis 37 können durch eine Zeile ersetzt werden
rowSums(abs(mat3))


#Versuch: Matrix - Vektor (Wahlergebnisse nicht zu einer Matrix machen)
print(mat - Wahlergebnisse)
#er subtrahiert "senkrecht" ich brauche aber waagrechte Subtraktion 

is.vector(Wahlergebnisse)

is.matrix(t(Wahlergebnisse))

vec2 <- as.vector(t(Wahlergebnisse))

print(mat - vec2)

print(t(t(mat) - Wahlergebnisse))


#sweep funktioniert (Online gefunden), wieso? 
(mat5 <- sweep(mat, 2, Wahlergebnisse))
help(sweep)
#verstehe nicht genau was sweep macht
#wieso brauche ich margin 2 und nicht 1? 1 w?re doch Reihe 

#2. Generation FW inkl.
Giga <- c(30, 10, 17, 5, 4, 17, 8)
Paul <- c(40, 11, 18, 9, 3, 13, 6)
Josua <- c(32, 10.5, 17.5, 6, 5, 16, 13)
Matthias <- c(38, 15, 18, 5, 6.5, 16, 4)
Louis <- c(33, 12, 20, 6, 8, 12, 8)
Simon <- c(35, 14, 19, 8, 4.5, 10.5, 10)
Uli <- c(37.5, 12.5, 19, 7, 4.5, 12, 5.5)
Siggi <- c(33, 12, 18, 7, 4, 15, 11)

# WH: Umlaute sind problematisch
# Sch?tzmatrix <- rbind(Giga, Paul, Josua, Matthias, Louis, Simon, Uli, Siggi)
Schaetzmatrix <- rbind(Giga, Paul, Josua, Matthias, Louis, Simon, Uli, Siggi)

colnames(Schaetzmatrix) <- c("CDU", "SPD", "B90", "FDP", "LINKE", "AFD", "FW")
Schaetzmatrix
Wahlergebnissefw <- c(37.2, 9.7, 17.6, 5.1, 3.2, 10.2, 11.6 )
Wahlergebnissefwmat <- matrix(Wahlergebnissefw, nrow = 8, ncol = 7, byrow = TRUE)

Ergebnisfw <- Schaetzmatrix - Wahlergebnissefwmat
Ergebnisfw
Ergebnisranking <- matrix(c(sum(abs(Ergebnisfw[1, ])), 
                            sum(abs(Ergebnisfw[2, ])), 
                            sum(abs(Ergebnisfw[3, ])),
                            sum(abs(Ergebnisfw[4, ])),
                            sum(abs(Ergebnisfw[5, ])),
                            sum(abs(Ergebnisfw[6, ])),
                            sum(abs(Ergebnisfw[7, ])),
                            sum(abs(Ergebnisfw[8, ]))),
                            nrow = 8, 
                            dimnames = list(c("Giga", "Paul", "Josua", "Matthias", "Louis", "Simon", "Uli", "Siggi")
                                          ))
Ergebnisranking
Ergebnisranking2 <- rowSums(abs(Ergebnisfw))
Ergebnisranking2

# WH: Einzeiler als Alternative (mit der Pipe zur Illustration)
library("dplyr")
Ergebnisfw %>% abs() %>% rowSums() %>% sort()

#Detailschau
CSUdif <- matrix(Ergebnisfw[ , 1], dimnames = list(c("Giga", "Paul", "Josua", "Matthias", "Louis", "Simon", "Uli", "Siggi"),
                                                   c("CSU")))
SPDdif <- matrix(Ergebnisfw[ , 2], dimnames = list(c("Giga", "Paul", "Josua", "Matthias", "Louis", "Simon", "Uli", "Siggi"),
                                                   c("SPD")))
B90dif <- matrix(Ergebnisfw[ , 3], dimnames = list(c("Giga", "Paul", "Josua", "Matthias", "Louis", "Simon", "Uli", "Siggi"),
                                                   c("B90")))
FDPdif <- matrix(Ergebnisfw[ , 4], dimnames = list(c("Giga", "Paul", "Josua", "Matthias", "Louis", "Simon", "Uli", "Siggi"),
                                                   c("FDP")))
LINKEdif <- matrix(Ergebnisfw[ , 5], dimnames = list(c("Giga", "Paul", "Josua", "Matthias", "Louis", "Simon", "Uli", "Siggi"),
                                                     c("LINKE")))
AFDdif <- matrix(Ergebnisfw[ , 6], dimnames = list(c("Giga", "Paul", "Josua", "Matthias", "Louis", "Simon", "Uli", "Siggi"),
                                                   c("AFD")))
FWdif <- matrix(Ergebnisfw[ , 7], dimnames = list(c("Giga", "Paul", "Josua", "Matthias", "Louis", "Simon", "Uli", "Siggi"),
                                                  c("FW")))
CSUdif
SPDdif
B90dif
FDPdif
LINKEdif
AFDdif
FWdif

# WH: Kürzere Alternative für CSUdif
class(Ergebnisfw) # zur info
df <- data.frame(Ergebnisfw)
class(df) # zur info
df %>% select(CDU, FW)

select(df, CDU)


# WH: Was macht Sweep? (siehe Bsp.)

require(stats) # for median
med.att <- apply(attitude, 2, median)
sweep(data.matrix(attitude), 2, med.att)  # subtract the column medians

class(attitude)
class(data.matrix(attitude))

# WH: Mechanismus nachvollziehen
head(attitude)
head(med.att)
head(sweep(data.matrix(attitude), 2, med.att))









     