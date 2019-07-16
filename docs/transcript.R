#' Transcript of commands typed during live coding session
#' at ECAS 2019 (with minor modifications to avoid errors).
#' Not all commands make sense on their own; nor do they necessarily
#' represent the recommended way to do everything. They are simply
#' provided as a service after request from some participants.

library(spatstat)
ponderosa
class(ponderosa)
X <- ponderosa
plot(X)
npoints(X)
?`spatstat-package`
methods(class = "ppp")
?plot.ppp
Window(X)
npoints(X)/area(Window(X))
intensity(X)
plot(X, main = "Ponderosa Pine Trees")
plot(ponderosa, chars="X", cols="green")
plot(ponderosa, chars="X", col="green")
plot(ponderosa, chars=1, cols="green")
plot(ponderosa, chars=2, cols="green")
plot(hamster)
plot(hamster, cols = c("red", "blue"))
plot(split(hamster))
?density
?density.ppp
plot(bei.extra$elev)
# w <- clickpoly(add = TRUE)  # Uncommented since it requires user interaction.
w <- owin(c(400,600), c(100,300)) # Square as alternative to interactive poly.
w
elev <- bei.extra$elev
ee <- elev[w, drop = FALSE]
?`[.im`
plot(ee)
?segregation.test
plot(X)
X <- murchison$gold
L <- murchison$faults
X
X <- rescale(X, 1000, "km")
L <- rescale(L, 1000, "km")
D <- distfun(L)
D
args(D)
dd <- D(X)
X
head(dd)
length(dd)
plot(D)
plot(L, add = TRUE, col = "white")
?ppm
?mppm
fit <- ppm(swedishpines ~ x+y)
logLik(fit)
