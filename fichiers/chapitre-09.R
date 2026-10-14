# STT-2100 - Chapitre 9 - Diagnostiquer la multicolinéarité avec R
# Exemples de la fiche R, automne 2026.

# Dépendance exacte et rang
donnees <- mtcars
donnees$double_wt <- 2 * donnees$wt
mod_exact <- lm(mpg ~ wt + double_wt + hp, data = donnees)
coef(mod_exact)
alias(mod_exact)
X <- model.matrix(mod_exact)
c(rang = qr(X)$rank, colonnes = ncol(X))

# VIF par régressions auxiliaires
variables <- c("wt", "hp", "disp")
cor(donnees[variables])
vif <- sapply(variables, function(v) {
  f <- reformulate(setdiff(variables, v), response = v)
  auxiliaire <- lm(f, data = donnees)
  1 / (1 - summary(auxiliaire)$r.squared)
})
vif

# Indices de conditionnement
mod <- lm(mpg ~ wt + hp + disp, data = donnees)
X <- model.matrix(mod)
Xs <- sweep(X, 2, sqrt(colSums(X^2)), "/")
decomp <- eigen(crossprod(Xs), symmetric = TRUE)
if (min(decomp$values) <= 0) stop("Matrice singuliere")
indices <- sqrt(max(decomp$values) / decomp$values)
contributions <- sweep(decomp$vectors^2, 2,
                       decomp$values, "/")
proportions <- contributions / rowSums(contributions)
rownames(proportions) <- colnames(X)
indices
proportions

# Une pénalisation ridge illustrative
Z <- scale(as.matrix(donnees[variables]))
y <- donnees$mpg
lambda <- 10
beta_ridge <- solve(crossprod(Z) + lambda * diag(ncol(Z)),
                    crossprod(Z, y - mean(y)))
beta_ridge
pred_ridge <- drop(mean(y) + Z %*% beta_ridge)
