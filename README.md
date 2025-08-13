MetamaterialsWithJulia est un framework Julia modulaire et performant pour la simulation, l'analyse et l'optimisation de métamatériaux acoustiques, électromagnétiques et mécaniques. L'objectif est de fournir aux chercheurs un outil flexible pour prototyper rapidement des modèles et des algorithmes d'optimisation.

⚠️ Avertissement : Projet de Recherche
Ce dépôt est développé activement dans le cadre de travaux de thèse. Il s'agit d'un prototype de recherche et non d'un logiciel finalisé. Le code et les API sont susceptibles d'évoluer de manière significative. L'utilisation en production n'est pas recommandée à ce stade.

🚀 Fonctionnalités Clés
L'architecture du projet est conçue pour être flexible et extensible, en s'appuyant sur plusieurs piliers fondamentaux :

Architecture Abstraite : Au cœur du framework se trouve une API Problème / Solveur / Résultat. Cette abstraction permet de définir un problème physique (ex: équation de Helmholtz) indépendamment de la méthode numérique utilisée pour le résoudre. Vous pourriez ainsi remplacer le solveur FEM par un solveur FDTD sans avoir à modifier la définition du problème.

Solveur FEM via Gridap.jl : L'implémentation actuelle utilise Gridap.jl, un package d'éléments finis extrêmement puissant et expressif. Il permet de formuler des problèmes variationnels complexes de manière intuitive et performante, ouvrant la voie à des simulations multiphysiques.

Optimisation Avancée : Le framework propose des modules pour l'optimisation topologique (où la distribution de matière est optimisée) et géométrique (où les formes sont optimisées). L'API est conçue pour séparer la fonction objectif de son gradient, ce qui est crucial pour intégrer des méthodes adjointes performantes pour les problèmes à grande échelle.

Géométries Complexes via Gmsh.jl : Ne soyez plus limité aux grilles rectangulaires. Grâce à l'intégration avec Gmsh.jl, vous pouvez créer des géométries complexes dans un logiciel de CAO, les mailler, et importer directement le fichier .msh dans vos simulations pour une représentation fidèle de vos designs.

Simulations Configurables via .toml : La reproductibilité est essentielle en recherche. En externalisant les paramètres des simulations dans des fichiers de configuration .toml clairs et lisibles, vous pouvez facilement gérer des études paramétriques, partager vos expériences et garantir que vos résultats sont reproductibles.

Visualisation Découplée : Les fonctions de calcul retournent des objets Result structurés. Les fonctions de traçage opèrent sur ces objets, et non sur les données brutes du solveur. Ce découplage garantit que si vous mettez à jour la logique d'un solveur, vos scripts de visualisation continueront de fonctionner sans modification.

📂 Structure du Projet
MetamaterialsWithJulia/
├─ Project.toml / Manifest.toml  # Environnement du projet Julia
├─ src/                          # Code source du framework
│  ├─ abstractions.jl            # Types abstraits (Problème, Solveur, Résultat)
│  ├─ Physics/                   # Modèles physiques (acoustique, maxwell...)
│  ├─ Optimization/              # Algorithmes d'optimisation
│  └─ ...
├─ examples/                     # Scripts d'exemples prêts à l'emploi
│  ├─ configs/                   # Fichiers de configuration pour les exemples
│  └─ ...
├─ test/                         # Tests unitaires pour garantir la fiabilité
└─ README.md                     # Ce fichier

📦 Installation
Pour commencer, clonez le dépôt et instanciez l'environnement du projet. Cela installera toutes les dépendances requises listées dans le Project.toml.

Clonez le dépôt :

git clone [https://github.com/mounirjaouhari/MetamaterialsWithJulia.git](https://github.com/mounirjaouhari/MetamaterialsWithJulia.git)
cd MetamaterialsWithJulia

Installez les dépendances :
(Note : la première installation peut prendre plusieurs minutes car Julia doit télécharger et précompiler tous les paquets.)

julia --project -e 'using Pkg; Pkg.instantiate()'

📖 Exemples d'Utilisation
Le dossier examples/ contient des scripts prêts à l'emploi pour illustrer les capacités du framework.

# Cet exemple montre comment simuler la transmission à travers
# un cristal photonique/phonique 1D et identifier les bandes interdites (band gaps).
julia --project examples/1D_acoustic_periodic_from_config.jl

# Cet exemple calcule la relation de dispersion ω(k) pour une structure
# périodique, une analyse fondamentale pour les métamatériaux.
julia --project examples/bands_1D_bloch.jl

# Cet exemple utilise un algorithme génétique pour trouver les paramètres
# géométriques optimaux d'une structure afin de maximiser un objectif donné.
julia --project examples/optimize_geometry_GA.jl

🧪 Lancer les Tests
Pour vérifier que toutes les composantes du framework fonctionnent correctement après une modification, vous pouvez lancer la suite de tests automatisés.

julia --project -e "using Pkg; Pkg.test()"

📞 Contact
Pour toute question ou discussion relative à ce projet de recherche, n'hésitez pas à me contacter :

Mounir JAOUHARI

Email : mounir.jaouhari-etu@etu.univh2c.ma

📜 Licence
Ce projet est distribué sous la Licence MIT. Voir le fichier LICENSE pour plus de détails.
