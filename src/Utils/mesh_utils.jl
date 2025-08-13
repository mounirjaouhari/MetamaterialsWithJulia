module MeshUtils

using Gridap
using GridapGmsh # Le package qui fait le pont entre Gridap et Gmsh

export load_msh_model

"""
    load_msh_model(filepath::String; reorder=true)

Charge un modèle de maillage à partir d'un fichier `.msh` généré par Gmsh
et le convertit en un `DiscreteModel` de Gridap, prêt à être utilisé
dans une simulation.

Cette fonction est la porte d'entrée pour utiliser des géométries complexes
définies dans des logiciels de CAO.

# Arguments
- `filepath::String`: Le chemin d'accès vers le fichier de maillage `.msh`.
- `reorder::Bool=true`: Si `true`, réordonne les nœuds pour optimiser les
  opérations matricielles, ce qui est généralement recommandé.

# Retour
- `Gridap.DiscreteModel`: Un modèle discret que les solveurs Gridap peuvent utiliser.

# Erreurs
- Lance une erreur si le fichier n'est pas trouvé.
"""
function load_msh_model(filepath::String; reorder=true)
    if !isfile(filepath)
        error("Fichier de maillage non trouvé : $filepath")
    end
    
    # GmshDiscreteModel est le constructeur fourni par GridapGmsh.jl
    # pour lire directement un fichier .msh.
    println("Chargement du maillage depuis : $filepath")
    model = GmshDiscreteModel(filepath; reorder=reorder)
    
    return model
end

end
