module IO

using JLD2

export save_result, load_result

"""
    save_result(filepath::String; kwargs...)

Sauvegarde les données d'une simulation dans un fichier `.jld2`.

Cette fonction utilise une syntaxe à base de mots-clés pour permettre de
sauvegarder plusieurs variables dans le même fichier, chacune avec un nom.

# Arguments
- `filepath::String`: Le chemin complet du fichier de sauvegarde (ex: "results/sim1.jld2").
- `kwargs...`: Les variables à sauvegarder, sous forme de paires `nom=variable`.
  Ex: `save_result("data.jld2", field=result_field, params=sim_params)`

# Exemple
```julia
res = ... # Un objet de résultat
params = ... # Les paramètres
save_result("my_simulation.jld2", result=res, parameters=params)
```
"""
function save_result(filepath::String; kwargs...)
    # S'assure que le répertoire de destination existe.
    dir = dirname(filepath)
    if !isdir(dir)
        mkpath(dir)
        println("Répertoire créé : $dir")
    end
    
    # La macro @save de JLD2.jl sauvegarde les variables passées en mots-clés.
    @save filepath kwargs...
    
    println("Résultat sauvegardé dans : $filepath")
end

"""
    load_result(filepath::String)

Charge les données depuis un fichier `.jld2`.

La fonction retourne un dictionnaire où les clés sont les noms des variables
sauvegardées et les valeurs sont les variables elles-mêmes.

# Arguments
- `filepath::String`: Le chemin d'accès vers le fichier `.jld2`.

# Retour
- `Dict{String, Any}`: Un dictionnaire contenant les données chargées.

# Erreurs
- Lance une erreur si le fichier n'est pas trouvé.
"""
function load_result(filepath::String)
    if !isfile(filepath)
        error("Fichier de résultats non trouvé : $filepath")
    end
    
    # La macro @load charge toutes les variables du fichier dans le scope local.
    # Pour les retourner de manière structurée, on les charge dans un dictionnaire.
    return load(filepath)
end

end
