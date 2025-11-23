\name{hotspots}
\alias{hotspots-package}
\alias{hotspots}
\alias{outliers}
\alias{print.hotspots}
\title{Hot spots and outliers}
\description{
Calculates a hot spot or outlier cutoff for a statistical population
based on deviance from the normal or t distribution. In the case of
the hot spot cutoff, the relative magnitude of the values is also
taken into account to determine if values are disproportionately 
large relative to other values. Thus, a value that is a statistical
outlier may not always be a hot spot if other values are similarly large.
}
\usage{
hotspots(x, p = 0.99, tail = "positive", distribution = "t", var.est = "mad")

outliers(x, p = 0.99, tail = "positive", distribution = "t", var.est = "mad",
  center.est = "mean")
}
\arguments{
 \item{x}{
a numeric vector
}
 \item{p}{
probability level of chosen distribution used for calculation of cutoff (between 0 and 1)
 }
 \item{tail}{
determines whether cutoffs are calculated for positive numbers within \code{x}, 
negative numbers, or both. Defaults to \code{"positive"} but can also be \code{"negative"} or
\code{"both"}.
}
 \item{distribution}{
statistical distribution used to calculate the hot spot or outlier cutoff. Defaults to \code{"t"}
but can also be "normal". Other distributions could be implemented through simple modifications
to the source code.
}
 \item{var.est}{
character vector indicating the function to be used to estimate the level of variation within the data.
Defaults to the robust measure \code{"mad"}. Non-robust measures such as \code{"sd"} may also be used, but result in greater variation in cutoff location.
}
\item{center.est}{
character vector indicating the function to be used to center the data for identification of outliers.
Defaults to \code{"mean"}.
}
}
\details{

This function first scales the data by dividing them by a
robust version of the root mean square. The robust
root mean square (\code{rrms}) is calculated as:

\code{rrms = sqrt(med(x)^2 + var.est(x)^2)}

where \code{var.est} is the user-specified function for estimating the level of variation within the data.
This scaling of the data allows for the comparison of scaled values with a statistical distribution,
which in turn allows discrimination between outliers that do not substantially influence the data
from those that do. For the outlier function, the data are scaled after centering the 
data using the user-specified center.est function, which defaults to the mean.
The hotspot or outlier cutoff (for positive values, negative values, or both) is then calculated as:

\code{cutoff = (med(x/rrms) + F^-1(p))*rrms}

where \code{F} is a cumulative distribution function for the t or normal distribution
(its inverse \code{F^-1} being a quantile function; e.g., \code{qt}),
and \code{p} is a user-defined parameter indicating the probability of \code{F^-1} beyond which we wish
to define the cutoff.
}
\value{
Returns an object of class "\code{hotspots}". The functions \code{summary} and \code{plot}, can be used to
examine the properties of the cutoff. The function \code{\link{disprop}} can be used to calculate 
the level of disproportionality for each value in the data. An object of class "\code{hotspots}" 
is a list containing some or all of the following components:
\item{x}{numeric input vector}
\item{data}{vector with missing values (\code{NA}) removed}
\item{distribution}{statistical distribution used to calculate the hot spot or outlier cutoff.}
\item{var.est}{function used to estimate the level of variation within the data}
\item{p}{probability level of chosen distribution used for calculation of cutoff}
\item{tail}{tail(s) of data for which cutoffs were calculated}
\item{dataset_name}{character vector with name of input data}
\item{rrms}{robust root mean square}
\item{positive.cut}{calculated hot spot or outlier cutoff for positive values}
\item{negative.cut}{calculated hot spot or outlier cutoff for negative values}
\item{center.est}{function to be used to center the data for identification of outliers (only for \code{outliers} function}
}
\author{Anthony Darrouzet-Nardi}

\seealso{
\code{\link{summary.hotspots}}, \code{\link{plot.hotspots}}, \code{\link{disprop}}
}
\examples{
#basic operation on lognormal data
rln100 <- hotspots(rlnorm(100))
summary(rln100)
plot(rln100)

#greater skew in data
rln100sd2 <- hotspots(rlnorm(100,sd=2))
print(summary(rln100sd2),top = 5)
plot(rln100sd2)

#both tails on normally distributed data
n100 <- hotspots(rnorm(100), tail = "both")
summary(n100)
plot(n100)

#both tails on skewed data
rln100pn <- hotspots(c(rlnorm(50),rlnorm(50)*-1),tail = "both")
summary(rln100pn)
plot(rln100pn)

#importance of disproportionality on normally distributed data
#contrast with n100
n100p3 <- hotspots(n100$x+3, tail = "both")
summary(n100p3)
plot(n100p3)

#importance of disproportionality on skewed data
#contrast with rln100
rln100p10 <- hotspots(rlnorm(100)+10)
summary(rln100p10)
plot(rln100p10)

#outliers function ignores disproportionality 
rln100p10o <- outliers(rlnorm(100)+10)
summary(rln100p10o)
plot(rln100p10o)

#some alternative parameters
rln100a <- hotspots(rlnorm(100), p = 0.9, distribution = "normal",  var.est = "sd")
summary(rln100a)
plot(rln100a)

}
