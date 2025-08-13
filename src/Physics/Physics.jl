module Physics

# On importe les abstractions car les sous-modules de physique en dépendent.
using ..Abstractions

# On inclut les fichiers contenant les implémentations spécifiques à chaque domaine physique.
include("acoustics.jl")
include("maxwell.jl")
include("pml.jl") # Perfect Matched Layers (Conditions aux limites absorbantes)

# On exporte les modules eux-mêmes pour que l'utilisateur puisse y accéder
# de manière qualifiée, par exemple : Physics.Acoustics ou Physics.Maxwell.
export Acoustics, Maxwell, PML

end
