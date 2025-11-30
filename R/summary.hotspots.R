#' Summarizing hot spot and outlier cutoffs
#'
#' \code{summary} method for class \code{"hotspots"}.
#'
#' @param object \code{"hotspots"} object
#' @param ... further arguments passed to or from other methods
#'
#' @details
#' The importance of hot spots within the data is evaluated by reporting the number of hot spots, the percentage of values that are hot spots, and the percent of the sum of values attributable to hot spots. The percent of the sum of values is likely only relevant if the data are either all positive or all negative. A warning is given if they are not.
#'
#' @return A summary.hotspots object is a list containing all of the objects in a \code{\link{hotspots}} object as well as the following:
#' \item{num_phs}{number of positive hot spots or outliers in data}
#' \item{percent_phs}{percent of values identified as positive hot spots or outliers}
#' \item{percent_phs_sum}{percent of the sum of the values attributable to positive hot spots or outliers}
#' \item{num_nhs}{number of negative hot spots or outliers in data}
#' \item{percent_nhs}{percent of values identified as negative hot spots or outliers}
#' \item{percent_nhs_sum}{percent of the sum of the values attributable to negative hot spots or outliers}
#' \item{stats_standard}{A data frame containing standard summary statistics: mean, sd, se, cv, min, max}
#' \item{stats_robust}{A data frame containing robust summary statistics: median, mad (or other specified estimator), se (based on mad), cv (based on mad/median)}
#' \item{disprop}{vector of levels of disproportionality as calculated by \code{\link{disprop}}}
#'
#' @author Anthony Darrouzet-Nardi
#'
#' @seealso \code{\link{hotspots}}, \code{\link{plot.hotspots}}, \code{\link{disprop}}
#'
#' @examples
#' rln100.sum <- summary(hotspots(rlnorm(101), tail = "both"))
#' rln100.sum 
#' print(rln100.sum, top = 10, p_round = 0)
#'
#' @method summary hotspots
#' @export
summary.hotspots <-
function(object, ...) {
z <- object
if (!inherits(z, "hotspots"))
	stop("use only with \"hotspots\" objects")
h = TRUE ; c = TRUE
if (is.null(z$positive.cut)) h = FALSE
if (is.null(z$negative.cut)) c = FALSE

if (h) {
z$num_phs <- length(z$data[z$data > z$positive.cut])
z$percent_phs <- (length(z$data[z$data > z$positive.cut])/length(z$data))*100
z$percent_phs_sum <- (sum(z$data[z$data > z$positive.cut])/sum(z$data))*100 }

if(c) {
z$num_nhs <- length(z$data[z$data < z$negative.cut])
z$percent_nhs <- (length(z$data[z$data < z$negative.cut])/length(z$data))*100
z$percent_nhs_sum <- (sum(z$data[z$data < z$negative.cut])/sum(z$data))*100 }

m <- mean(z$data)
s <- sd(z$data)
n <- length(z$data)
stats_standard <- data.frame(
  mean = m,
  sd = s,
  se = s/sqrt(n),
  cv = s/m,
  min = min(z$data),
  max = max(z$data)
)
z$stats_standard <- stats_standard

med <- median(z$data)
md <- eval(parse(text = z$var.est))(z$data)
stats_robust <- data.frame(
  median = med,
  mad = md,
  se = md/sqrt(n),
  cv = md/med
)
z$stats_robust <- stats_robust

z$disprop <- disprop(z)

class(z) <- "summary.hotspots"
z }