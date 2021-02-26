#--------------COMMANDE DE BASE----------------

#set espace de travail
setwd("~/L2 INFO/STA401/TP")

#stock les valeurs de 1 � 10 dans une var
init<-1:10

#affichage d'une var
init

#cr�er une suite de donn�es
suite <- c(1,5,3,2,47)
suite

#valeur a l'emplacement 2 de la suite de donn�es (start from 1)
suite[2]

#obtenir elem d'indice 1 et 4
suite[c(1,4)]

#cr�er matrice de 5 lignes et 2 colonnes
matrice <- matrix(c(suite,suite), ncol=2, byrow=F)
matrice

#Affiche d'un �l�ment de ligne 1 et colonne 2
matrice[1,2]

#Affichage de la colonne 1 et la ligne 2
matrice[,1]
matrice[2,]

#Somme total d'une suite
sum(suite)

#Somme pas par pas de la suite (du 1er au dernier element)
cumsum(suite)

#Longueur d'une suite (nb elem)
length(suite)

#Racine d'un objet (racine de chaque element d'une suite par exemple)
sqrt(suite)

#Puissance
2^3

#Repete un element nb fois demand�
rep("a",5)
rep(1,10)

#Afficher suite + une valeur en plus
c(suite,200)

#S�quence de 1 � 10 avec pas de 2 (+ autre m�thode)
seq(1,10,2)
seq(from=1,to=10,by=2)
seq(from=1,to=2,by=.2)

#Condition sur suite (renvoie indice v�rifiant la condition)
which(suite>2)

#Afficher data.frame
mtcars    

#Nom de variable
names(mtcars)

#Premi�res lignes d'un tableau
head(mtcars)

#Extraire variable d'un data.frame
mtcars$mpg

#-----------------GRAPHIQUE------------------

#Boite de distribution
boxplot(mpg,main = "distance en milles parcourue par gallon ",ylab = "miles")

#Diagramme en secteur (avec la var utilis�e)
barplot(table(mtcars$am))
table(mtcars$am)

#Partitionner la fen�tre graphique
par(mfrow=c(1,2))

#---------------STATISTIQUES----------------

#Calcul de la moyenne et la variance sur un jeu de donn�es
cyl <- mtcars$cyl

s = sum(cyl)
moyenne = s/length(cyl)
moyenne

s2 = sum(cyl^2)
variance = s2/length(cyl)-moyenne
variance

#Fonction moyenne, variance, ecart-type et quantile de Rstudio
mean(cyl)
var(cyl)
sd(cyl)
quantile(cyl)

#Fr�quence d'une table
prop.table(mtcars$am)