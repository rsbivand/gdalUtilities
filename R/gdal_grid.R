##' This function provides an interface mirroring that of the GDAL
##' command-line app \code{gdal_grid}. For a description of the
##' utility and the arguments that it takes, see the documentation at
##' \url{http://www.gdal.org/gdal_grid.html}.
##'
##' @title R interface to GDAL's gdal_grid utility
##' @return None. Called instead for its side effect.
##' @export
##' @author Josh O'Brien
##' @examples
##' \dontrun{
##' ## Set up file paths
##' td <- tempdir()
##' dem_file <- file.path(td, "dem.csv")
##' vrt_header_file <- file.path(td, "tmp.vrt")
##' out_raster <- file.path(td, "tmp.tiff")
##'
##' ## Create file of points with x-, y-, and z-coordinates
##' pts <-
##'     data.frame(Easting = c(86943.4, 87124.3, 86962.4, 87077.6),
##'                Northing = c(891957, 892075, 892321, 891995),
##'                Elevation = c(139.13, 135.01, 182.04, 135.01))
##' write.csv(pts, file = dem_file, row.names = FALSE)
##'
##' ## Prepare a matching VRT file
##' vrt_header <- c(
##' '<OGRVRTDataSource>',
##' '  <OGRVRTLayer name="dem">',
##' paste0('    <SrcDataSource>',dem_file,'</SrcDataSource>'),
##' '    <GeometryType>wkbPoint</GeometryType>',
##' '    <GeometryField encoding="PointFromColumns" x="Easting" y="Northing" z="Elevation"/>',
##' '  </OGRVRTLayer>',
##' '</OGRVRTDataSource>'
##' )
##' cat(vrt_header, file = vrt_header_file, sep = "\n")
##'
##' ## Test it out
##' gdal_grid(src_datasource = vrt_header_file,
##'           dst_filename = out_raster,
##'           a = "invdist:power=2.0:smoothing=1.0",
##'           txe = c(85000, 89000), tye = c(894000, 890000),
##'           outsize = c(400, 400),
##'           of = "GTiff", ot = "Float64", l = "dem")
##'
##' ## Check that it works
##' if(require(raster)) {
##'     plot(raster(out_raster))
##'     text(Northing ~ Easting, data = pts,
##'          labels = seq_len(nrow(pts)), cex = 0.7)
##' }
##' }
gdal_grid <-
    function(src_datasource, dst_filename, ..., ot, of, txe, tye,
             outsize, a_srs, zfield, z_increase, z_multiply, a, spat,
             clipsrc, clipsrcsql, clipsrclayer, clipsrcwhere, l,
             where, sql, co, q, config,
             dryrun = FALSE)
{
    ## Unlike `as.list(match.call())`, forces eval of arguments
    args <-  mget(names(match.call())[-1])
    args[c("src_datasource", "dst_filename", "dryrun")] <- NULL
    formalsTable <- getFormalsTable("gdal_grid")
    opts <- process_args(args, formalsTable)

    if(dryrun) {
        x <- CLI_call("gdal_grid", src_datasource, dst_filename, opts=opts)
        return(x)
    }

    gdal_utils("grid", src_datasource, dst_filename, opts)
    invisible(dst_filename)
}
