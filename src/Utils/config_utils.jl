module ConfigUtils

using TOML

export load_config

"""
    load_config(filepath::String)

Charge un fichier de configuration au format TOML et le retourne sous forme
d'un dictionnaire Julia.

Cette fonction simple est la base pour des simulations pilotées par configuration.

# Arguments
- `filepath::String`: Le chemin d'accès vers le fichier `.toml`.

# Retour
- `Dict`: Un dictionnaire contenant les paramètres parsés du fichier.

# Erreurs
- Lance une erreur si le fichier n'est pas trouvé à l'emplacement spécifié.
"""
function load_config(filepath::String)
    if !isfile(filepath)
        error("Fichier de configuration non trouvé : $filepath")
    end
    
    # TOML.parsefile est la fonction principale du package TOML.jl
    return TOML.parsefile(filepath)
end

end
