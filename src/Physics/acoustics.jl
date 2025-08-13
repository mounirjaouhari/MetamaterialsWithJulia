module Acoustics

using LinearAlgebra

export Acoustic1DParams, transfer_matrix

"""
    Acoustic1DParams

Structure pour contenir les paramètres d'un empilement de couches acoustiques 1D.

# Champs
- `ρ::Vector{Float64}`: Vecteur des densités pour chaque couche (kg/m³).
- `c::Vector{Float64}`: Vecteur des célérités du son pour chaque couche (m/s).
- `d::Vector{Float64}`: Vecteur des épaisseurs pour chaque couche (m).
"""
struct Acoustic1DParams
    ρ::Vector{Float64}
    c::Vector{Float64}
    d::Vector{Float64}
end

"""
    transfer_matrix(params::Acoustic1DParams, ω::Float64; nperiods::Int=1)

Calcule les coefficients de transmission (T) et de réflexion (R) en puissance
pour un empilement de couches périodique.

La méthode est basée sur l'approche de la matrice de transfert.

# Arguments
- `params::Acoustic1DParams`: Les paramètres de la cellule unitaire.
- `ω::Float64`: La fréquence angulaire (rad/s).
- `nperiods::Int=1`: Le nombre de répétitions de la cellule unitaire.

# Retours
- `Tuple{Float64, Float64}`: Un tuple contenant les coefficients (T, R).
"""
function transfer_matrix(params::Acoustic1DParams, ω::Float64; nperiods::Int=1)
    # Calcul des nombres d'onde et des impédances acoustiques
    k = ω ./ params.c
    Z = params.ρ .* params.c
    
    # Initialisation de la matrice de transfert globale à l'identité
    M_total = Matrix{ComplexF64}(I, 2, 2)
    
    # Construction de la matrice de transfert pour une cellule unitaire
    M_cell = Matrix{ComplexF64}(I, 2, 2)
    for (ki, Zi, di) in zip(k, Z, params.d)
        φ = ki * di
        # Matrice de transfert pour une seule couche
        P_layer = [cos(φ)      1im * Zi * sin(φ);
                   1im / Zi * sin(φ)   cos(φ)]
        M_cell = P_layer * M_cell
    end

    # Si plusieurs périodes, on élève la matrice de la cellule à la puissance nperiods
    if nperiods > 1
        M_total = M_cell^nperiods
    else
        M_total = M_cell
    end
    
    # On suppose que le milieu d'entrée et de sortie est identique à la première couche
    Z_in = Z[1]
    
    # Calcul des coefficients de réflexion et de transmission en amplitude
    # à partir des éléments de la matrice de transfert totale
    m11, m12, m21, m22 = M_total[1,1], M_total[1,2], M_total[2,1], M_total[2,2]
    
    r_amp = (m11 * Z_in + m12 - m21 * Z_in^2 - m22 * Z_in) / 
            (m11 * Z_in + m12 + m21 * Z_in^2 + m22 * Z_in)
            
    t_amp = 2 * Z_in / (m11 * Z_in + m12 + m21 * Z_in^2 + m22 * Z_in)
              
    # Conversion en puissance (sans pertes, T + R = 1)
    T = abs2(t_amp)
    R = abs2(r_amp)
    
    return T, R
end

end
