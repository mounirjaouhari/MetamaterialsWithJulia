module Viz

# On importe les abstractions car les sous-modules en dépendent
# pour opérer sur les objets `Result`.
using ..Abstractions

# On inclut les fichiers contenant la logique de visualisation et de post-traitement.
include("plots.jl")
include("dispersion.jl")

# On exporte les modules pour permettre un accès qualifié.
# Ex: Viz.PlotsWrapper.plot_dispersion(...) ou Viz.Dispersion.dispersion_1d_bloch(...)
export PlotsWrapper, Dispersion

end
