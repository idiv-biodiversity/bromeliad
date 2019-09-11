# bromeliad 0.9-2

A data package with distribution data for 2272 bromeliaceae species across tropical America.

## Included data
The package includes five data files:

1. `taxonomy traits` - a data.frame with taxonomy, traits and conservation assessment for the included species.
2. `all_ranges` - a simple features object containing range polygons for all 2395 species.
3. `model_binary` - a list of presence/absence rasters, for 541 species for which the ranges were estimated based on climate suitability models
4. `model_ensemble` - a list of rasters with habitat suitability, for 541 species for which the ranges were estimated based on climate suitability models
5. `digitized_records` - a data.frame with the point locations of XXX species type specimens, georeferenced from the literature for this package

## Installation
The package can be installed from github using `devtools::install_github`
```{r}
library(devtools)

install_github("idiv-biodiversity/bromeliad")

library(bromeliad)
```

## Documentation
The pacakge also includes some convinieince functions to select taxa and visualize species ranges and diversity. A vignette describing how to select individual taxa and visualize species distributions and diversity patterns is available [here]().

## Contribute
If you want to contribute with new species or corrections, please contact the [maintainer](mailto:alexander.zizka@idiv.de) of the package.

## Licence
The package and data are available under a GPL-3 license.

## Citation
Please cite the package as Zizka A *et al.* (2019) bromeliad. An R package for biogeography and conservations tatus of Bromeliaceae.
