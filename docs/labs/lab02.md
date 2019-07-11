Lab 2: Intensity
================

This session covers exploratory tools for investigating intensity.

### Exercise 1

The dataset `japanesepines` contains the locations of Japanese Black Pine trees in a study region.

1.  Plot the `japanesepines` data.

2.  What is the average intensity (the average number of points per unit area?

3.  Using `density.ppp`, compute a kernel estimate of the spatially-varying intensity function for the Japanese pines data, using a Gaussian kernel with standard deviation ![\\sigma=0.1](https://latex.codecogs.com/png.latex?%5Csigma%3D0.1 "\sigma=0.1") units, and store the estimated intensity in an object `D` say.

4.  Plot a colour image of the kernel estimate `D`.

5.  Most plotting commands will accept the argument `add=TRUE` and interpret it to mean that the plot should be drawn over the existing display, without clearing the screen beforehand. Use this to plot a colour image of the kernel estimate `D` with the original Japanese Pines data superimposed.

6.  Plot the kernel estimate without the ‘colour ribbon’.

7.  Try the following command

    ``` r
    persp(D, theta=70, phi=25, shade=0.4)
    ```

    and find the documentation for the arguments `theta`, `phi` and `shade`.

8.  Find the maximum and minimum values of the intensity estimate over the study region. (Hint: Use `summary` or `range`)

9.  The kernel estimate of intensity is defined so that its integral over the entire study region is equal to the number of points in the data pattern, ignoring edge effects. Check whether this is approximately true in this example. (Hint: use `integral`)

### Exercise 2

The `bei` dataset gives the locations of trees in a survey area with additional covariate information in a list `bei.extra`.

1.  Assign the elevation covariate to a variable `elev` by typing

    ``` r
    elev <- bei.extra$elev
    ```

2.  Plot the trees on top of an image of the elevation covariate.

3.  Assume that the intensity of trees is a function ![\\lambda(u) = \\rho(e(u))](https://latex.codecogs.com/png.latex?%5Clambda%28u%29%20%3D%20%5Crho%28e%28u%29%29 "\lambda(u) = \rho(e(u))") where ![e(u)](https://latex.codecogs.com/png.latex?e%28u%29 "e(u)") is the terrain elevation at location u. Compute a nonparametric estimate of the function ![\\rho](https://latex.codecogs.com/png.latex?%5Crho "\rho") and plot it by

    ``` r
    rh <- rhohat(bei, elev)
    plot(rh)
    ```

4.  Compute the predicted intensity based on this estimate of ![\\rho](https://latex.codecogs.com/png.latex?%5Crho "\rho").

5.  Compute a non-parametric estimate of intensity by kernel smoothing, and compare with the predicted intensity above.

6.  Bonus info: To plot the two intensity estimates next to each other you collect the estimates as a spatial object list (`solist`) and plot the result (the estimates are called `pred` and `ker` below):

    ``` r
    l <- solist(pred, ker)
    plot(l, equal.ribbon = TRUE, main = "", 
         main.panel = c("rhohat prediction", "kernel smoothing"))
    ```

### Exercise 3

The command `rpoispp(100)` generates realisations of the Poisson process with intensity ![\\lambda = 100](https://latex.codecogs.com/png.latex?%5Clambda%20%3D%20100 "\lambda = 100") in the unit square.

1.  Repeat the command `plot(rpoispp(100))` several times to build your intuition about the appearance of a completely random pattern of points.

2.  Try the same thing with intensity ![\\lambda = 1.5](https://latex.codecogs.com/png.latex?%5Clambda%20%3D%201.5 "\lambda = 1.5").

### Exercise 4

Returning to the Japanese Pines data,

1.  Fit the uniform Poisson point process model to the Japanese Pines data

    ``` r
    ppm(japanesepines~1)
    ```

2.  Read off the fitted intensity. Check that this is the correct value of the maximum likelihood estimate of the intensity.

### Exercise 5

The `japanesepines` dataset is believed to exhibit spatial inhomogeneity.

1.  Plot a kernel smoothed intensity estimate.

2.  Fit the Poisson point process models with loglinear intensity (trend formula `~x+y`) and log-quadratic intensity (trend formula `~polynom(x,y,2)`) to the Japanese Pines data.

3.  extract the fitted coefficients for these models using `coef`.

4.  Plot the fitted model intensity (using `plot(fit)`)

5.  perform the Likelihood Ratio Test for the null hypothesis of a loglinear intensity against the alternative of a log-quadratic intensity, using `anova`.

6.  Generate 10 simulated realisations of the fitted log-quadratic model, and plot them, using `plot(simulate(fit, nsim=10))` where `fit` is the fitted model.

### Exercise 6

The `update` command can be used to re-fit a point process model using a different model formula.

1.  Type the following commands and interpret the results:

    ``` r
    fit0 <- ppm(japanesepines ~ 1)
    fit1 <- update(fit0, . ~ x)
    fit1
    fit2 <- update(fit1, . ~ . + y)
    fit2
    ```

2.  Now type `step(fit2)` and interpret the results.

### Exercise 7

The `bei` dataset gives the locations of trees in a survey area with additional covariate information in a list `bei.extra`.

1.  Fit a Poisson point process model to the data which assumes that the intensity is a loglinear function of terrain slope and elevation (hint: use `data = bei.extra` in `ppm`).

2.  Read off the fitted coefficients and write down the fitted intensity function.

3.  Plot the fitted intensity as a colour image.

4.  extract the estimated variance-covariance matrix of the coefficient estimates, using `vcov`.

5.  Compute and plot the standard error of the intensity estimate (see `help(predict.ppm)`).

### Exercise 8

Fit Poisson point process models to the Japanese Pines data, with the following trend formulas. Read off an expression for the fitted intensity function in each case.

| Trend formula      | Fitted intensity function |
|:-------------------|:--------------------------|
| `~1`               |                           |
| `~x`               |                           |
| `~sin(x)`          |                           |
| `~x+y`             |                           |
| `~polynom(x,y,2)`  |                           |
| `~factor(x < 0.4)` |                           |

### Exercise 9

Make image plots of the fitted intensities for the inhomogeneous models above.

### Exercise 10

The dataset `hamster` is a multitype pattern representing the locations of cells of two types, *dividing* and *pyknotic*.

1.  plot the patterns of pyknotic and dividing cells separately;

2.  plot kernel estimates of the intensity functions of pyknotic and dividing cells separately;

3.  use `relrisk` to perform cross-validated bandwidth selection and computation of the relative intensity of pyknotic cells.

### Exercise 11

The dataset `ants` is a multitype point pattern representing the locations of nests of two species of ants.

1.  plot the data.

2.  Fit the model `ppm(ants ~ marks)` and interpret the result. Compare the result with `summary(ants)` and explain the similarities.

3.  Fit the model `ppm(ants ~ marks + x)` and write down an expression for the fitted intensity function.

4.  Fit the model `ppm(ants ~ marks * x)` and write down an expression for the fitted intensity function.

5.  Compute the fitted intensities of the three models fitted above using `predict` and plot the results.

6.  Explain the difference between the models fitted by `ppm(ants ~ marks + x)` and `ppm(ants ~ marks * x)` .

Exercise 12
-----------

The study region for the ants’ nests data `ants` is divided into areas of "scrub" and "field". We want to fit a Poisson model with different intensities in the field and scrub areas.

The coordinates of two points on the boundary line between field and scrub are given in `ants.extra$fieldscrub`. First construct a function that determines which side of the line we are on:

``` r
fs <- function(x,y) {
  ends <- ants.extra$fieldscrub
  angle <- atan(diff(ends$y)/diff(ends$x))
  normal <- angle + pi/2
  project <- (x - ends$x[1]) * cos(normal) + (y - ends$y[1]) * sin(normal)
  factor(ifelse(project > 0, "scrub", "field"))
}
```

Now fit the models:

``` r
ppm(ants ~ marks + side, data = list(side=fs))
ppm(ants ~ marks * side, data = list(side=fs))
```

and interpret the results.
