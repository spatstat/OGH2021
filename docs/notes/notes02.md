Notes for session 2
================
Adrian Baddeley and Ege Rubak
2019-07-02

Intensity
=========

Intensity and probability density
---------------------------------

Definition

Objectives

Nonparametric estimation
------------------------

### Nonparametric estimation of spatially-varying intensity

``` r
library(spatstat)
X <- japanesepines
A <- quadratcount(X, 3, 3)
Z <- density(X)
Z <- density(X, bw.diggle)
plot(Z, main="")
```

![](/home/adrian/new-courses/spatstatLisbon/ECAS2019/docs/notes/notes02_files/figure-markdown_github/unnamed-chunk-1-1.png)

### Nonparametric estimation of spatially-varying, mark-dependent intensity

``` r
M <- split(mucosa)
B <- density(M, bw.diggle)
plot(B, main="")
```

![](/home/adrian/new-courses/spatstatLisbon/ECAS2019/docs/notes/notes02_files/figure-markdown_github/unnamed-chunk-2-1.png)

Ratio of intensities

``` r
plot(relrisk(mucosa, casecontrol=FALSE))
```

![](/home/adrian/new-courses/spatstatLisbon/ECAS2019/docs/notes/notes02_files/figure-markdown_github/unnamed-chunk-3-1.png)

### Nonparametric estimation of intensity depending on a covariate

``` r
E <- split(mucosa)$ECL
g <- rhohat(E, "y")
plot(g)
```

![](/home/adrian/new-courses/spatstatLisbon/ECAS2019/docs/notes/notes02_files/figure-markdown_github/unnamed-chunk-4-1.png)

``` r
X <- murchison$gold
L <- murchison$faults
X <- rescale(X, 1000, "km")
L <- rescale(L, 1000, "km")
D <- distfun(L)
h <- rhohat(X, D)
plot(h)
```

![](/home/adrian/new-courses/spatstatLisbon/ECAS2019/docs/notes/notes02_files/figure-markdown_github/unnamed-chunk-5-1.png)

Parametric modelling
--------------------

### Loglinear model for intensity

log *λ*(*u*)=*β*<sub>1</sub>*Z*<sub>1</sub>(*u*)+…+*β*<sub>*p*</sub>*Z*<sub>*p*</sub>(*u*)

### Fit using Poisson likelihood

``` r
fit <- ppm(X ~ D)
coef(fit)
```

    ## (Intercept)           D 
    ##  -4.3412775  -0.2607664

``` r
plot(effectfun(fit, "D"), xlim=c(0, 20))
```

![](/home/adrian/new-courses/spatstatLisbon/ECAS2019/docs/notes/notes02_files/figure-markdown_github/unnamed-chunk-6-1.png)
