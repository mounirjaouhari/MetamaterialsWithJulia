module MetamaterialsWithJulia

# 1. Core Abstractions
# On inclut et exporte les types abstraits pour qu'ils soient
# disponibles dans tout le framework.
include("abstractions.jl")
using .Abstractions
export AbstractProblem, AbstractSolver, AbstractResult, solve

# 2. Main Modules
# On inclut les sous-modules qui contiennent la logique spécifique.
include("Physics/Physics.jl")
include("Optimization/Optimization.jl")
include("Viz/Viz.jl")
include("Utils/Utils.jl")

# 3. Export Public API
# On exporte les modules eux-mêmes pour permettre un accès
# qualifié à l'utilisateur, par exemple : Physics.Acoustics.transfer_matrix(...)
export Physics, Optimization, Viz, Utils

end
