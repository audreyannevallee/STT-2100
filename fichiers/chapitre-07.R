# STT-2100 - Chapitre 7 - Variables catégoriques et interactions avec R
# Exemples de la fiche R, automne 2026.

# Choisir le niveau de référence
donnees <- iris
donnees$Species <- relevel(factor(donnees$Species),
                            ref = "setosa")
mod_add <- lm(Sepal.Length ~ Petal.Length + Species,
              data = donnees)
contrasts(donnees$Species)
head(model.matrix(mod_add))
summary(mod_add)

# Inclure et tester les interactions
mod_int <- lm(Sepal.Length ~ Petal.Length * Species,
              data = donnees)
summary(mod_int)
# Test conjoint des deux interactions : pentes paralleles
anova(mod_add, mod_int, test = "F")
# Utilite globale de Species dans le modele additif
mod_sans <- lm(Sepal.Length ~ Petal.Length, data = donnees)
anova(mod_sans, mod_add, test = "F")

# Centrer et interpréter les pentes
donnees$petale_c <- donnees$Petal.Length - 4
mod_c <- lm(Sepal.Length ~ petale_c * Species,
            data = donnees)
summary(mod_c)
b <- coef(mod_int)
c(setosa = unname(b["Petal.Length"]),
  versicolor = unname(b["Petal.Length"] +
                       b["Petal.Length:Speciesversicolor"]),
  virginica = unname(b["Petal.Length"] +
                      b["Petal.Length:Speciesvirginica"]))

# Prédire avec les mêmes niveaux
profils <- data.frame(
  Petal.Length = c(1.5, 4, 5.5),
  Species = factor(c("setosa", "versicolor", "virginica"),
                   levels = levels(donnees$Species)))
predict(mod_int, newdata = profils, interval = "confidence")
