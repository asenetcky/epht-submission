% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/collapse_demographics.R
\name{collapse_ethnicity}
\alias{collapse_ethnicity}
\title{Collapse Ethnicity based on EPHT logic}
\usage{
collapse_ethnicity(ethnicity, na_is_unknown = TRUE)
}
\arguments{
\item{ethnicity}{Character string of the ethnicity value.}

\item{na_is_unknown}{Convert NAs to "U" or leave as-is, default is \code{TRUE}.}
}
\value{
Ethnicity string or NA_character_
}
\description{
Collapse common ethnicity values to the EPHT's allowable values:
"H", "NH", "U"
}
\details{
If there are any other values, they will be converted to "U". \code{NULL} or
\code{NA} values can be converted to "U" or left as \code{NA_character_}
}
\section{Ethnicity Values}{
Character strings are converted to lowercase and stripped of any non-word
characters. This is to ensure that the values are standardized before
comparison.

Common values that get converted are:
\itemize{
\item hispanic, hisp, h -> "H"
\item nonhispanic, nonhisp, nh -> "NH"
\item unknown, unk, u -> "U"
}
}

\examples{
collapse_ethnicity("Hispanic")
}
\seealso{
Other helpers: 
\code{\link{collapse_race}()},
\code{\link{make_months_worse}()},
\code{\link{parse_health_outcome_id}()}
}
\concept{helpers}
