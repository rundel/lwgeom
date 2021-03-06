#' @importFrom Rcpp evalCpp
#' @import sf
#' @importFrom units set_units make_unit
#' @useDynLib lwgeom
NULL

.onAttach = function(libname, pkgname) {
	m = paste("Linking to liblwgeom", CPL_lwgeom_version())
	CPL_init_lwgeom(NA_character_)
	packageStartupMessage(m)
}

#' Provide the external dependencies versions of the libraries linked to sf
#' 
#' Provide the external dependencies versions of the libraries linked to sf
#' @export
lwgeom_extSoftVersion = function() {
	structure(CPL_lwgeom_version(), names = c("lwgeom"))
}

crs_parameters = function(x) {
	if (utils::packageVersion("sf") > "0.5-5")
		st_crs(x, parameters = TRUE)
	else # hard-code the outcome for st_crs(4326):
		structure(list(SemiMajor = structure(6378137, units = structure(list(
    		numerator = "m", denominator = character(0)), .Names = c("numerator", 
		"denominator"), class = "symbolic_units"), class = "units"), 
    		InvFlattening = 298.257223563), .Names = c("SemiMajor", "InvFlattening"
		))
}
