using Documenter
using MetamaterialsWithJulia

# Ce bloc est le point d'entrée pour la génération de la documentation.
# Il est exécuté lorsque vous lancez `julia --project=docs/ docs/make.jl`

println("Génération de la documentation...")

makedocs(
    # --- Configuration Générale ---
    sitename = "MetamaterialsWithJulia.jl",
    authors = "Votre Nom et contributeurs",
    
    # --- Contenu des Pages ---
    # On spécifie ici la structure de la documentation.
    # Chaque entrée correspond à une page dans la barre de navigation.
    pages = [
        "Accueil" => "index.md",
        "Guide de Démarrage" => "quickstart.md",
        "Concepts de Base" => [
            "Architecture" => "concepts/architecture.md",
            "Physique" => "concepts/physics.md",
            "Optimisation" => "concepts/optimization.md"
        ],
        "Référence de l'API" => "api.md"
    ],
    
    # --- Modules à Documenter ---
    # Documenter.jl va scanner ces modules pour trouver les docstrings.
    modules = [MetamaterialsWithJulia],
    
    # --- Format de Sortie ---
    # On configure la sortie en HTML.
    format = Documenter.HTML(
        # Active les "jolies URLs" (sans le .html) si la documentation est hébergée.
        prettyurls=get(ENV, "CI", "false") == "true",
        # Lien canonique pour le SEO.
        canonical="https://YourUser.github.io/MetamaterialsWithJulia.jl/stable/",
        # Fichiers CSS ou JS personnalisés (si nécessaire).
        assets=String[],
    ),
    
    # Stricte : échoue si une docstring est manquante ou si une référence est cassée.
    # Idéal pour la CI. Mettre à `false` pendant le développement.
    strict = false,
)

# --- Déploiement Automatique ---
# Cette partie gère le déploiement automatique de la documentation
# sur GitHub Pages lors d'un push sur la branche `main`.
deploydocs(
    repo = "github.com/YourUser/MetamaterialsWithJulia.jl.git",
    devbranch = "main",
)

println("Documentation générée avec succès.")
