# STT-2100 - Chapitre 10 - Observations aberrantes et influentes avec R
# Exemples de la fiche R, automne 2026.

# Calculer les diagnostics
donnees <- mtcars
mod <- lm(mpg ~ wt + hp, data = donnees)
n <- nobs(mod)
pprime <- length(coef(mod))
diagnostic <- data.frame(
  voiture = rownames(model.frame(mod)),
  levier = hatvalues(mod),
  standardise = rstandard(mod),
  studentise = rstudent(mod),
  cook = cooks.distance(mod),
  dffits = dffits(mod),
  covratio = covratio(mod))
diagnostic$signal <- with(diagnostic,
  levier > 2 * pprime / n | abs(studentise) > 2 |
  cook > 4 / (n - pprime))
diagnostic[order(diagnostic$cook, decreasing = TRUE), ]

# Changements des coefficients
dfbeta(mod)
dfbetas(mod)
influence.measures(mod)
par(mfrow = c(1, 2))
plot(mod, which = 4)
plot(mod, which = 5)
par(mfrow = c(1, 1))

# Analyse de sensibilité
i <- which.max(cooks.distance(mod))
rownames(donnees)[i]
mod_sans <- lm(mpg ~ wt + hp, data = donnees[-i, ])
cbind(avec = coef(mod), sans = coef(mod_sans))
profil <- data.frame(wt = 3, hp = 110)
rbind(avec = predict(mod, newdata = profil),
      sans = predict(mod_sans, newdata = profil))

# Dépistage simultané des valeurs aberrantes
alpha <- 0.05
seuil <- qt(1 - alpha / (2 * n), df = n - pprime - 1)
diagnostic[abs(diagnostic$studentise) > seuil, ]
