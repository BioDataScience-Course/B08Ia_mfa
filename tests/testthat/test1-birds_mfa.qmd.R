# Vérifications de birds_mfa.qmd
birds <- parse_rmd("../../birds_mfa.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le bloc-notes birds_mfa est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("birds_mfa.qmd"))
  # La version compilée HTML du carnet de notes birds_mfa est introuvable
  # Vous devez créer un rendu de votre bloc-notes Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.
  
  expect_true(is_rendered_current("birds_mfa.qmd"))
  # La version compilée HTML du document Quarto existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document birds_mfa est-elle conservée ?", {
  expect_true(all(c("Introduction et but", "Matériel et méthodes",
    "Résultats", "Description des données météorologiques",
    "Description des recensements des oiseaux", "Ordination",
    "Discussion et conclusions", "Référence")
    %in% (rmd_node_sections(birds) |> unlist() |> unique())))
  # Les sections (titres) attendues du bloc-notes birds_mfa ne sont pas toutes
  # présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).
  
  expect_true(all(c("setup", "importmeteo", "scatmat", "descmeteocomment",
    "importbirds", "raster", "bind", "mfa", "screemfa", "screemfacomment",
    "loadingsmfa", "loadingsmfacomment", "axesmfa", "groupsmfa",
    "groupsmfacomment", "contingencymfa", "contingencymfacomment")
    %in% rmd_node_label(birds)))
  # Un ou plusieurs labels de chunks nécessaires à l'évaluation manquent dans
  # birds_mfa.qmd
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs chunks indispensables par rapport aux exercices sont introuvables.
  # Vérifiez la structure du document par rapport à la version d'origine dans
  # le dépôt "template" du document (lien au début du fichier README.md).
  
  expect_true(any(duplicated(rmd_node_label(birds))))
  # Un ou plusieurs labels de chunks sont dupliqués dans birds_mfa.qmd
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété dans birds_ca ?", {
  expect_true(birds[[1]]$author != "___")
  expect_true(!grepl("__", birds[[1]]$author))
  expect_true(grepl("^[^_]....+", birds[[1]]$author))
  # Le nom d'auteur n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer votre nom dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.
  
  expect_true(grepl("[a-z]", birds[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
  
  expect_true(grepl("[A-Z]", birds[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("Chunks 'importmeteo' : importation et skim de `meteo`", {
  expect_true(is_identical_to_ref("importmeteo", "names"))
  # Les colonnes dans le tableau `meteo` importé ne sont pas celles attendues
  # Votre jeu de données de départ n'est pas correct. Ce test échoue si vous
  # n'avez pas bien rempli le code du chunk 'importmeteo'.
  
  expect_true(is_identical_to_ref("importmeteo", "classes"))
  # La nature des variables (classe) dans le tableau `meteo` est incorrecte
  # Vérifiez le chunk d'importation des données `importmeteo`.
  
  expect_true(is_identical_to_ref("importmeteo", "nrow"))
  # Le nombre de lignes dans le tableau `meteo` est incorrect
  # Vous devez avoir 23 lignes pour 23 stations.
})

test_that("Chunks 'scatmat', 'descmeteocomment' : description des données environnementales", {
  expect_true(is_identical_to_ref("scatmat"))
  # Le graphique produit par le chunk 'scatmat' n'est pas celui attendu.
  # Avez-vous utilisé GGally::ggscatmat() ?
  # Avez-vous réalisé le graphique des 5 variables quantitatives d'intérêt ?
  
  expect_true(is_identical_to_ref("descmeteocomment"))
  # L'interprétation des tableaux descriptifs des données et du graphique sont
  # (partiellement) fausses dans le chunk 'descmeteocomment'
  # Vous devez cochez les phrases qui décrivent les données d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'importbirds' : importation et skim de `birds`", {
  expect_true(is_identical_to_ref("importbirds", "names"))
  # Les colonnes dans le tableau `birds` importé ne sont pas celles attendues
  # Votre jeu de données de départ n'est pas correct. Ce test échoue si vous
  # n'avez pas bien rempli le code du chunk 'importbirds'.
  
  expect_true(is_identical_to_ref("importbirds", "classes"))
  # La nature des variables (classe) dans le tableau `birds` est incorrecte
  # Vérifiez le chunk d'importation des données `importmeteo`.
  
  expect_true(is_identical_to_ref("importbirds", "nrow"))
  # Le nombre de lignes dans le tableau `birds` est incorrect
  # Vous devez avoir 23 lignes pour 23 stations.
})

test_that("Chunks 'raster' : description des données", {
  expect_true(is_identical_to_ref("raster"))
  # Le graphique produit par le chunk 'raster' n'est pas celui attendu.
  # Avez-vous bien ajouté la variable station à `birds` ?
  # Avez-vous pivoté les variables relatives aux oiseaux en tableau long en
  # indiquant comme variable résultat 'species' et comme dénombrement 'n' ?
  # Avez-vous réalisé un graphique chart de ce tableau long en utilisant un
  # geom_raster() ?
})

test_that("Chunks 'bind' : fusion de `meteo` et de `birds`", {
  expect_true(is_identical_to_ref("bind", "names"))
  # Les colonnes dans le tableau `alps` créé ne sont pas celles attendues
  # Votre tableau fusionné n'est pas correct. Est ce que la colonne station a
  # été dupliquée lors de la fusion ? Est ce que la colonne station a bien été
  # convertie en nom des lignes ?  Ce test échoue si vous n'avez pas bien rempli
  # le code du chunk 'bind'.
  
  expect_true(is_identical_to_ref("bind", "classes"))
  # La nature des variables (classe) dans le tableau `alps` est incorrecte.
  
  expect_true(is_identical_to_ref("bind", "rownames"))
  # Les noms des lignes dans le tableau `alps` ne sont pas celles attendues
  # Vous devez transformer en data.frame et ajouter les stations comme nom de
  #  lignes avec la fonction column_to_rownames().
  
  expect_true(is_identical_to_ref("bind", "nrow"))
  # Le nombre de lignes dans le tableau `alps` est incorrect
  # Vous devez avoir 23 lignes pour 23 stations.
})

test_that("Chunks 'mfa', 'screemfa', 'screemfacomment' : AFM, graphique des éboulis et commentaires", {
  # expect_true(is_identical_to_ref("mfa"))
  # L'objet `birds_mfa` n'est pas créé ou il est incorrect.
  # Avez vous employé une formue adaptée pour spécifier votre AFM ? Vérifiez le
  # code dans ce chunk 'mfa' par rapport à la consigne.
  # Assurez-vous de bien assigner le résultat à la variable `birds_mfa`.
  
  expect_true(is_identical_to_ref("screemfa"))
  # Le graphique produit par le chunk 'screemfa' n'est pas celui attendu.
  # Vous devez réaliser le graphique des éboulis de l'AFM en utilisant une
  # variante de chart()
  
  expect_true(is_identical_to_ref("screemfacomment"))
  # L'interprétation de l'AFM et du graphique des éboulis est (partiellement)
  # fausse dans le chunk 'screemfacomment'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'loadingsmfa', 'loadingsmfacomment' : graphique des variables de l'AFM et interprétation", {
  expect_true(is_identical_to_ref("loadingsmfa"))
  # Le graphique des variables de votre AFM n'est pas celui attendu.
  # Assurez-vous de bien utiliser `alps_mfa` et de choisir le bon type de
  # graphique
  
  expect_true(is_identical_to_ref("loadingsmfacomment"))
  # L'interprétation du graphique des variables de l'AFM est (partiellement)
  # fausse dans le chunk 'loadingsmfacomment'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'axesmfa', 'groupsmfa', 'groupsmfacomment' : graphique des axes et des groupes de l'AFM et commentaires", {
  expect_true(is_identical_to_ref("axesmfa"))
  # Le graphique des axes de votre AFM n'est pas celui attendu.
  # Assurez-vous de bien utiliser `alps_mfa` et de réaliser le bon type de
  # graphique
  
  expect_true(is_identical_to_ref("groupsmfa"))
  # Le graphique des groupes de votre AFM n'est pas celui attendu.
  # Assurez-vous de bien utiliser `alps_mfa`
  
  expect_true(is_identical_to_ref("groupsmfacomment"))
  # L'interprétation des graphiques des axes et des groupes  de l'AFM est
  # (partiellement) fausse dans le chunk 'groupsmfacomment'.
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'contingencymfa', 'contingencymfacomment' : Biplot de l'AFM et
  interprétation", {
  expect_true(is_identical_to_ref("contingencymfa"))
  # Le biplot de l'AFM n'est pas fait ou n'est pas celui attendu dans le chunk
  # 'contingencymfa'.
  # Assurez-vous de bien utiliser `alps_mfa`
  
  expect_true(is_identical_to_ref("contingencymfacomment"))
  # L'interprétation du biplot de l'AFM est (partiellement) fausse dans le
  # chunk 'contingencymfacomment'
  # Vous devez cochez les phrases qui décrivent le dendrogramme d'un 'x' entre
  # les crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunk 'conclu_comment' : discussion et conclusions", {
  expect_true(is_identical_to_ref("conclu_comment"))
  # La discussion et les conclusions sont (partiellement)
  # fausses dans le chunk 'conclu_comment'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})
