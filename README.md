<div align="center">

<img src="images/MetamaterialsWithJulia.png" alt="MetamaterialsWithJulia Logo" width="300"/>

# MetamaterialsWithJulia

</div>

MetamaterialsWithJulia est un framework **Julia** modulaire et performant pour la simulation, l'analyse et l'optimisation de **métamatériaux acoustiques, électromagnétiques et mécaniques**.  
L'objectif est de fournir aux chercheurs un outil flexible pour prototyper rapidement des modèles et des algorithmes d'optimisation, en tirant parti de la vitesse de Julia et de son écosystème scientifique.  
Ce projet vise à **combler le fossé entre les concepts théoriques et la conception pratique** de dispositifs aux propriétés extraordinaires.

---

## ⚠️ Avertissement : Projet de Recherche

Ce dépôt est développé activement dans le cadre de travaux de thèse.  
Il s'agit d'un **prototype de recherche** et non d'un logiciel finalisé.  
Le code et les API sont susceptibles d'évoluer de manière significative.  

> L'utilisation en production **n'est pas recommandée** à ce stade.  
> Les contributions et rapports de bogues sont les bienvenus via les *Issues* GitHub, mais la priorité reste l'exploration scientifique.

---

## 🚀 Fonctionnalités Clés

- **Architecture Abstraite**  
  API Problème / Solveur / Résultat pour définir un problème physique (ex : équation de Helmholtz) indépendamment de la méthode numérique utilisée.  
  Possibilité de brancher différents solveurs (FDTD, BEM, etc.) sans modifier la définition de la physique.

- **Solveur FEM via Gridap.jl**  
  Implémentation actuelle basée sur Gridap.jl, puissant package d'éléments finis, ouvrant la voie aux simulations multiphysiques ou non-linéaires.

- **Optimisation Avancée**  
  Modules pour optimisation topologique et géométrique, avec API séparant fonction objectif et gradient, facilitant les méthodes adjointes performantes.

- **Géométries Complexes via Gmsh.jl**  
  Création et import direct de géométries complexes maillées avec Gmsh pour un contrôle précis.

- **Simulations Configurables via `.toml`**  
  Paramètres externes pour reproductibilité, gestion d'études paramétriques et partage facile.

- **Visualisation Découplée**  
  Fonctions de post-traitement opérant sur objets `Result` indépendamment des solveurs, assurant robustesse et maintenance.

---

## 📂 Structure du Projet

```plaintext
MetamaterialsWithJulia/
├─ Project.toml / Manifest.toml  # Gestion des dépendances Julia
├─ src/                          # Code source du framework
│  ├─ abstractions.jl            # Types abstraits
│  ├─ Physics/                   # Modules par domaine physique
│  ├─ Optimization/              # Algorithmes d'optimisation
│  └─ ...
├─ examples/                     # Scripts d'exemples
│  ├─ configs/                   # Fichiers de configuration
│  └─ ...
├─ test/                         # Tests unitaires
└─ README.md                     # Ce fichier
````

---

## 📦 Installation

Clonez le dépôt :

```bash
git clone https://github.com/mounirjaouhari/MetamaterialsWithJulia.git
cd MetamaterialsWithJulia
```

Installez les dépendances :

```bash
julia --project -e 'using Pkg; Pkg.instantiate()'
```

> 💡 La première installation peut prendre plusieurs minutes (téléchargement et précompilation des paquets).

---

## 📖 Exemples d'Utilisation

### 1. Transmission à travers un cristal photonique/phonique 1D

```bash
julia --project examples/1D_acoustic_periodic_from_config.jl
```

Résultat : `transmission_from_config.png`

### 2. Relation de dispersion ω(k) pour structure périodique

```bash
julia --project examples/bands_1D_bloch.jl
```

Résultat : `bands_1d.png`

### 3. Optimisation géométrique avec algorithme génétique

```bash
julia --project examples/optimize_geometry_GA.jl
```

Résultat : paramètres optimaux affichés dans la console.

---

## 🧪 Lancer les Tests

```bash
julia --project -e "using Pkg; Pkg.test()"
```

---

## 📞 Contact

**Mounir JAOUHARI**
📧 Email : [mounir.jaouhari-etu@etu.univh2c.ma](mailto:mounir.jaouhari-etu@etu.univh2c.ma)
