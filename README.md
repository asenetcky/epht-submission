
<!-- README.md is generated from README.Rmd. Please edit that file -->

# distiller

<!-- badges: start -->

[![R-CMD-check](https://github.com/asenetcky/distiller/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/asenetcky/distiller/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/asenetcky/distiller/graph/badge.svg)](https://app.codecov.io/gh/asenetcky/distiller)
<!-- badges: end -->

Right off the bat I want to say I am in no way affiliated with the CDC.
As someone who now has to submit data to the CDC’s EPHT program I was
dismayed to find out that the documentation is highly convoluted and in
many cases, conflicts with itself. When reaching out to support, they
tell you to read the documentation, which is not helpful. Also, some of
the provided tooling *does not* work if you go through the instructions
provided and do everything in the order as presented. Basically folks
who have been doing this for a while are fine, or have made their peace
with this process and then all the newbies, like me are just endlessly
sending data to the test portal and waiting and waiting and waiting for
results.

My goal is to make this process easier and reproducible for myself, and
others.

So who is this highly specific package for?

- Do you submit data to the CDC’s EPHT program?
- Do you hate documentation that shows variables in the examples that
  don’t exist in the data dictionary or vice-verse?
- Do you hate it when the how-to-guides very clearly show the variables
  in UPPERCASE but then the portal kicks your data back because it
  expects it to be in lowercase?
- Are you baffled by the XML design decisions and lack of consistency in
  the formatting between the different types of facilities?
- Do you hate it when you follow the directions verbatim when using CDC
  tooling, but it constantly throws null-pointer exceptions at you
  because the very first step you were supposed to do was at the end of
  the instruction guide?  
- Do you hate it even more when you reach out to support they tell you
  to read the manual, instead of fixing the manual or even their own
  bug?

If you answered yes to any of these questions, then this package might
be for you

## Installation

You can install the development version of distiller from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("asenetcky/distiller")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(distiller)
## basic example code
```
