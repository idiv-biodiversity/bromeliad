#' Mapping species distributions
#'
#' Produces distribution maps for all species in the selection
#'
#' Modelled ranges are available for 542 species,
#' range polygons for 2395 species. For species with model distribution, the range polygons are based on the models, otherwise
#' on a convex hull around available occurrence records, or a 50 km buffer for species with less than 3 occurrence records available.
#' See Zizka et al 2019 for methods.
#'
#' @param model character string. If \dQuote{binary} presence absence per 100 km grid cell is plotted,
#' if \dQuote{suitability} the modelled habitat suitability is plotted.
#' @param polygon logical. If TRUE, an outline of the range polygon is plotted.
#' @param iucn logical. If TRUE a legend with the conservation assessment is added to the plot.
#' @inheritParams get_range
#'
#' @return a plot for each selected species
#' .
#' @examples
#' map_species(canonical = "Aechmea mexicana")
#'
#' @export
#' @importFrom magrittr %>%
#' @importFrom dplyr filter mutate
#' @importFrom rnaturalearth ne_download
#' @importFrom sp spTransform CRS
#' @importFrom ggplot2 aes annotate element_line ggtitle coord_fixed fortify geom_polygon geom_sf geom_tile ggplot theme xlim ylim
#' @importFrom ggthemes theme_map
#' @importFrom sf st_transform
#' @importFrom viridis scale_fill_viridis
#' @importFrom raster rasterToPoints
#' @importFrom utils data

map_species <-  function(scientific = NULL, canonical = NULL,
                         genus = NULL, subfamily = NULL,
                         life_form = NULL,
                         assessment = NULL, range_size = NULL,
                         model = "suitability",
                         polygon = TRUE, iucn = TRUE){


  match.arg(model, choices = c("binary", "suitability"))

  # projetions
  wgs1984 <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
  behr <- '+proj=cea +lon_0=0 +lat_ts=30 +x_0=0 +y_0=0 +datum=WGS84 +ellps=WGS84 +units=m +no_defs'

  taxonomy_traits <-  bromeliad::taxonomy_traits

  if(polygon){
    #data("all_ranges", envir = environment())
    rang <- get_range(scientific = scientific, canonical = canonical,
                      genus = genus, subfamily = subfamily,
                      life_form = life_form,
                      assessment = assessment, range_size = range_size)
    rang <- st_transform(rang, crs = behr)
  }else{
    rang <- NULL
  }

  if(model == "suitability"){
    #data("model_ensemble", envir = environment())
    suit <- get_range(scientific = scientific, canonical = canonical,
                      genus = genus, subfamily = subfamily,
                      life_form = life_form,
                      assessment = assessment, range_size = range_size,
                      type = "suitability")
  }else{
    suit <- NULL
  }

  if(model == "binary"){
    #data("model_binary", envir = environment())
    bina <- get_range(scientific = scientific, canonical = canonical,
                      genus = genus, subfamily = subfamily,
                      life_form = life_form,
                      assessment = assessment, range_size = range_size,
                      type = "binary")
  }else{
    bina <- NULL
  }

  #background map
  world.inp  <- rnaturalearth::ne_download(scale = 50,
                                           type = 'land',
                                           category = 'physical',
                                           load = TRUE)

  world.behr <- sp::spTransform(world.inp, sp::CRS(behr)) %>% fortify()

  # Background map
  plo_bg <- ggplot()+
    # geom_tile(data = plo_tot, aes(x = x, y = y, fill = layer), alpha = 0.8)+
    # scale_fill_viridis(name = "Species", direction = -1, na.value = "transparent")+
    geom_polygon(data = world.behr,
                 ggplot2::aes(x = .data$long, y = .data$lat, group = .data$group),
                 fill = "transparent", color = "transparent")+
    xlim(-12000000, -3000000)+
    ylim(-6500000, 4500000)+
    coord_fixed()+
    # ggtitle("Bromeliaceae")+
    theme_map()+
    theme(legend.justification = c(0, 0),
          legend.position = c(0, 0))

  if(polygon){
    sps <- unique(rang$tax_accepted_name)

    if(!is.null(bina)){
      mod_li <- names(bina)
    }
    if(!is.null(suit)){
      mod_li <- names(suit)
    }
  }else{
    if(!is.null(bina)){
      sps <- unique(names(bina))
      mod_li <- names(bina)
    }
    if(!is.null(suit)){
      sps <- unique(names(suit))
      mod_li <- names(suit)
    }
  }

  #A loop to produce one map per species and page to
  for(i in 1:length(sps)){
    #title
    plo.subs <- plo_bg+
      ggtitle(sps[i])

    # modelled_distribution
    if(!is.null(bina)){
      mod_sub <- bina[names(bina) == sps[i]]
      mod_sub <-  data.frame(rasterToPoints(mod_sub[[1]]))
      plo.subs <- plo.subs+
        geom_tile(data = mod_sub,
                  ggplot2::aes(x = .data$x, y = .data$y),
                  alpha = 0.8,
                  color = "darkgreen")+
        geom_polygon(data = world.behr,
                     ggplot2::aes(x = .data$long, y = .data$lat, group = .data$group),
                     fill = "transparent",
                     color = "black")+
        theme(legend.position = c(1, 0.1))
    }

    if(!is.null(suit)){
      mod_sub <- suit[names(suit) == sps[i]]
      mod_sub <-  data.frame(rasterToPoints(mod_sub[[1]]))
      plo.subs <- plo.subs+
          geom_tile(data = mod_sub,
                    ggplot2::aes(x = .data$x, y = .data$y, fill = .data$layer),
                    alpha = 0.8)+
          scale_fill_viridis(name = "Habitat\nsuitability",
                             direction = -1,
                             na.value = "transparent")+
        geom_polygon(data = world.behr,
                     ggplot2::aes(x = .data$long, y = .data$lat, group = .data$group),
                     fill = "transparent",
                     color = "black")+
        theme(legend.position = c(1, 0.1))
    }

    #range polygons
    if(!is.null(rang)){
      rang.sub <-  filter(rang, .data$tax_accepted_name == sps[i])

      plo.subs <- plo.subs+
        geom_sf(data = rang.sub,  alpha = 0, colour = "red", datum = NA, fill = "transparent", lwd = 0.5)+
        theme(panel.grid.major = element_line(colour = 'transparent'))
    }

    #Conservation statues
    if(iucn){
      rang.sub <-  filter(taxonomy_traits, .data$tax_accepted_name == sps[i])

      plo.subs <- plo.subs+
        annotate("text",
                 x = -11481867,
                 y = -3698674,
                 label = rang.sub$conv_conr_code,
                 adj = 0,
                 fontface =2,
                 size = 5)+
        annotate("text",
                 x = rep(-11481867, 3),
                 y = c(-4198674, -4707084, -5180102),
                 label = c("EOO:", "AOO:", "Subpop:"),
                 adj = 0)+
        annotate("text", x = rep(-9066197, 3),
                 y = c(-4198674, -4707084, -5180102),
                 label = c(rang.sub$conv_conr_eoo, rang.sub$conv_conr_aoo, rang.sub$conv_conr_pop),
                 adj = 1)
    }


    # Output
    print(plo.subs)
  }


}
