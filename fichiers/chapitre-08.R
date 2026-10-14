# STT-2100 - Chapitre 8 - Choix et validation de modèle avec R
# Exemples de la fiche R, automne 2026.

# Comparer des modèles candidats
donnees <- na.omit(mtcars[c("mpg", "wt", "hp", "qsec")])
m1 <- lm(mpg ~ wt, data = donnees)
m2 <- lm(mpg ~ wt + hp, data = donnees)
m3 <- lm(mpg ~ wt + hp + qsec, data = donnees)
AIC(m1, m2, m3)
BIC(m1, m2, m3)
sapply(list(m1, m2, m3), function(m) summary(m)$adj.r.squared)

# Vérifier les postulats
par(mfrow = c(2, 2))
plot(m3)
par(mfrow = c(1, 1))
# PRESS : validation leave-one-out d'un modele fixe
press <- function(m) {
  h <- hatvalues(m)
  if (any(h >= 1 - 1e-10)) stop("Levier trop proche de 1")
  sum((residuals(m) / (1 - h))^2)
}
sapply(list(m1 = m1, m2 = m2, m3 = m3), press)

# Validation croisée de modèles fixés à l’avance
set.seed(2100)
K <- 5
pli <- sample(rep(seq_len(K), length.out = nrow(donnees)))
formules <- list(mpg ~ wt, mpg ~ wt + hp,
                 mpg ~ wt + hp + qsec)
eqm_cv <- function(formule) {
  erreurs <- numeric(nrow(donnees))
  for (k in seq_len(K)) {
    test <- pli == k
    ajuste <- lm(formule, data = donnees[!test, ])
    pred <- predict(ajuste, newdata = donnees[test, ])
    erreurs[test] <- (donnees$mpg[test] - pred)^2
  }
  mean(erreurs)
}
sapply(formules, eqm_cv)

# Sélection algorithmique
selection_aic <- step(m3, direction = "both", trace = 0)
selection_bic <- step(m3, direction = "both", trace = 0,
                      k = log(nrow(donnees)))
formula(selection_aic)
formula(selection_bic)
