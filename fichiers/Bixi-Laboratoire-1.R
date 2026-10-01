load('Bixi.rda')

head(Bixi)

mod <- lm(Duree_min ~ distance_km, data = Bixi)
mod
mod$coefficients[1]
mod$coefficients[2]

Bixi[1,]
mod$fitted.values[1]
mod$residuals[1]

summary(mod)
4.951^2
summary(mod)$sigma^2
