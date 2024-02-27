# Importation et remaniement des données

# Importation des données brutes ------------------------------------------

SciViews::R

# Le package ade4 ne propose pas de tableaux habituels, mais des listes de
#  tableaux.
data("atlas", package = "ade4")
# page d'aide associée aux données
?ade4::atlas

# station -----------------------------------------------------------------
station <- dtx(
  station = attr(atlas$names.district, "names"),
  name = atlas$names.district)

write$csv(station, "data/alps_station.csv")

# birds -------------------------------------------------------------------
birds <- atlas$birds
birds$station <- station$station

write$csv(birds, "data/alps_birds.csv")

# meteo -------------------------------------------------------------------
meteo <- atlas$meteo
meteo$station <- station$station

write$csv(meteo, "data/alps_meteo.csv")
