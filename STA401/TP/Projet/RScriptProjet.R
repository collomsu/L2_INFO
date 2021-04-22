#Cr�ation des variables avec les donn�es r�colt�es (en min)
res <- read.table('Data-Collomb-Sullivan.csv', header=TRUE, sep=',')
midi <- res$Midi
soir <- res$Soir

#Summary des r�sultats
summary(res)

#Ecart-type pour midi et soir
sd(midi)
sd(soir)

#Graphique

#boxplot
boxplot(midi,soir, main="Temps de repas le midi et le soir (en min)", ylab="Temps (en min)", names=c("Midi","Soir"))

#histogramme
par(mfrow=c(1,2))
plot(hist(midi, main=""))
curve(dnorm(x,mean(midi),sd(midi)))
hist(soir, main="")

#quantile-quantile plot
par(mfrow=c(1,2))
qqnorm(midi, main="histogramme des r�sultats du midi")
qqline(midi)
qqnorm(soir, main="histogramme des r�sultats du soir")
qqline(soir)