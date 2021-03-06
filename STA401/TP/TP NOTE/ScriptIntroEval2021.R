#Chargement des donn�es et affectation � un data.frame appel�notes
###################################################################
setwd("~/GitHub/L2_INFO/STA401/TP/TP NOTE")
read.table("DonneesEvalTP2021.txt",header=T,sep="\t",dec=",")->notes
head(notes)
summary(notes) 


sd(notes[notes$GTP == 1,"partiel"])

#60 etudiants (1 par ligne) et 12 variables 
#GTD deux modalit�s 1 ou 2 
#GTP trois modalit�s 1, 2 ou 3 
#EX1 1 si EX1 du partiel bien fait et 0 sinon (variable num�rique discr�te)
#colles (sur 20) : � valeur dans [0,20]
#DM1 (sur 20) : � valeurs dans [0,20]
#DM2et3 (sur 20) : idem
#quizz (sur 20)
#partiel (sur 20)
#EvalTP (sur 20) : tous les etudiants ont 10
#CC1 (sur 20) : Notes de CC1 construite avec partiel DM1 et quizz
#CC2 (sur 20) : Notes de CC2 construite avec DM2et3 colles et EvalTP

#Savoir  Extraire un �chantillon complet (avec toutes les lignes) ou  un sous-�chantillon (sélection de lignes)
############################################################################################

notes$Sexe #echantillon des sexes pour tous les etudiants du fichier ou
length(notes[,12])
notes$Sexe[notes$Sexe==1] #echantillon des sexes pour les garçons on peut aussi executer
notes[notes$Sexe==1,12]
length(notes$Sexe[notes$Sexe==1]) #nombre de garçons parmi les 60 etudiants

#autre exemple : echantillon des notes de CC2 de tous
notes$CC2

#et le sous echantillons des notes de CC2 du GTP3 avec
notes[notes$GTP==3,11]  #ou encore avec 
notes$CC2[notes$GTP==3] #ou encore
notes[notes$GTP == 3,"CC2"]


#pour un probl�me sur une proba inconnue p par ex celle d'obtenir une note de partiel>10
#on construit l'�chantillon de Bernoulli affect� ici � x
notes$partiel>10->x
sum(x) #nombre de succès dans l'échantillon de partiel>10
length(x) #nombre d'essais (= taille de l'�chantillon)
sum(x)/length(x) # estimation de p

#Pour selectionner la note de quizz de tout des �tudiants des groupes de TP 1 et 3 : 
notes$quizz[notes$GTP == 1 |notes$GTP == 3 ]
#ou 
notes[notes$GTP == 1 |notes$GTP == 3,"quizz"]

