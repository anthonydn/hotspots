#' Plotting hot spot and outlier cutoffs
#'
#' \code{plot} method for class \code{"hotspots"}.
#'
#' @param x \code{"hotspots"} object
#' @param pch plotting character. See \code{\link{par}}
#' @param ... further plotting parameters to pass to \code{\link[lattice]{densityplot}}
#'
#' @details
#' Uses the function \code{\link[lattice]{densityplot}} from the \code{lattice} package to show the distribution of the data and the position
#' of the positive and/or negative hot spot or outlier cutoffs.
#'
#' @return An object of class \code{"trellis"}.
#'
#' @author Anthony Darrouzet-Nardi
#'
#' @seealso \code{\link{hotspots}}, \code{\link{summary.hotspots}}, \code{\link[lattice]{densityplot}}
#'
#' @examples
#' #both tails on skewed data
#' rln100pn <- hotspots(c(rlnorm(50),rlnorm(50)*-1),tail = "both")
#' plot(rln100pn)
#'
#' #modify graphical parameters
#' plot(rln100pn, pch = 16, cex = 1.5)
#'
#' @method plot hotspots
#' @export
plot.hotspots <-
function(x, pch = par("pch"), ...) {
if (!inherits(x, "hotspots")) 
	stop("use only with \"hotspots\" objects")
h = TRUE ; c = TRUE
if (is.null(x$positive.cut)) h = FALSE
if (is.null(x$negative.cut)) c = FALSE

color <- rep("black", length(x$data))
if (h) color[x$data > min(x$positive.cut)] <- "red"
if (c) color[x$data < max(x$negative.cut)] <- "blue"

pc <- rep(pch, length(x$data))

if (h)
	{upper <- max(c(x$data,x$positive.cut))} else
		upper <- max(x$data)
if (c)
	{lower <- min(c(x$data,x$negative.cut))} else
		lower <- min(x$data)
lim <- c(lower-(upper-lower)*0.1, upper+(upper-lower)*0.1)

if (h) pcut <- x$positive.cut
if (c) ncut <- x$negative.cut
densityplot(~c(NA, x$data), col = c("black", color), pch = c(NA, pc),
	xlim = lim, xlab = x$dataset_name,
	panel = function(x,...) {
		panel.densityplot(x,...,)
		if (h) panel.abline(v = pcut, col = "red")
		if (c) panel.abline(v = ncut, col = "blue") }, ... ) }
