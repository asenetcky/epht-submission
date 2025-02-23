
<!-- README.md is generated from README.Rmd. Please edit that file -->

# distiller

<!-- badges: start -->

[![R-CMD-check](https://github.com/asenetcky/distiller/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/asenetcky/distiller/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/asenetcky/distiller/graph/badge.svg)](https://app.codecov.io/gh/asenetcky/distiller)
<!-- badges: end -->

## Motivation

As a newbie who has to submit data to the CDC’s EPHT program, I was
dismayed to find out that the documentation is buried under many layers
inside their SharePoint. It is also highly fragmented, convoluted and in
many cases, conflicts with itself.

My goal is to make this process easier and reproducible for myself, and
others.

So who is this highly specific package for?

- Do you submit data to the CDC’s EPHT program?
- Do you use R? Or are interested in incorporating R into your workflow?
- Do you struggle with the CDC’s EPHT documenation and/or tooling?
- Do you want to make your submission process more reproducible?

If you answered yes to the first question and any of the others, then
this package might be for you.

## What does this package do?

I think it’s important to state up front what this package *doesn’t*
do - and that is, it will not wrangle your data for you. There are a few
helpers, and and a whole slew of checks `distiller` will run on your
data and metadata to ensure that everything is reasonably close to the
correct format for submission to the CDC’s EPHT program.

`distiller` still expects your data to have specific variable names, and
to have the required variables for each type of data. However, if you’ve
ever wondered why the epht requires different *variable names* in a
*different order* for the same types of data, even for the *same
disease* you’ll be pleased to know that distiller takes care of the
facility-type-specific naming conventions and the ordering for you.
Users just need to bring the data and now they can spend less time
worrying about XML semantics and more time polishing their data
products.

`disitller` is **no** replacement for the CDC EPHPT Test Submission
portal, however, creating the XML, and shuffling files around and then
dropping them into the portal and waiting an indeterminate amount of
time for feedback eats up time and is a pain. `distiller` aims to
provide feedback on your data and metadata before you send it off to the
CDC. This way, you can fix any obvious issues before you sink 20+
minutes waiting to find out you forgot to replace your `NA`’s with “U”.

## What’s in the box?

`distiller` contains the following core functions:

- `check_submission()` - a function that checks your data and metadata
  and provides quick feedback
- `make_xml_document()` - a function that creates an xml document for
  submission based on your data and the metadata your provide it

`distiller` also contains functions for:

- collapsing race and ethnicity values into the CDC’s required format
- converting month integers to 0-padded character strings
- return the proper health outcome identifier for a given content group
  identifier
- Starting from scratch? Most of the mini-functions that make up the two
  core ones are exposed to the user, so you can check your work in
  pieces as you make progress with your data wrangling

## `distiller` expectations and scope

`distiller` works for the following content group identifiers:

- AS-HOSP
- AS-ED
- CO-HOSP
- CO-ED
- MI-HOSP
- HEAT-HOSP
- HEAT-ED
- COPD-HOSP
- COPD-ED

`distiller` expects the following variables in your data:

For every content group identifier:

- agegroup
- county
- sex
- ethnicity
- race
- health_outcome_id,
- monthly_count
- month
- year

For content group identifiers CO-HOSP and CO-ED, the above plus the
following:

- fire_count
- nonfire_count
- unknown_count

## Installation

You can install the development version of distiller from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("asenetcky/distiller")
```

## Example

Here is a basic example of how to use it:

``` r
library(distiller)

# Take you already-wrangled data
# note the specific variable names
data <-
  mtcars |>
  dplyr::rename(
    month = mpg,
    agegroup = cyl,
    county = disp,
    ethnicity = hp,
    health_outcome_id = drat,
    monthly_count = wt,
    race = qsec,
    sex = vs,
    year = am
  ) |>
  dplyr::select(-c(gear, carb))

# And your metadata
content_group_id <- "AS-HOSP"
mcn <- "1234-1234-1234-1234-1234"
jurisdiction_code <- "two_letter_code"
state_fips_code <- "1234"
submitter_email <- "submitter@email.com"
submitter_name <- "Submitter Name"
submitter_title <- "Submitter Title"

# Optionally check your submission data structure and metadata
check_submission(
  data,
  content_group_id,
  mcn,
  jurisdiction_code,
  state_fips_code,
  submitter_email,
  submitter_name,
  submitter_title
)
#> ℹ Checking submission metadata
#> ✔ Success: content_group_id
#> ! Warning: mcn may not have correct format
#> Troublemakers: length, format
#> ! Warning: jurisdiction_code may not have correct format
#> Troublemakers: length, format
#> ! Warning: state_fips_code may not have correct format
#> Troublemakers: length, format
#> ✔ Success: submitter_email
#> ✔ Success: submitter_name
#> ✔ Success: submitter_title
#> ℹ Checking data structure and content
#> ✔ Success: dataframe_structure
#> ✖ Danger: month does not have allowable value/s
#> Troublemakers: allowed_values
#> ✔ Success: agegroup
#> ✖ Danger: county does not have allowable value/s
#> Troublemakers: length
#> ✖ Danger: ethnicity does not have allowable value/s
#> Troublemakers: allowed_values
#> ✖ Danger: health_outcome_id does not have allowable value/s
#> Troublemakers: allowed_values
#> ✖ Danger: sex does not have allowable value/s
#> Troublemakers: allowed_values
#> ✖ Danger: year does not have allowable value/s
#> Troublemakers: allowed_values
#> ✖ Danger: race does not have allowable value/s
#> Troublemakers: allowed_values
#> ✔ Success: monthly_count
```

``` r
# This can also be checked with `check_first = TRUE` in `make_xml_document()`


# And then make your xml document
make_xml_document(
  data,
  content_group_id,
  mcn,
  jurisdiction_code,
  state_fips_code,
  submitter_email,
  submitter_name,
  submitter_title
)
#> {xml_document}
#> <HospitalizationData schemaLocation="http://www.ephtn.org/NCDM/PH/HospitalizationData ephtn-ph-HospitalizationData.xsd" xmlns="http://www.ephtn.org/NCDM/PH/HospitalizationData" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
#> [1] <Header>\n  <MCN>1234-1234-1234-1234-1234</MCN>\n  <JurisdictionCode>two_ ...
#> [2] <Dataset>\n  <Row>\n    <RowIdentifier>1</RowIdentifier>\n    <AdmissionM ...
```
