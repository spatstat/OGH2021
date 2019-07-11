Lab 3: Dependence
================

This session covers tools for investigating dependence between points.

### Exercise 1

The `swedishpines` dataset was recorded in a study plot in a large forest. We shall assume the pattern is stationary.

1.  Calculate the estimate of the ![K](https://latex.codecogs.com/png.latex?K "K")-function using `Kest`.

2.  Plot the estimate of ![K(r)](https://latex.codecogs.com/png.latex?K%28r%29 "K(r)") against ![r](https://latex.codecogs.com/png.latex?r "r")

3.  Plot the estimate of ![K(r) - \\pi\\!r^2](https://latex.codecogs.com/png.latex?K%28r%29%20-%20%5Cpi%5C%21r%5E2 "K(r) - \pi\!r^2") against ![r](https://latex.codecogs.com/png.latex?r "r").

4.  Calculate the estimate of the ![L](https://latex.codecogs.com/png.latex?L "L")-function and plot it against ![r](https://latex.codecogs.com/png.latex?r "r").

5.  Plot the estimate of ![L(r) - r](https://latex.codecogs.com/png.latex?L%28r%29%20-%20r "L(r) - r") against ![r](https://latex.codecogs.com/png.latex?r "r").

6.  Calculate and plot an estimate of the pair correlation function using `pcf`.

7.  Draw tentative conclusions from these plots about interpoint interaction in the data.

### Exercise 2

The command `rThomas` generates simulated realisations of the Thomas model (‘modified Thomas cluster process’).

1.  Read the help file.

2.  Type `plot(rThomas(10, 0.05, 8))` a few times, and interpret the results.

3.  Experiment with the arguments of `rThomas` to obtain point patterns that
    1.  consist of a few, well-separated, very tight clusters of points;
    2.  look similar to realisations of a uniform Poisson process.

### Exercise 3

1.  Read the help file for `kppm`.

2.  Fit the Thomas model to the `redwood` data by the method of minimum contrast:

    ``` r
    fit <- kppm(redwood ~ 1, clusters="Thomas")
    fit
    plot(fit)
    ```

3.  Read off the parameters of the fitted model, and generate a simulated realisation of the fitted model using `rThomas`.

4.  Type `plot(simulate(fit))` to generate a simulated realisation of the fitted model automatically.

5.  Try the command

    ``` r
    fit2 <- kppm(redwood ~ 1, clusters="Thomas", startpar=c(kappa=10, scale=0.1))
    ```

    and briefly explore the fitting algorithm’s sensitivity to the initial guesses at the parameter values `kappa` and `scale`.

6.  Generate and plot several simulated realisations of the fitted model, to assess whether it is plausible.

7.  Extract and plot the fitted pair correlation function by

    ``` r
    pcffit <- pcfmodel(fit)
    plot(pcffit, xlim = c(0, 0.3))
    ```

8.  Type `plot(envelope(fit, Lest, nsim=39))` to generate simulation envelopes of the ![L](https://latex.codecogs.com/png.latex?L "L") function from this fitted model. Do they suggest the model is plausible?

### Exercise 4

1.  Fit a Matern cluster process to the `redwood` data.

2.  Use `vcov` to estimate the covariance matrix of the parameter estimates.

3.  Compare with the covariance matrix obtained when fitting a homogeneous Poisson model.

### Exercise 5

In this question we fit a Strauss point process model to the `swedishpines` data.

1.  We need a guess at the interaction distance ![R](https://latex.codecogs.com/png.latex?R "R"). Compute and plot the ![L](https://latex.codecogs.com/png.latex?L "L")-function of the dataset and choose the value ![r](https://latex.codecogs.com/png.latex?r "r") which maximises the discrepancy ![|L(r)-r|](https://latex.codecogs.com/png.latex?%7CL%28r%29-r%7C "|L(r)-r|").

2.  Fit the stationary Strauss model with the chosen interaction distance using

    ``` r
    ppm(swedishpines ~ 1, Strauss(R))
    ```

    where `R` is your chosen value.

    1.  Interpret the printout: how strong is the interaction?

    2.  Plot the fitted pairwise interaction function using `plot(fitin(fit))`.

### Exercise 6

In Question 5 we guesstimated the Strauss interaction distance parameter. Alternatively this parameter could be estimated by profile pseudolikelihood.

1.  Look again at the plot of the ![L](https://latex.codecogs.com/png.latex?L "L")-function of `swedishpines` and determine a plausible range of possible values for the interaction distance.

2.  Generate a sequence of values equally spaced across this range, for example, if your range of plausible values was ![\[5, 12\]](https://latex.codecogs.com/png.latex?%5B5%2C%2012%5D "[5, 12]"), then type

    ``` r
    rvals <- seq(5, 12, by=0.5)
    ```

3.  Construct a data frame, with one column named `r` (matching the argument name of `Strauss`), containing these values. For example

    ``` r
    D <- data.frame(r = rvals)
    ```

4.  Execute

    ``` r
    fitp <- profilepl(D, Strauss, swedishpines ~ 1)
    ```

    to find the maximum profile pseudolikelihood fit.

5.  Print and plot the object `fitp`.

6.  Compare the computed estimate of interaction distance ![r](https://latex.codecogs.com/png.latex?r "r") with your guesstimate. Compare the corresponding estimates of the Strauss interaction parameter ![\\gamma](https://latex.codecogs.com/png.latex?%5Cgamma "\gamma").

7.  Extract the fitted Gibbs point process model from the object `fitp` as

    ``` r
    bestfit <- as.ppm(fitp)
    ```

### Exercise 7

For the Strauss model fitted in Question 5,

1.  Generate and plot a simulated realisation of the fitted model using `simulate`.

2.  Plot the ![L](https://latex.codecogs.com/png.latex?L "L")-function of the data along with the global simulation envelopes from 19 realisations of the fitted model.

### Exercise 8

1.  Read the help file for `Geyer`.

2.  Fit a stationary Geyer saturation process to `swedishpines`, with the same interaction distance as for the Strauss model computed in Question 6, and trying different values of the saturation parameter `sat = 1, 2, 3` say.

3.  Fit the same model with the addition of a log-quadratic trend.

4.  Plot the fitted trend and conditional intensity.

### Exercise 9

Modify Question 5 by using the Huang-Ogata approximate maximum likelihood algorithm (`method="ho"`) instead of maximum pseudolikelihood (the default, `method="mpl"`).

### Exercise 10

Repeat Question 6 for the inhomogeneous Strauss process with log-quadratic trend. The corresponding call to `profilepl` is

``` r
fitp <- profilepl(D, Strauss, swedishpines ~ polynom(x,y,2))
```

### Exercise 11

Repeat Question 7 for the inhomogeneous Strauss process with log-quadratic trend, using the inhomogeneous ![L](https://latex.codecogs.com/png.latex?L "L")-function `Linhom` in place of the usual ![L](https://latex.codecogs.com/png.latex?L "L")-function.
