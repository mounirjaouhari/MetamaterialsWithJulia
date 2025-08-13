<div align="center">

![MetamaterialsWithJulia Logo](./images/MetamaterialsWithJulia.jpg)

</div>

### ⚠️ Avertissement : Projet en Cours de Développement

**Ce dépôt est actuellement en cours de développement actif dans le cadre de mes travaux de thèse. Il s'agit d'un prototype de recherche et non d'un logiciel finalisé.**

Le code est susceptible de subir des modifications importantes, des refactorisations ou des changements d'API sans préavis. Les fonctionnalités peuvent être incomplètes ou contenir des bogues. L'objectif principal de ce dépôt est de tester des idées et des algorithmes.

## Description

`MetamaterialsWithJulia` est un framework dont l'ambition est de fournir un environnement robuste et flexible pour la modélisation, l'analyse et l'optimisation de métamatériaux (acoustiques, électromagnétiques, mécaniques).

L'architecture est conçue pour être modulaire, en séparant clairement la définition des problèmes physiques des solveurs numériques, afin de faciliter l'expérimentation et l'extension du code.

## Installation

Pour utiliser ce projet, clonez le dépôt et instanciez l'environnement Julia. Cela installera toutes les dépendances listées dans le fichier `Project.toml`.

1.  **Clonez le dépôt :**
    ```bash
    git clone [https://github.com/votre-utilisateur/MetamaterialsWithJulia.git](https://github.com/votre-utilisateur/MetamaterialsWithJulia.git)
    cd MetamaterialsWithJulia
    ```

2.  **Installez les dépendances :**
    Ouvrez une session Julia dans le dossier du projet et exécutez la commande suivante :
    ```julia
    using Pkg; Pkg.instantiate()
    ```
    Ou directement depuis votre terminal :
    ```powershell
    julia --project -e 'using Pkg; Pkg.instantiate()'
    ```

## Comment Exécuter les Exemples

Le dossier `examples/` contient plusieurs scripts pour démontrer les fonctionnalités du framework.

```powershell
# Pour exécuter la simulation 1D à partir d'un fichier de configuration
julia --project examples/1D_acoustic_periodic_from_config.jl

# Pour calculer un diagramme de bandes 1D
julia --project examples/bands_1D_bloch.jl

# Pour lancer une optimisation de géométrie
julia --project examples/optimize_geometry_GA.jl
