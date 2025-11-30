#' Disproportionality
#'
#' Calculates the magnitude of disproportionality for values within a dataset.
#'
#' @param z \code{"hotspots"} object
#'
#' @details
#' Calculates the magnitude of disproportionality for each value within the data by dividing 
#' the difference between each value and the median by the difference between the hot spot cutoff,
#' (\code{Ch}, as calculated by the function \code{\link{hotspots}}), and the median:
#'
#' \code{disproportionality = (x - med(x)) / (Ch - med(x))}
#'
#' Using this equation, all hot spots have a magnitude of disproportionality of > 1. Increasingly skewed distributions
#' (for example, lognormal distributions with higher standard deviation) will have
#' higher magnitudes of disproportionality for some of their values.
#'
#' @return A list containing the objects \code{positive}, \code{negative}, or both, depending on the which tails were
#' calculated in the \code{hotspots} object. These objects are numeric vectors of the magnitudes of disproportionality.
#' NA values are preserved.
#'
#' @author Anthony Darrouzet-Nardi
#'
#' @seealso \code{\link{hotspots}}
#'
#' @examples
#' rln30 <- sort(c(rlnorm(15),rlnorm(15)*-1,NA), na.last = TRUE)
#' rln30
#' disprop(hotspots(rln30, tail = "both"))
#'
#' #higher levels of disproportionality
#' rln30sd2 <- sort(c(rlnorm(15,sd = 3),rlnorm(15,sd = 3)*-1,NA), na.last = TRUE)
#' rln30sd2
#' disprop(hotspots(rln30sd2, tail = "both"))
#'
#' @export
disprop <-
function(z) {
if (!inherits(z, "hotspots"))
	stop("use only with \"hotspots\" objects")
dp <- list(positive = (z$x-median(z$data))/
	(z$positive.cut - median(z$data)),
negative = (z$x-median(z$data))/
	(z$negative.cut - median(z$data)))
if (z$tail == "positive") dp$negative <- NULL
if (z$tail == "negative") dp$positive <- NULL
dp}

