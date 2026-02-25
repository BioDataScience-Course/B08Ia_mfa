# Analyse factorielle multiple d'oiseaux alpins

L'analyse factorielle multiple (AFM) permet de faire de l'ordination à partir de plusieurs tableaux simultanément, que ces tableaux soient traités comme une ACP ou comme une AFC. Vous devez avoir assimilé la partie sur l'AFM du module 8 du cours de science des données biologiques 2. Ce projet correspond au template <https://github.com/BioDataScience-Course/B08Ia_mfa>. Il est distribué sous licence [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

## Objectifs

Ce projet, individuel et cadré, vous permettra de démontrer que vous avez acquis les compétences suivantes :

-   réaliser une analyse factorielle multiple
-   interpréter les résultats d'une analyse factorielle multiple

## Consignes

Complétez le document Quarto `birds_mfa.qmd`. Faites un "Rendu" de ce document en HTML à la fin pour vérifier que tout fonctionne bien (à ce stade de votre formation, laisser des erreurs qui empêchent la compilation du document Quarto en HTML est considéré comme une erreur grave et ne nous permet donc pas d'attribuer des points au projet). Utilisez les tests à disposition dans l'onglet "Construire" -\> bouton "Construire tout" pour détecter vos erreurs. Vérifiez également que le dernier commit a bien été pushé sur GitHub avant la deadline.

## Utilisation de l’IA

Dans le cadre de votre travail, vous pouvez utiliser l’intelligence artificielle. Il est toutefois impératif de préciser, dans la section « Matériel et méthodes » du projet, que l’IA a été utilisée, en indiquant le contexte et la manière dont elle a été employée. Voici un exemple de formulation :

```
La relecture (orthographe et syntaxe) a été réalisée à l’aide de Microsoft Copilot (basé sur GPT-5), consulté le 12 janvier 2026.
```
Attention, vous devez néanmoins employer le dialecte SciViews-R afin de garantir votre compréhension du cours de Science des données biologiques 2 lors de la production de code R dans votre projet.

Un chatbot SciViews est également disponible dans RStudio (Saturn Cloud), via l’addin Help. Il répond aux questions relatives au langage R, aux statistiques et à la science des données.

## Informations sur les données

Les jeux de données utilisés (`alps_birds.csv`, `alps_meto.csv`) proviennent du package {ade4} et sont initialement regroupés dans `atlas` sous forme d'une liste de tableaux. Le script `R/import.R` en extrait les différents tableaux nécessaires à vos analyses. Le travail a déjà été fait pour vous et vos donné&es sont prêtes dans le dossier `data`. La page pour l'ensemble des données est accessible ici : `?ade4::atlas`.

