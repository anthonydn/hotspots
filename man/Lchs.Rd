\name{Lchs}
\alias{Lchs}
\title{Lorenz curve with hot spot cutoff}
\description{Plot a Lorenz curve with a hot spot cutoff on it.}
\usage{Lchs(x, ...)}
\arguments{
  \item{x}{\code{"hotspots"} object}
  \item{\dots}{further plotting parameters to pass to \code{\link[ineq]{plot.Lc}}}
}
\details{
Uses the function \code{\link[ineq]{plot.Lc}} from the \code{ineq} package to plot a Lorenz curve based on the data in a \code{hotspots} object. The location of the hot spot cutoff on the Lorenz curve is then drawn as a filled black circle.
}

\author{Anthony Darrouzet-Nardi}

\seealso{
\code{\link{hotspots}}, \code{\link[ineq]{Lc}}, \code{\link[ineq]{plot.Lc}}}

\examples{
Lchs(hotspots(rlnorm(100)))}
