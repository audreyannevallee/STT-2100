# STT-2100 - Chapitre 11 - Techniques de régression avancées avec R
# Exemples de la fiche R, automne 2026.

# Régression polynomiale
mod_lin <- lm(dist ~ speed, data = cars)
mod_quad <- lm(dist ~ speed + I(speed^2), data = cars)
anova(mod_lin, mod_quad, test = "F")
summary(mod_quad)
# Conserver les termes de degre inferieur.
plot(cars)
grille <- data.frame(speed = seq(min(cars$speed),
                                max(cars$speed), length.out = 100))
lines(grille$speed, predict(mod_quad, newdata = grille),
      col = "red")

# Régression non linéaire
set.seed(2100)
x <- seq(0.1, 3, length.out = 40)
donnees_nl <- data.frame(x = x,
  y = 28 - 34 * exp(-x / 0.6) + rnorm(length(x), sd = 0.5))
mod_nl <- nls(y ~ a + b * exp(-x / theta), data = donnees_nl,
              start = list(a = 28, b = -30, theta = 0.7))
summary(mod_nl)
mod_nl$convInfo
predict(mod_nl, newdata = data.frame(x = c(0.5, 1, 2)))

# Moindres carrés pondérés
set.seed(2101)
x <- seq(1, 10, length.out = 60)
donnees_w <- data.frame(x = x,
  y = 5 + 2 * x + rnorm(length(x), sd = 0.5 * x))
mod_w <- lm(y ~ x, data = donnees_w, weights = 1 / x^2)
summary(mod_w)
confint(mod_w)
plot(fitted(mod_w), weighted.residuals(mod_w),
     xlab = "Valeurs ajustees", ylab = "Residus ponderes")
abline(h = 0, lty = 2)

# Modéliser une corrélation AR(1)
if (requireNamespace("nlme", quietly = TRUE)) {
  set.seed(2102)
  temps <- seq_len(100)
  erreur <- as.numeric(arima.sim(list(ar = 0.6), n = 100))
  serie <- data.frame(temps = temps,
                       y = 2 + 0.05 * temps + erreur)
  mod_ar <- nlme::gls(y ~ temps, data = serie,
    correlation = nlme::corAR1(form = ~ temps), method = "REML")
  summary(mod_ar)
  acf(residuals(mod_ar, type = "normalized"))
} else {
  message("L'exemple AR(1) necessite le paquet nlme.")
}
