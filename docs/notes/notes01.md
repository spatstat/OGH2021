Notes for session 1
================
Adrian Baddeley and Ege Rubak
2019-07-02

Introduction
------------

Spatial data: attributed to spatial location

Three main types of spatial data

-   spatial variable (field) eg temperature
-   regional aggregate data eg accident counts in each state
-   spatial point patterns eg locations of crimes/accidents

This workshop is on spatial point patterns

We will use the *spatstat* package in *R*

Spatial point patterns
----------------------

### Points

Spatial coordinates of locations

### Window

Specify window *W* where events could have been observed (this is sometimes a problem)

### Covariates

Explanatory variables

Could be functions *Z*(*u*), *u* ∈ *W*

Could be other spatial objects which must usually be translated into spatial functions.

### Marks

Attributes of the individual events or things eg type of cell, type of accident

Methodologically different from covariates: marks are part of the "response", not the "explanatory variable"

### Examples

Some examples where we reinforce the terms introduced above

Software and data
-----------------

### Spatstat

``` r
library(spatstat)
```

### Data file formats

Data may be provided in many different file formats

-   text file, CSV file
-   shapefile

Brief pointers on data wrangling

For convenience we will use datasets already installed in *spatstat*