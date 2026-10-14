# STT-2100 - Chapitre 6 - Inférence pour la RLM avec R
# Exemples de la fiche R, automne 2026.

# Ajuster et faire de l’inférence sur les coefficients
donnees <- mtcars
mod <- lm(mpg ~ wt + hp, data = donnees)
summary(mod)
confint(mod, level = 0.95)
vcov(mod)
# Tester H0 : beta_hp = 0 contre H1 : beta_hp != 0
summary(mod)$coefficients["hp", ]

# Comparer des modèles emboîtés
mod_reduit <- lm(mpg ~ wt, data = donnees)
anova(mod_reduit, mod, test = "F")
# Une seule formule produit des tests sequentiels,
# dans l'ordre des termes : ce ne sont pas les tests partiels.
anova(mod)

# Réponse moyenne et nouvelle observation
profil <- data.frame(wt = 3, hp = 110)
predict(mod, newdata = profil, interval = "confidence")
predict(mod, newdata = profil, interval = "prediction")

# Une combinaison linéaire des coefficients
a <- c(1, 3, 110)
theta <- drop(a %*% coef(mod))
se_theta <- sqrt(drop(t(a) %*% vcov(mod) %*% a))
q <- qt(0.975, df.residual(mod))
c(estimation = theta, bas = theta - q * se_theta,
  haut = theta + q * se_theta)
