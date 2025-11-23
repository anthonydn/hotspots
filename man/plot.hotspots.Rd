\name{plot.hotspots}
\alias{plot.hotspots}
\title{
Plotting hot spot and outlier cutoffs}
\description{
\code{plot} method for class \code{"hotspots"}.
}
\usage{
## S3 method for "hotspots" objects
\method{plot}{hotspots}(x, pch = par("pch"), ...)
}
\arguments{
  \item{x}{\code{"hotspots"} object}
  \item{pch}{plotting character. See \code{\link{par}}}
  \item{\dots}{further plotting parameters to pass to \code{\link[lattice]{densityplot}}}
}
\details{
Uses the function \code{\link[lattice]{densityplot}} from the \code{lattice} package to show the distribution of the data and the position
of the positive and/or negative hot spot or outlier cutoffs.
}
\value{
An object of class \code{"trellis"}.
}
\author{Anthony Darrouzet-Nardi}

\seealso{
\code{\link{hotspots}}, \code{\link{summary.hotspots}}, \code{\link[lattice]{densityplot}}}

\examples{
#both tails on skewed data
rln100pn <- hotspots(c(rlnorm(50),rlnorm(50)*-1),tail = "both")
plot(rln100pn)

#modify graphical parameters
plot(rln100pn, pch = 16, cex = 1.5)
}