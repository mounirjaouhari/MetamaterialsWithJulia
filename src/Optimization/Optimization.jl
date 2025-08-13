module Optimization

# On inclut les fichiers contenant les différentes stratégies d'optimisation.
include("topology.jl")      # Optimisation topologique (basée sur la densité)
include("geometryGA.jl")    # Optimisation géométrique (par algorithme génétique)

# On exporte les modules pour permettre un accès qualifié,
# par exemple : Optimization.Topology.optimize_topology(...)
export Topology, GeometryGA

end
