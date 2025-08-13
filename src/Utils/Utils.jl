module Utils

# On inclut tous les fichiers d'utilitaires définis dans ce répertoire.
include("config_utils.jl")
include("mesh_utils.jl")
include("io.jl")
include("parallel.jl")

# On exporte les modules eux-mêmes pour permettre un accès qualifié.
# Par exemple, un utilisateur pourra appeler `Utils.ConfigUtils.load_config(...)`.
export ConfigUtils, MeshUtils, IO, Parallel

end
