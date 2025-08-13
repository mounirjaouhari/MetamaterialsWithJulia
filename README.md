MetamaterialsWithJulia est un framework Julia modulaire et performant pour la simulation, l'analyse et l'optimisation de métamatériaux acoustiques, électromagnétiques et mécaniques. L'objectif est de fournir aux chercheurs un outil flexible pour prototyper rapidement des modèles et des algorithmes d'optimisation, en tirant parti de la vitesse de Julia et de son écosystème scientifique de pointe. Ce projet vise à combler le fossé entre les concepts théoriques et la conception pratique de dispositifs aux propriétés extraordinaires.

⚠️ Avertissement : Projet de Recherche
Ce dépôt est développé activement dans le cadre de travaux de thèse. Il s'agit d'un prototype de recherche et non d'un logiciel finalisé. Le code et les API sont susceptibles d'évoluer de manière significative. L'utilisation en production n'est pas recommandée à ce stade. Les contributions et les rapports de bogues sont les bienvenus via les Issues GitHub, mais la priorité reste l'exploration scientifique.

🚀 Fonctionnalités Clés
L'architecture du projet est conçue pour être flexible et extensible, en s'appuyant sur plusieurs piliers fondamentaux :

Architecture Abstraite : Au cœur du framework se trouve une API Problème / Solveur / Résultat. Cette abstraction puissante permet de définir un problème physique (ex: équation de Helmholtz) indépendamment de la méthode numérique utilisée pour le résoudre. Vous pourriez ainsi développer un solveur par différences finies (FDTD) ou par éléments de frontière (BEM) et le "brancher" sur un problème existant sans avoir à modifier la définition de la physique, ce qui facilite grandement la comparaison de différentes approches numériques.

Solveur FEM via Gridap.jl : L'implémentation actuelle utilise Gridap.jl, un package d'éléments finis extrêmement puissant et expressif. Sa syntaxe, proche de la formulation mathématique, permet de décrire des problèmes variationnels complexes de manière intuitive et performante. Cela ouvre la voie à des extensions futures vers des simulations multiphysiques (thermo-acoustique, etc.) ou non-linéaires.

Optimisation Avancée : Le framework propose des modules pour l'optimisation topologique (où la distribution de matière est optimisée pixel par pixel) et géométrique (où les formes et les dimensions d'inclusions prédéfinies sont optimisées). L'API est conçue pour séparer la fonction objectif de son gradient, ce qui est crucial pour intégrer des méthodes adjointes performantes, une nécessité absolue pour traiter les problèmes d'optimisation à grande échelle avec des millions de variables.

Géométries Complexes via Gmsh.jl : Ne soyez plus limité aux grilles rectangulaires. Grâce à l'intégration avec Gmsh.jl, le flux de travail complet est possible : créez des géométries complexes dans un logiciel de CAO, maillez-les avec Gmsh pour un contrôle précis de la qualité des éléments, et importez directement le fichier .msh dans vos simulations pour une représentation fidèle de vos designs les plus innovants.

Simulations Configurables via .toml : La reproductibilité est essentielle en recherche. En externalisant les paramètres des simulations (propriétés des matériaux, dimensions, fréquences) dans des fichiers de configuration .toml clairs et lisibles, vous pouvez facilement gérer des études paramétriques, partager vos expériences avec des collaborateurs et garantir que les résultats publiés dans vos articles sont parfaitement reproductibles.

Visualisation Découplée : Les fonctions de calcul retournent des objets Result structurés qui encapsulent les données et les métadonnées de la simulation. Les fonctions de traçage opèrent sur ces objets, et non sur les données brutes du solveur. Ce découplage garantit que si vous mettez à jour la logique d'un solveur, vos scripts de visualisation et de post-traitement continueront de fonctionner sans modification, rendant le code plus robuste et facile à maintenir.

📂 Structure du Projet
MetamaterialsWithJulia/
├─ Project.toml / Manifest.toml  # Fichiers d'environnement, gèrent les dépendances
├─ src/                          # Le code source du framework
│  ├─ abstractions.jl            # Types abstraits (Problème, Solveur, Résultat)
│  ├─ Physics/                   # Modules pour chaque domaine physique
│  ├─ Optimization/              # Algorithmes d'optimisation
│  └─ ...
├─ examples/                     # Scripts d'exemples prêts à l'emploi
│  ├─ configs/                   # Fichiers de configuration pour les exemples
│  └─ ...
├─ test/                         # Tests unitaires pour garantir la fiabilité du code
└─ README.md                     # Ce fichier

📦 Installation
Pour commencer, clonez le dépôt et instanciez l'environnement du projet. Cela installera toutes les dépendances requises listées dans le Project.toml et garantira que vous utilisez les bonnes versions des paquets.

Clonez le dépôt :

git clone [https://github.com/mounirjaouhari/MetamaterialsWithJulia.git](https://github.com/mounirjaouhari/MetamaterialsWithJulia.git)
cd MetamaterialsWithJulia

Installez les dépendances :
(Note : la première installation peut prendre plusieurs minutes car Julia doit télécharger, installer et précompiler tous les paquets.)

julia --project -e 'using Pkg; Pkg.instantiate()'

📖 Exemples d'Utilisation
Le dossier examples/ contient des scripts prêts à l'emploi pour illustrer les capacités du framework. Chaque script est conçu pour être une démonstration claire d'une fonctionnalité spécifique.

# Cet exemple montre comment simuler la transmission à travers
# un cristal photonique/phonique 1D et identifier les bandes interdites (band gaps).
# Résultat attendu : une image `transmission_from_config.png` est générée.
julia --project examples/1D_acoustic_periodic_from_config.jl

# Cet exemple calcule la relation de dispersion ω(k) pour une structure
# périodique, une analyse fondamentale pour les métamatériaux.
# Résultat attendu : une image `bands_1d.png` est générée.
julia --project examples/bands_1D_bloch.jl

# Cet exemple utilise un algorithme génétique pour trouver les paramètres
# géométriques optimaux d'une structure afin de maximiser un objectif donné.
# Résultat attendu : affichage des paramètres optimaux dans la console.
julia --project examples/optimize_geometry_GA.jl

🧪 Lancer les Tests
Pour vérifier que toutes les composantes du framework fonctionnent correctement après une modification ou une mise à jour, vous pouvez lancer la suite de tests automatisés. Cela garantit la non-régression et la stabilité du code.

julia --project -e "using Pkg; Pkg.test()"

📞 Contact
Pour toute question ou discussion relative à ce projet de recherche, n'hésitez pas à me contacter. Les collaborations et les suggestions sont les bienvenues.

Mounir JAOUHARI

Email : mounir.jaouhari-etu@etu.univh2c.ma
