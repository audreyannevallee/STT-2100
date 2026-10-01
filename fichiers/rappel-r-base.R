# Rappels R - STT-2100


# Repertoire courant
setwd("chemin...")

# Lecture de fichier texte (examens.txt)
exam <- read.table("examens.txt", header = T)

# Afficher un appercu
head(exam)

# Renommer les colonnes
colnames(exam) <- c("e1", "e2", "e3")

# Calcul de stats descriptives
mean(exam$e1)
summary(exam)

# Ajout d'une variable numerique
exam$moy <- with( exam, (e1 + e2 + e3)/3 )

# Ajout d'une variable categorique
exam$passe <- ifelse( exam$moy >= 60, "Reussi", "echou?" )

# Diagramme a bandes
barplot( table(exam$passe), space = 1.5, ylim = c(0, 140), col = "red" )
abline( h = 0 )

# Diagramme de dispersion
with( exam, 
      plot( x=e1, y=e2, pch=19, xlab="Note examen 1", ylab="Note examen 2",
      main="Relation entre les notes des 2 premiers examens"))

plot( x=exam$e1, y=exam$e2, pch=19, xlab="Note examen 1", ylab="Note examen 2",
      main="Relation entre les notes des 2 premiers examens")
