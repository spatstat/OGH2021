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

<img src="http://spatstat.org/ECAS2019/docs/notes/notes02_files/figure-markdown_github/unnamed-chunk-1-1.png" width="70%" />

### Nonparametric estimation of spatially-varying, mark-dependent intensity

``` r
M <- split(mucosa)
B <- density(M, bw.diggle)
plot(B, main="")
```

![](http://spatstat.org/ECAS2019/docs/notes/notes02_files/figure-markdown_github/unnamed-chunk-2-1.png)

Ratio of intensities

``` r
plot(relrisk(mucosa, casecontrol=FALSE))
```

![](http://spatstat.org/ECAS2019/docs/notes/notes02_files/figure-markdown_github/unnamed-chunk-3-1.png)

### Nonparametric estimation of intensity depending on a covariate

``` r
E <- split(mucosa)$ECL
g <- rhohat(E, "y")
plot(g)
```

![](http://spatstat.org/ECAS2019/docs/notes/notes02_files/figure-markdown_github/unnamed-chunk-4-1.png)

``` r
X <- murchison$gold
L <- murchison$faults
X <- rescale(X, 1000, "km")
L <- rescale(L, 1000, "km")
D <- distfun(L)
h <- rhohat(X, D)
plot(h)
```

![](http://spatstat.org/ECAS2019/docs/notes/notes02_files/figure-markdown_github/unnamed-chunk-5-1.png)

Parametric modelling
--------------------

### Loglinear model for intensity

log *λ*(*u*)=*β*<sub>1</sub>*Z*<sub>1</sub>(*u*)+…+*β*<sub>*p*</sub>*Z*<sub>*p*</sub>(*u*)

Explain about canonical variables vs original variables

### Fit using Poisson likelihood

``` r
fit <- ppm(X ~ D)
coef(fit)
```

    ## (Intercept)           D 
    ##  -4.3412775  -0.2607664

``` r
confint(fit)
```

    ##                  2.5 %     97.5 %
    ## (Intercept) -4.5089771 -4.1735779
    ## D           -0.3003339 -0.2211988

``` r
anova(fit, test="Chi")
```

    ## Analysis of Deviance Table
    ## Terms added sequentially (first to last)
    ## 
    ##      Df Deviance Npar  Pr(>Chi)    
    ## NULL                1              
    ## D     1   590.92    2 < 2.2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
plot(effectfun(fit, "D"), xlim=c(0, 20))
```

![](http://spatstat.org/ECAS2019/docs/notes/notes02_files/figure-markdown_github/unnamed-chunk-6-1.png)

``` r
plot(predict(fit))
```

![](http://spatstat.org/ECAS2019/docs/notes/notes02_files/figure-markdown_github/unnamed-chunk-6-2.png)

``` r
Jfit <- ppm(japanesepines ~ x + y)
Jfit
```

    ## Nonstationary Poisson process
    ## 
    ## Log intensity:  ~x + y
    ## 
    ## Fitted trend coefficients:
    ## (Intercept)           x           y 
    ##   4.0670790  -0.2349641   0.4296171 
    ## 
    ##               Estimate      S.E.    CI95.lo   CI95.hi Ztest       Zval
    ## (Intercept)  4.0670790 0.3341802  3.4120978 4.7220602   *** 12.1703167
    ## x           -0.2349641 0.4305456 -1.0788181 0.6088898       -0.5457357
    ## y            0.4296171 0.4318102 -0.4167154 1.2759495        0.9949211

``` r
confint(Jfit)
```

    ##                  2.5 %    97.5 %
    ## (Intercept)  3.4120978 4.7220602
    ## x           -1.0788181 0.6088898
    ## y           -0.4167154 1.2759495

``` r
Jfit2 <- ppm(japanesepines ~ polynom(x,y,2))
Jfit2
```

    ## Nonstationary Poisson process
    ## 
    ## Log intensity:  ~x + y + I(x^2) + I(x * y) + I(y^2)
    ## 
    ## Fitted trend coefficients:
    ## (Intercept)           x           y      I(x^2)    I(x * y)      I(y^2) 
    ##   4.0645501   1.1436854  -1.5613621  -0.7490094  -1.2009245   2.5061569 
    ## 
    ##               Estimate      S.E.    CI95.lo  CI95.hi Ztest       Zval
    ## (Intercept)  4.0645501 0.6670766  2.7571041 5.371996   ***  6.0930788
    ## x            1.1436854 1.9589569 -2.6957995 4.983170        0.5838237
    ## y           -1.5613621 1.8738722 -5.2340841 2.111360       -0.8332277
    ## I(x^2)      -0.7490094 1.7060242 -4.0927554 2.594737       -0.4390380
    ## I(x * y)    -1.2009245 1.4268186 -3.9974376 1.595589       -0.8416799
    ## I(y^2)       2.5061569 1.6013679 -0.6324664 5.644780        1.5650101

``` r
plot(predict(Jfit2))
```

![](http://spatstat.org/ECAS2019/docs/notes/notes02_files/figure-markdown_github/unnamed-chunk-7-1.png)

``` r
anova(Jfit, Jfit2, test="Chi")
```

    ## Analysis of Deviance Table
    ## 
    ## Model 1: ~x + y   Poisson
    ## Model 2: ~x + y + I(x^2) + I(x * y) + I(y^2)      Poisson
    ##   Npar Df Deviance Pr(>Chi)
    ## 1    3                     
    ## 2    6  3   3.3851    0.336

``` r
step(Jfit2)
```

    ## Start:  AIC=-405.35
    ## ~x + y + I(x^2) + I(x * y) + I(y^2)
    ## 
    ##            Df     AIC
    ## - I(x^2)    1 -407.15
    ## - x         1 -407.00
    ## - y         1 -406.67
    ## - I(x * y)  1 -406.63
    ## <none>        -405.35
    ## - I(y^2)    1 -404.97
    ## 
    ## Step:  AIC=-407.15
    ## ~x + y + I(x * y) + I(y^2)
    ## 
    ##            Df     AIC
    ## - x         1 -408.96
    ## - I(x * y)  1 -408.47
    ## - y         1 -408.45
    ## <none>        -407.15
    ## - I(y^2)    1 -406.77
    ## 
    ## Step:  AIC=-408.96
    ## ~y + I(x * y) + I(y^2)
    ## 
    ##            Df     AIC
    ## - I(x * y)  1 -410.17
    ## - y         1 -409.78
    ## <none>        -408.96
    ## - I(y^2)    1 -408.48
    ## 
    ## Step:  AIC=-410.17
    ## ~y + I(y^2)
    ## 
    ##          Df     AIC
    ## - y       1 -410.51
    ## <none>      -410.17
    ## - I(y^2)  1 -409.66
    ## 
    ## Step:  AIC=-410.51
    ## ~I(y^2)
    ## 
    ##          Df     AIC
    ## - I(y^2)  1 -410.67
    ## <none>      -410.51
    ## 
    ## Step:  AIC=-410.67
    ## ~1

    ## Stationary Poisson process
    ## Intensity: 65
    ##             Estimate      S.E.  CI95.lo  CI95.hi Ztest     Zval
    ## log(lambda) 4.174387 0.1240347 3.931284 4.417491   *** 33.65499
