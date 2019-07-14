Notes for session 3
================
Adrian Baddeley and Ege Rubak
July 15, 2019

# Dependence between points

Another important goal is to detect stochastic dependence between points
in a point pattern.

![](notes03_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

  - The homogeneous Poisson process is regarded as completely random
    (Complete Spatial Randomness, CSR).
  - A point process is called *inhibited* if the distances between
    points are typically *larger* than expected for a random pattern
    with the same intensity.
  - A point process is called *clustered* if the distances between
    points are typically *smaller* than would be expected for a random
    pattern with the same intensity.

The terms *inhibited* and *clustered* are analogous, respectively, to
“negatively correlated” and “positively correlated”. They do not imply
any particular kind of stochastic dependence and they do not explain how
the pattern was generated.

Dependence between points is sometimes called *“interaction”*, but this
term is dangerous because it suggests a particular mechanism for the
dependence.

## Exploratory tools

Traditionally (1976-2005) dependence between points was investigated
using exploratory tools such as Ripley’s
![K](https://latex.codecogs.com/png.latex?K "K") function and the pair
correlation function. While these methods are useful and convenient,
they have limitations. They have become so popular that many user
communities are not interested in learning better methods that have been
developed in recent years. In this workshop, as an experiment we are
reducing the coverage of these methods to a minimum, so that we can
concentrate on the more modern methods.

### K-function

The (Ripley) ![K](https://latex.codecogs.com/png.latex?K "K")-function
assumes the point process has constant intensity
![\\lambda](https://latex.codecogs.com/png.latex?%5Clambda "\\lambda").
It is defined so that, for a typical random point in the point process,
the number of other random points lying closer than a distance
![r](https://latex.codecogs.com/png.latex?r "r") has expected value
![\\lambda \\,
K(r)](https://latex.codecogs.com/png.latex?%5Clambda%20%5C%2C%20K%28r%29
"\\lambda \\, K(r)").

For a completely random (homogeneous Poisson) process, ![K(r) = \\pi
r^2](https://latex.codecogs.com/png.latex?K%28r%29%20%3D%20%5Cpi%20r%5E2
"K(r) = \\pi r^2"). An inhibited process will usually have ![K(r) \<
\\pi
r^2](https://latex.codecogs.com/png.latex?K%28r%29%20%3C%20%5Cpi%20r%5E2
"K(r) \< \\pi r^2"), while a clustered process will have ![K(r) \> \\pi
r^2](https://latex.codecogs.com/png.latex?K%28r%29%20%3E%20%5Cpi%20r%5E2
"K(r) \> \\pi r^2"), for appropriate values of
![r](https://latex.codecogs.com/png.latex?r "r").

An estimate of the ![K](https://latex.codecogs.com/png.latex?K "K")
function can be computed for a point pattern dataset `X` by typing `K <-
Kest(X)`.

![](notes03_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

### pair correlation function

The pair correlation function
![g(r)](https://latex.codecogs.com/png.latex?g%28r%29 "g(r)") can be
defined as ![g(r) = K^\\prime(r)/(2\\pi
r)](https://latex.codecogs.com/png.latex?g%28r%29%20%3D%20K%5E%5Cprime%28r%29%2F%282%5Cpi%20r%29
"g(r) = K^\\prime(r)/(2\\pi r)") where
![K^\\prime(r)](https://latex.codecogs.com/png.latex?K%5E%5Cprime%28r%29
"K^\\prime(r)") is the derivative of the
![K](https://latex.codecogs.com/png.latex?K "K") function. The pair
correlation function can be interpreted as the probability that two
points in the point process will be separated by a distance equal to
![r](https://latex.codecogs.com/png.latex?r "r"), normalised by the
corresponding probability for a completely random (Poisson) process.

For a completely random (homogeneous Poisson) process, ![g(r)
= 1](https://latex.codecogs.com/png.latex?g%28r%29%20%3D%201
"g(r) = 1"). An inhibited process will usually have ![g(r)
\< 1](https://latex.codecogs.com/png.latex?g%28r%29%20%3C%201
"g(r) \< 1"), while a clustered process will have ![g(r)
\> 1](https://latex.codecogs.com/png.latex?g%28r%29%20%3E%201
"g(r) \> 1"), for appropriate values of
![r](https://latex.codecogs.com/png.latex?r "r").

An estimate of the pair correlation function can be computed for a point
pattern dataset `X` by typing `g <- pcf(X)`.

![](notes03_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

## Explicit Models for clustered data

``` r
plot(redwood)
```

![](notes03_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

### Cluster processes

A cluster process is generated in two stages.

1.  a point pattern of *“parent”* points
    ![X](https://latex.codecogs.com/png.latex?X "X") is generated;
2.  around each parent point
    ![x\_i](https://latex.codecogs.com/png.latex?x_i "x_i"), a finite
    pattern of *“offspring”* points ![y\_{i1}, \\ldots,
    y\_{in\_i}](https://latex.codecogs.com/png.latex?y_%7Bi1%7D%2C%20%5Cldots%2C%20y_%7Bin_i%7D
    "y_{i1}, \\ldots, y_{in_i}") is generated;
3.  the offspring of all parents are collected together into a single
    point pattern ![Y](https://latex.codecogs.com/png.latex?Y "Y").

In a *Thomas cluster process*,

1.  the parents are a homogeneous Poisson process with intensity
    ![\\kappa](https://latex.codecogs.com/png.latex?%5Ckappa "\\kappa");
2.  each parent has a Poisson number (with mean
    ![\\mu](https://latex.codecogs.com/png.latex?%5Cmu "\\mu")) of
    offspring, which are displaced from the parent by independent
    Gaussian vectors with standard deviation
    ![\\sigma](https://latex.codecogs.com/png.latex?%5Csigma "\\sigma").

Here are simulated realisations of a Thomas process:

``` r
plot(rThomas(kappa=10, sigma=0.2, mu=5, nsim=12),
     main="", main.panel="")
```

![](notes03_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

Maximum likelihood fitting of cluster processes is difficult because the
likelihood is quite complicated. However, the
![K](https://latex.codecogs.com/png.latex?K "K")-function of such
cluster processes is known analytically, so the model can be fitted by
the method of moments (matching the model’s theoretical
![K](https://latex.codecogs.com/png.latex?K "K")-function to the
empirical ![K](https://latex.codecogs.com/png.latex?K "K")-function of
the data). This is performed by the `spatstat` function `kppm`.

``` r
fitT <- kppm(redwood ~ 1, "Thomas")
fitT
```

    ## Stationary cluster point process model
    ## Fitted to point pattern dataset 'redwood'
    ## Fitted by minimum contrast
    ##  Summary statistic: K-function
    ## 
    ## Uniform intensity:   62
    ## 
    ## Cluster model: Thomas process
    ## Fitted cluster parameters:
    ##      kappa      scale 
    ## 23.5511449  0.0470461 
    ## Mean cluster size:  2.632568 points

``` r
plot(simulate(fitT, nsim=12))
```

    ## Generating 12 simulations... 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,  12.
    ## Done.

![](notes03_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

``` r
kppm(redwood ~ x+y, "Thomas")
```

    ## Inhomogeneous cluster point process model
    ## Fitted to point pattern dataset 'redwood'
    ## Fitted by minimum contrast
    ##  Summary statistic: inhomogeneous K-function
    ## 
    ## Log intensity:  ~x + y
    ## 
    ## Fitted trend coefficients:
    ## (Intercept)           x           y 
    ##  3.95144951  0.29770284 -0.04607577 
    ## 
    ## Cluster model: Thomas process
    ## Fitted cluster parameters:
    ##       kappa       scale 
    ## 22.97116104  0.04625136 
    ## Mean cluster size:  [pixel image]

### Cox processes

A *Cox process* is formed in two steps:

1.  a random function
    ![\\Lambda(u)](https://latex.codecogs.com/png.latex?%5CLambda%28u%29
    "\\Lambda(u)") is generated;
2.  Given the realisation of the random function, a Poisson point
    process is generated with intensity function
    ![\\Lambda(u)](https://latex.codecogs.com/png.latex?%5CLambda%28u%29
    "\\Lambda(u)").

In a *log-Gaussian Cox process*, the random function
![\\Lambda(u)](https://latex.codecogs.com/png.latex?%5CLambda%28u%29
"\\Lambda(u)") is such that ![\\log
\\Lambda(u)](https://latex.codecogs.com/png.latex?%5Clog%20%5CLambda%28u%29
"\\log \\Lambda(u)") is a Gaussian random function.

These models can be fitted by the same technique:

``` r
kppm(redwood ~ x+y, "LGCP")
```

    ## Inhomogeneous Cox point process model
    ## Fitted to point pattern dataset 'redwood'
    ## Fitted by minimum contrast
    ##  Summary statistic: inhomogeneous K-function
    ## 
    ## Log intensity:  ~x + y
    ## 
    ## Fitted trend coefficients:
    ## (Intercept)           x           y 
    ##  3.95144951  0.29770284 -0.04607577 
    ## 
    ## Cox model: log-Gaussian Cox process
    ##  Covariance model: exponential
    ## Fitted covariance parameters:
    ##        var      scale 
    ## 1.09380346 0.09796466 
    ## Fitted mean of log of random intensity: [pixel image]

## Models for inhibited data

``` r
plot(cells)
```

![](notes03_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

``` r
jp <- residualspaper$Fig1
plot(jp)
```

![](notes03_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

### Gibbs models

Gibbs models were developed in theoretical physics to describe the
behaviour of molecular gases. A point pattern
![x](https://latex.codecogs.com/png.latex?x "x") represents a spatial
configuration of molecules. The probability of a particular
configuration ![x](https://latex.codecogs.com/png.latex?x "x") is   
![
p(x) = Z \\exp(- U(x))
](https://latex.codecogs.com/png.latex?%0A%20%20%20%20p%28x%29%20%3D%20Z%20%5Cexp%28-%20U%28x%29%29%0A
"
    p(x) = Z \\exp(- U(x))
")  
where ![U(x)](https://latex.codecogs.com/png.latex?U%28x%29 "U(x)") is
the potential energy of the configuration, and
![Z](https://latex.codecogs.com/png.latex?Z "Z") is a normalising
constant. In fact ![p(x)](https://latex.codecogs.com/png.latex?p%28x%29
"p(x)") is a probability density relative to the completely random
(homogeneous Poisson) point process.

To visualise this, imagine that we first generate an infinite “ensemble”
of realisations of the homogeneous Poisson process. Then each
realisation is either deleted or retained (in its entirety) depending on
its potential energy; a realisation
![x](https://latex.codecogs.com/png.latex?x "x") is retained with
probability
![\\exp(-U(x))](https://latex.codecogs.com/png.latex?%5Cexp%28-U%28x%29%29
"\\exp(-U(x))"). Then what remains is an ensemble of realisations of the
Gibbs process.

The simplest example is the *hard core process* in which the points
represent the centres of discs of diameter
![d](https://latex.codecogs.com/png.latex?d "d") which cannot overlap. A
realisation ![x](https://latex.codecogs.com/png.latex?x "x") has
potential energy ![U(x) =
-\\infty](https://latex.codecogs.com/png.latex?U%28x%29%20%3D%20-%5Cinfty
"U(x) = -\\infty") if any pair of points in
![x](https://latex.codecogs.com/png.latex?x "x") lies closer than
distance ![d](https://latex.codecogs.com/png.latex?d "d"); otherwise it
has potential ![U(x)
= 0](https://latex.codecogs.com/png.latex?U%28x%29%20%3D%200
"U(x) = 0"). Now generate an infinite ensemble of realisations of the
Poisson process. Then delete any configuration which contains a pair of
points closer than distance ![d](https://latex.codecogs.com/png.latex?d
"d"). The remaining realisations are an ensemble of realisations of the
hard core process.

Gibbs models can be fitted to point pattern data by maximising Besag’s
*pseudolikelihood*. This is performed by `ppm`.

``` r
ppm(cells~ 1, Hardcore())
```

    ## Stationary Hard core process
    ## 
    ## First order term:  beta = 282.7782
    ## 
    ## Hard core distance:  0.08168525
    ## 
    ## For standard errors, type coef(summary(x))

``` r
minnndist(cells)
```

    ## [1] 0.08363014

``` r
ppm(cells ~ 1, Strauss(0.1))
```

    ## Stationary Strauss process
    ## 
    ## First order term:  beta = 1138.136
    ## 
    ## Interaction distance:    0.1
    ## Fitted interaction parameter gamma:   0.0050219
    ## 
    ## Relevant coefficients:
    ## Interaction 
    ##    -5.29395 
    ## 
    ## For standard errors, type coef(summary(x))

``` r
fit <- ppm(cells ~ 1, Strauss(0.1))
plot(simulate(fit, nsim=4))
```

    ## Generating 4 simulated patterns ...1, 2, 3,  4.

![](notes03_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

``` r
plot(pcfinhom(jp))
```

![](notes03_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

``` r
minnndist(jp)
```

    ## [1] 0.1410937

``` r
ppm(jp ~ x+y, Strauss(0.2))
```

    ## Nonstationary Strauss process
    ## 
    ## Log trend:  ~x + y
    ## 
    ## Fitted trend coefficients:
    ## (Intercept)           x           y 
    ## 0.679292879 0.006806174 0.024664271 
    ## 
    ## Interaction distance:    0.2
    ## Fitted interaction parameter gamma:   0.6367406
    ## 
    ## Relevant coefficients:
    ## Interaction 
    ##   -0.451393 
    ## 
    ## For standard errors, type coef(summary(x))

``` r
ppm(jp ~ x+y, Strauss(0.5))
```

    ## Nonstationary Strauss process
    ## 
    ## Log trend:  ~x + y
    ## 
    ## Fitted trend coefficients:
    ##  (Intercept)            x            y 
    ##  0.364642729 -0.004808391  0.033863194 
    ## 
    ## Interaction distance:    0.5
    ## Fitted interaction parameter gamma:   1.1799626
    ## 
    ## Relevant coefficients:
    ## Interaction 
    ##   0.1654827 
    ## 
    ## For standard errors, type coef(summary(x))
    ## 
    ## *** Model is not valid ***
    ## *** Interaction parameters are outside valid range ***

### Determinantal point process models

Determinantal point process models are a relatively new class of models
with many attractive theoretical properties, but are not yet well
understood for modelling purposes.

The likelihood is determined by the first and second moments (the
intensity and the pair correlation function). These models can be fitted
in `spatstat` using the function `dppm`.

``` r
dppm(jp ~ x+y, dppGauss)
```

    ## Inhomogeneous determinantal point process model
    ## Fitted to point pattern dataset 'jp'
    ## Fitted by minimum contrast
    ##  Summary statistic: inhomogeneous K-function
    ## 
    ## Log intensity:  ~x + y
    ## 
    ## Fitted trend coefficients:
    ## (Intercept)           x           y 
    ## 0.591839808 0.014329205 0.009643885 
    ## 
    ## Fitted DPP model:
    ## Gaussian determinantal point process model
    ## The parameters are: lambda = an image, alpha = 0.06402, d = 2
    ## The parameter lambda specifies the intensity of the process.
    ## The parameter d specifies the dimension of the state space.

``` r
fit <- dppm(jp ~ polynom(x,y,2),
            dppMatern,
        statistic="pcf", statargs=list(stoyan=0.2))
```

    ## Warning: Some values of the empirical function 'pcf' were infinite or NA.
    ## Range of r values was reset to [0.0048828125, 2.5]

``` r
plot(predict(fit))      
```

![](notes03_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->

``` r
plot(simulate(fit))
```

![](notes03_files/figure-gfm/unnamed-chunk-22-1.png)<!-- -->
