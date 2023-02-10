#' Complete list of palettes
#'
#' Use \code{\link{drygate_palette}} to construct palettes of desired length.
#'
#' @export
drygate_palettes <- list(
  DiscoForkliftTruck = c("#2d2c2b", "#f29f17","#e54b5d","#77b44a","#eee204", "#fdfdfd"),
  TakeMeTotheRiver = c("#792149","#ed347e","#34b77b","#c0d73d","#fcd92c","#cfd0d2","#fefefe"),
  CrossingtheRubicon = c("#08162e", "#cfd0d2", "#eb1d56", "#f05666", "#f7a02d", "#0fc0d2", "#ffffff"),
  CrossingtheRubicon_auto = c("#08162e", "#ecd2c3", "#e42257", "#16b3c6", "#e27076", "#8a5b7b", "#da8fae")
  )

#' A Drygate brewery palette generator
#'
#' These are a handful of color palettes from Drygate brewery.
#'
#' @param n Number of colors desired. Unfortunately most palettes now only
#'   have 4 or 5 colors. If omitted, uses all colours.
#' @param name Name of desired palette. Choices are:
#'   \code{DiscoForkliftTruck}, \code{TakeMeTotheRiver},  \code{CrossingtheRubicon},
#'   \code{CrossingtheRubicon_auto}
#' @param type Either "continuous" or "discrete". Use continuous if you want
#'   to automatically interpolate between colours.
#'   @importFrom graphics rgb rect par image text
#' @return A vector of colours.
#' @export
#' @keywords colors
#' @examples
#' drygate_palette("DiscoForkliftTruck")
#' drygate_palette("TakeMeTotheRiver")
#' drygate_palette("CrossingtheRubicon")
#' drygate_palette("CrossingtheRubicon_auto")
#'
#' # If you need more colours than normally found in a palette, you
#' # can use a continuous palette to interpolate between existing
#' # colours
#' pal <- drygate_palette(21, name = "DiscoForkliftTruck", type = "continuous")
#' image(volcano, col = pal)
drygate_palette <- function(name, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)

  pal <- drygate_palettes[[name]]
  if (is.null(pal))
    stop("Palette not found.")

  if (missing(n)) {
    n <- length(pal)
  }

  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colors greater than what palette can offer")
  }

  out <- switch(type,
                continuous = grDevices::colorRampPalette(pal)(n),
                discrete = pal[1:n]
  )
  structure(out, class = "palette", name = name)
}

#' @export
#' @importFrom graphics rect par image text
#' @importFrom grDevices rgb
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n), col = x,
        ylab = "", xaxt = "n", yaxt = "n", bty = "n")

  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "name"), cex = 1, family = "serif")
}

# # Examples
# drygate_palette("DiscoForkliftTruck")
# drygate_palette("CrossingtheRubicon")
# drygate_palette("CrossingtheRubicon")
# drygate_palette("CrossingtheRubicon_auto")

#' heatmap
#'
#' A heatmap example
"heatmap"


