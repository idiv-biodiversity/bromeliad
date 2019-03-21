#' Select Bromeliaceae Species Ranges by Taxonomy and Traits
#'
#'Get the geographic range for all species selected via the arguments.
#'The type of range estimate depends on the \dQuote{type} argument.
#'
#'Modelled ranges are available for 542 species,
#'range polygons for 2395 species. For species with model distribution, the range polygons are based on the models, otherwise
#'on a convex hull around available occurrence records, or a 50 km buffer for species with less than 3 occurrence records available.
#'See Zizka et al 2019 for methods.
#'
#' @param scientific a character vector of full scientific names including authorities, of the species of interest
#' @param canonical a character vector of canonical names, of the species of interest.
#' @param genus a character vector of genera names to select.
#' @param subfamily a character vector of subfamily names to select.
#' @param life_form a character vector of life forms to select.
#' @param assessment a character vector of conservation assessment to select.
#' @param range_size a vector of two numericals with the minimum and maximum range size (in square kilometres), to select.
#' @param type a cahracter defining the output format, see details
#'
#' @return Depending on the \dQuote{type} argument. If \dQuote{binary} a presence/absence raster based on the modelled habitat suitability,
#'  at 100x100 km resolution in Behrmann projection,
#'  if \dQuote{suitability} the habitat suitability as predicted by an ensemble model in Behrmann projection, and
#'  if {polygon} a simple feature object in lat/lon projection.
#' .
#' @examples
#' get_range(scientific = "Aechmea mexicana Baker")
#' get_range(scientific = "Aechmea mexicana Baker", type = "binary")
#' get_range(scientific = "Aechmea mexicana Baker", type = "suitability")
#' get_range(canonical = "Aechmea mexicana")
#' get_range(genus = "Aechmea")
#' get_range(genus = "Aechmea", type = "binary")
#' get_range(genus = c("Aechmea", "Zizkaea"))
#' get_range(subfamily = "Pitcairnioideae")
#' get_range(life_form = "epiphyte")
#' get_range(assessment = c("CR", "VU"))
#' get_range(range_size = c(1000, 10000))
#'
#' @export
#' @importFrom dplyr filter
#' @importFrom methods as
#' @importFrom rlang .data
#'
#'
get_range <- function(scientific = NULL, canonical = NULL,
                      genus = NULL, subfamily = NULL,
                      life_form = NULL,
                      assessment = NULL, range_size = NULL,
                      type = "polygon"){

  match.arg(type, choices = c("binary", "suitability", "polygon"))

  taxonomy_traits <- bromeliad::taxonomy_traits

  if(!is.null(scientific)){
    taxonomy_traits <- dplyr::filter(taxonomy_traits, .data$tax_accepted_name %in% scientific)
  }

  if(!is.null(canonical)){
    taxonomy_traits <- dplyr::filter(taxonomy_traits, .data$tax_canonical %in% canonical)
  }

  if(!is.null(genus)){
    taxonomy_traits <- dplyr::filter(taxonomy_traits, .data$tax_genus %in% genus)
  }

  if(!is.null(subfamily)){
    taxonomy_traits <- dplyr::filter(taxonomy_traits, .data$tax_subfamily %in% subfamily)
  }

  if(!is.null(life_form)){
    taxonomy_traits <- dplyr::filter(taxonomy_traits, .data$tr_growth_form %in% life_form)
  }

  if(!is.null(assessment)){
    taxonomy_traits <- dplyr::filter(taxonomy_traits, .data$conv_conr_stat %in% assessment)
  }

  if(!is.null(range_size)){
    taxonomy_traits <- dplyr::filter(taxonomy_traits, .data$geo_range > range_size[1] & .data$geo_range < range_size[2])
  }

  switch(type,
         binary = {model_binary <-  bromeliad::model_binary; out <- model_binary[which(names(model_binary) %in% taxonomy_traits$tax_accepted_name)]},
         suitability = {model_ensemble <- bromeliad::model_ensemble; out <- model_ensemble[which(names(model_ensemble) %in% taxonomy_traits$tax_accepted_name)]},
         polygon = {all_ranges <- bromeliad::all_ranges; out <- dplyr::filter(all_ranges, .data$tax_accepted_name %in% taxonomy_traits$tax_accepted_name)}
           )

  class(out) <- c("bromeli", class(out))

  return(out)
}
