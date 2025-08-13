<div align="center">

MetamaterialsWithJulia
</div>

MetamaterialsWithJulia est un framework Julia modulaire et performant pour la simulation, l'analyse et l'optimisation de métamatériaux acoustiques, électromagnétiques et mécaniques.

⚠️ Avertissement : Projet de Recherche
Ce dépôt est développé activement dans le cadre de travaux de thèse. Il s'agit d'un prototype de recherche et non d'un logiciel finalisé. Le code et les API sont susceptibles d'évoluer.

🚀 Fonctionnalités Clés
L'architecture du projet est conçue pour être flexible et extensible :

Architecture Abstraite : Une API Problème / Solveur / Résultat permet de découpler la physique des méthodes numériques.

Solveur FEM : Implémentation basée sur le puissant package Gridap.jl.

Optimisation Avancée : Modules pour l'optimisation topologique et géométrique (par algorithme génétique).

Géométries Complexes : Importation de maillages .msh depuis des logiciels de CAO via Gmsh.jl.

Simulations Configurables : Les paramètres des simulations sont gérés via des fichiers .toml pour une meilleure reproductibilité.

Visualisation Découplée : Des outils de traçage qui opèrent sur des objets de résultat standardisés.

📦 Installation
Pour commencer, clonez le dépôt et instanciez l'environnement du projet. Cela installera toutes les dépendances requises.

# 1. Clonez le dépôt
git clone [https://github.com/mounirjaouhari/MetamaterialsWithJulia.git](https://github.com/mounirjaouhari/MetamaterialsWithJulia.git)
cd MetamaterialsWithJulia

# 2. Installez les dépendances
julia --project -e 'using Pkg; Pkg.instantiate()'

📖 Exemples d'Utilisation
Le dossier examples/ contient des scripts prêts à l'emploi pour tester les fonctionnalités.

# Exécuter une simulation 1D à partir d'un fichier de configuration
julia --project examples/1D_acoustic_periodic_from_config.jl

# Calculer et tracer un diagramme de bandes 1D
julia --project examples/bands_1D_bloch.jl

# Lancer une optimisation de géométrie
julia --project examples/optimize_geometry_GA.jl

🧪 Lancer les Tests
Pour vérifier l'intégrité du code, vous pouvez lancer la suite de tests :

julia --project -e "using Pkg; Pkg.test()"

📞 Contact
Pour toute question ou discussion relative à ce projet de recherche, n'hésitez pas à me contacter :

Mounir JAOUHARI

Email : mounir.jaouhari-etu@etu.univh2c.ma

📜 Licence
Ce projet est distribué sous la Licence MIT. Voir le fichier LICENSE pour plus de détails.