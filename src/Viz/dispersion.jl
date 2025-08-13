module Dispersion

using LinearAlgebra
using ..Abstractions
using ..Physics.Acoustics

export DispersionResult, dispersion_1d_bloch

"""
    DispersionResult <: AbstractResult

Structure pour stocker les résultats d'un calcul de diagramme de dispersion.

# Champs
- `k::Vector{Float64}`: Vecteur des nombres d'onde (généralement dans la première zone de Brillouin).
- `ω::Vector{Float64}`: Vecteur des fréquences angulaires correspondantes.
- `metadata::Dict`: Un dictionnaire pour stocker des informations contextuelles
  (ex: type de simulation, physique, etc.).
"""
struct DispersionResult <: AbstractResult
    k::Vector{Float64}
    ω::Vector{Float64}
    metadata::Dict
end

"""
    dispersion_1d_bloch(params::Acoustic1DParams; ω_max=2π*5e3, n_ω=400)

Calcule la relation de dispersion ω(k) pour un réseau acoustique 1D en utilisant
la condition de Bloch-Floquet dérivée de la matrice de transfert.

Cette méthode est très efficace pour identifier les bandes passantes et les bandes interdites (band gaps).

# Arguments
- `params::Acoustic1DParams`: Les paramètres de la cellule unitaire.
- `ω_max::Float64`: La fréquence angulaire maximale à scanner.
- `n_ω::Int`: Le nombre de points de fréquence à calculer.

# Retour
- `DispersionResult`: Un objet contenant les vecteurs k et ω, ainsi que des métadonnées.
"""
function dispersion_1d_bloch(params::Acoustic1DParams; ω_max=2π*5e3, n_ω=400)
    ωs = range(1e-3, ω_max; length=n_ω)
    ks = similar(ωs)
    a = sum(params.d) # Longueur de la cellule unitaire

    for (i, ω) in enumerate(ωs)
        # Matrice de transfert pour UNE seule cellule unitaire
        _, M_cell = Acoustics.transfer_matrix(params, ω; nperiods=1)
        
        # La condition de Bloch s'écrit : cos(k*a) = 0.5 * tr(M_cell)
        # où M_cell est la matrice de transfert de la cellule.
        # Pour notre formulation de matrice, cela correspond à 0.5 * (m11 + m22).
        val = 0.5 * real(M_cell[1,1] + M_cell[2,2])
        
        # On s'assure que la valeur est dans [-1, 1] pour éviter les erreurs de domaine avec acos.
        # Les valeurs en dehors de cet intervalle correspondent aux bandes interdites (k est complexe).
        clamped_val = clamp(val, -1.0, 1.0)
        
        # On ne calcule que la partie réelle de k.
        ks[i] = acos(clamped_val) / a
    end
    
    metadata = Dict("type" => "1D Bloch", "medium" => "Acoustic")
    return DispersionResult(collect(ks), collect(ωs), metadata)
end

end
