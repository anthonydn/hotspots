\name{summary.hotspots}
\alias{summary.hotspots}
\alias{print.summary.hotspots}
\title{
Summarizing hot spot and outlier cutoffs}
\description{
\code{summary} method for class \code{"hotspots"}.
}
\usage{
## S3 method for "hotspots" objects
\method{summary}{hotspots}(object, ...)

## S3 method for "summary.hotspots" objects
\method{print}{summary.hotspots}(x, digits = max(3, getOption("digits") - 3), p_round = 1, top = 0, ...)
}
\arguments{
  \item{object}{\code{"hotspots"} object}
  \item{x}{\code{"summary.hotspots"} object}
  \item{digits}{the number of significant digits to use when printing}
  \item{p_round}{the number of decimal places to print for percentages when printing}
  \item{top}{the number of the most disproportionate (highest or lowest) data values to 
  print with their percent contributions to the total}
  \item{\dots}{further arguments passed to or from other methods}
  }
\details{
The importance of hot spots within the data is evaluated by reporting the number of hot spots, the percentage of values that are hot spots, and the percent of the sum of values attributable to hot spots. The percent of the sum of values is likely only relevant if the data are either all positive or all negative. A warning is given if they are not.
}
\value{
A summary.hotspots object is a list containing all of the objects in a \code{\link{hotspots}} object as well as the following:

\item{num_phs}{number of positive hot spots or outliers in data}
\item{percent_phs}{percent of values identified as positive hot spots or outliers}
\item{percent_phs_sum}{percent of the sum of the values attributable to positive hot spots or outliers}
\item{num_nhs}{number of negative hot spots or outliers in data}
\item{percent_nhs}{percent of values identified as negative hot spots or outliers}
\item{percent_nhs_sum}{percent of the sum of the values attributable to negative hot spots or outliers}
\item{m}{A list of summary statistics pertaining to the data (mean, median, min, max, scale 
(determined by the argument '\code{var.est} in the \code{\link{hotspots}} function), and coefficient of variation (scale/median)})
\item{disprop}{vector of levels of disproportionality as calculated by \code{\link{disprop}}}
}
\author{Anthony Darrouzet-Nardi}

\seealso{
\code{\link{hotspots}}, \code{\link{plot.hotspots}}, \code{\link{disprop}}}
\examples{
rln100.sum <- summary(hotspots(rlnorm(101), tail = "both"))
rln100.sum 
print(rln100.sum, top = 10, p_round = 0)
}