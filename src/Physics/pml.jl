module PML

export make_pml_stretch

"""
    make_pml_stretch(;Lx, Ly, pml_thick, σ_max, ω)

Crée une fonction de "stretching" complexe pour une PML 2D.

Cette fonction est utilisée pour modifier l'équation de Helmholtz afin de créer
une région absorbante près des frontières du domaine. Elle retourne une fonction
`s(x)` qui renvoie un tuple `(sx, sy)`.

# Arguments Clés
- `Lx::Float64`, `Ly::Float64`: Dimensions du domaine de simulation.
- `pml_thick::Float64`: Épaisseur de la couche PML sur chaque bord.
- `σ_max::Float64`: Conductivité artificielle maximale au bord de la PML. C'est le paramètre principal qui contrôle l'efficacité de l'absorption.
- `ω::Float64`: Fréquence angulaire pour laquelle la PML est optimisée.

# Retour
- `Function`: Une fonction `s(x::Point)` qui retourne `(sx, sy)`, où `sx = 1 + i*σx(x)/ω`.
"""
function make_pml_stretch(; Lx::Float64, Ly::Float64, pml_thick::Float64, σ_max::Float64, ω::Float64)
    
    # Fonction interne pour calculer la conductivité σ pour une seule coordonnée.
    # Le profil est quadratique, ce qui est un choix courant pour une absorption progressive.
    function σ_coord(coord::Float64, L_domain::Float64)
        # Distance au bord le plus proche
        d = min(coord, L_domain - coord)
        
        # Si on est dans la couche PML, on calcule σ, sinon c'est 0.
        if d < pml_thick
            # Profil de conductivité quadratique qui augmente en s'approchant du bord.
            return σ_max * (1 - d / pml_thick)^2
        else
            return 0.0
        end
    end

    # La fonction de stretching finale qui sera utilisée par le solveur.
    # Elle prend un Point (de Gridap) et retourne les deux facteurs de stretching.
    return function pml_function(x)
        # x est un Point, on accède à ses coordonnées par x[1], x[2]
        σx = σ_coord(x[1], Lx)
        σy = σ_coord(x[2], Ly)
        
        sx = 1.0 + 1im * σx / ω
        sy = 1.0 + 1im * σy / ω
        
        return (sx, sy)
    end
end

end
