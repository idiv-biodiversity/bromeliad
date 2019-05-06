
#' taxonomy_traits
#'
#' A datset of species known to be phylogenetically derived woody
#'
#' @format A data frame with 17 variables:
#' \describe{
#' \item{\code{tax_accepted_name}}{the accepted species name}
#' \item{\code{tax_genus}}{the genus}
#' \item{\code{tax_tribus}}{the tribus}
#' \item{\code{tax_subfamily}}{the subfamily}
#' \item{\code{geo_range}}{the range size of the species, based on the modelled distribution}
#' \item{\code{conv_conr_eoo}}{the extent of occurrence}
#' \item{\code{conv_conr_aoo}}{the area of occupancy}
#' \item{\code{conv_conr_pop}}{the number of independent populations deived during automated assessment}
#' \item{\code{conv_conr_code}}{The detailled code of the conservation status based on automated assessment}
#' \item{\code{conv_conr_stat}}{The conservation status of the species based on automated conservation assessment}
#' \item{\code{tr_growth_form}}{the growth form of the species from the world checklist of selected plant families}
#' \item{\code{tax_canonical}}{the canonical species name}
#' }
#'
#'
"taxonomy_traits"


#' model_ensemble
#'
#' A list of raster layers, including the habitat suitability for 541 species as defined by ensemble modelling.
#'
#'
"model_ensemble"


#' model_binary
#'
#'
#' A list of raster layers, including the projected binary distributions for 541 species as defined by ensemble modelling.
#'
#'
"model_binary"


#' all ranges
#'
#' Polygons of the geographic distribution for 3295 bromeliad species as derived from distribution modelling.
#' For species with more than 9 occurrence records available modelled using climate SDMs,
#' for species with 3-8 records available modelled by convex hulls, and
#' for species with less than 3 records modelled by a geographic buffer with 50 kilometer radius
#'
#' @format Simple feature collection with 6 features and 1 field
#' geometry type:  GEOMETRY
#' dimension:      XY
#' bbox:           xmin: -78.6167 ymin: -30.27966 xmax: -36.88333 ymax: 0.3333
#' epsg (SRID):    4326
#' proj4string:    +proj=longlat +datum=WGS84 +no_defs
#' \describe{
#' \item{\code{tax_accepted_name}}{the scientific species name}
#' \item{\code{geometry}}{the range polygon of the species}
#' }
#'
#'
"all_ranges"

#' georef_additions
#'
#'
#' A data.frame of occurrence records derived from georeferencing type specimen from the literature.
#'
#' \describe{
#' \item{\code{accepted_name_species}}{}
#' \item{\code{scientificname}}{}
#' \item{\code{family}}{}
#' \item{\code{genus}}{}
#' \item{\code{species}}{}
#' \item{\code{taxonrank}}{}
#' \item{\code{decimallongitude}}{}
#' \item{\code{decimallatitude}}{}
#' \item{\code{coordinate_accuracy}}{}
#' \item{\code{flag}}{}
#' \item{\code{remarks}}{}
#' \item{\code{basisofrecords}}{}
#' \item{\code{source}}{}
#' }
"georef_additions"

