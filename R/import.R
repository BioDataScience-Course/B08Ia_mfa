# Importation et remaniement des données
# (ceci est déjà réalisé pour vous, vous ne devez pas exécuter ce script)

# Configuration de l'environnement
SciViews::R
# Le package {ade4} a des données dans des listes de tableaux
atlas <- read("atlas", package = "ade4")
# Page d'aide des données
?ade4::atlas


# stations ----------------------------------------------------------------

stations <- dtx(
  station = attr(atlas$names.district, "names"),
  name    = atlas$names.district)
write$csv(stations, "data/alps_stations.csv")


# birds -------------------------------------------------------------------

birds <- atlas$birds
birds$station <- stations$station
write$csv(birds, "data/alps_birds.csv")


# meteo -------------------------------------------------------------------

meteo <- atlas$meteo
meteo$station <- stations$station
write$csv(meteo, "data/alps_meteo.csv")

# Nettoyage de l'environnement
rm(atlas, stations, birds, meteo)
