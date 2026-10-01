load('Bixi.rda')
head(Bixi)

mod <- lm(Duree_min ~ distance_km, data = Bixi)
mod

summary(mod)

confint(mod, level=0.90)

4.951^2
summary(mod)$sigma^2


tobs <- (summary(mod)$coefficients[2,1] - 5) / summary(mod)$coefficients[2,2]

summary(Bixi$distance_km)
nouveau <- data.frame(distance_km = 1.8)
predict(mod, nouveau, interval="confidence", level = 0.9)

nouveau <- data.frame(distance_km = c(0.8, 1.8))
p <- predict(mod, nouveau, interval="prediction", level = 0.9)
p[,3] - p[,2]
