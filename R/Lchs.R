#' Lorenz curve with hot spot cutoff
#'
#' Plot a Lorenz curve with a hot spot cutoff on it.
#'
#' @param x \code{"hotspots"} object
#' @param ... further plotting parameters to pass to \code{\link[ineq]{plot.Lc}}
#'
#' @details
#' Uses the function \code{\link[ineq]{plot.Lc}} from the \code{ineq} package to plot a Lorenz curve based on the data in a \code{hotspots} object. The location of the hot spot cutoff on the Lorenz curve is then drawn as a filled black circle.
#'
#' @author Anthony Darrouzet-Nardi
#'
#' @seealso \code{\link{hotspots}}, \code{\link[ineq]{Lc}}, \code{\link[ineq]{plot.Lc}}
#'
#' @examples
#' Lchs(hotspots(rlnorm(100)))
#'
#' @export
Lchs <- function(x, ...) {
if (!inherits(x, "hotspots")) 
	stop("use only with \"hotspots\" objects")
	x.s <- summary(x)
	x.Lc <- Lc(x.s$x)
	plot(x.Lc, ...)
	points(1-x.s$percent_phs*0.01,1-x.s$percent_phs_sum*0.01, cex = 2,pch = 16) }
