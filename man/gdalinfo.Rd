% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gdalinfo.R
\name{gdalinfo}
\alias{gdalinfo}
\title{R interface to GDAL's gdalinfo utility}
\usage{
gdalinfo(datasetname, ..., json, mm, stats, approx_stats, hist, nogcp, nomd,
  norat, noct, checksum, listmdd, mdd, nofl, sd, proj4, oo, config,
  dryrun = FALSE)
}
\value{
Silently returns path to \code{datasetname}.
}
\description{
This function provides an interface mirroring that of the GDAL
command-line app \code{gdalinfo}. For a description of the
utility and the arguments that it takes, see the documentation at
\url{http://www.gdal.org/gdalinfo.html}.
}
\examples{
ff <- system.file("extdata/maunga.tif", package = "gdalUtilities")
gdalinfo(ff)
}
\author{
Josh O'Brien
}
