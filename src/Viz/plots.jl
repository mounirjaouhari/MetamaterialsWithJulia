module PlotsWrapper

using Plots
using ..Abstractions
using ..Viz.Dispersion
using ..Physics.Maxwell

# On exporte les fonctions pour qu'elles soient accessibles depuis l'extérieur.
export plot_dispersion, plot_field

"""
    plot_dispersion(result::DispersionResult; kwargs...)

Trace le diagramme de dispersion à partir d'un objet `DispersionResult`.

Cette fonction est "type-safe" : elle n'accepte que des objets de type `DispersionResult`.
Elle convertit les fréquences angulaires (ω) en fréquences (Hz) pour l'affichage.

# Arguments
- `result::DispersionResult`: L'objet contenant les données de dispersion.
- `kwargs...`: Arguments supplémentaires passés directement à la fonction `plot` de Plots.jl
  (ex: `title="Mon Titre"`, `linewidth=2`).
"""
function plot_dispersion(result::DispersionResult; kwargs...)
    plot(result.k, result.ω ./ (2π),
         xlabel="Nombre d'onde k (rad/m)",
         ylabel="Fréquence (Hz)",
         title="Diagramme de Dispersion: $(get(result.metadata, "type", "Inconnu"))",
         legend=false; kwargs...)
end

"""
    plot_field(result::HelmholtzResult; kwargs...)

Trace la magnitude du champ calculé à partir d'un objet `HelmholtzResult`.

Utilise la recette de traçage fournie par Gridap.jl pour les solutions d'éléments finis.

# Arguments
- `result::HelmholtzResult`: L'objet contenant la solution du champ.
- `kwargs...`: Arguments supplémentaires passés à la fonction de traçage
  (ex: `colormap=:viridis`).
"""
function plot_field(result::HelmholtzResult; kwargs...)
    # Crée une triangulation à partir du modèle pour le traçage
    Ω = Triangulation(result.model)
    # Utilise la fonction de traçage intégrée de Gridap pour les FESolution
    # en calculant la magnitude (abs) du champ complexe.
    plot(Ω, abs.(result.uh);
         title="Magnitude du Champ |u|",
         colormap=:jet,
         aspect_ratio=:equal,
         kwargs...)
end

end
