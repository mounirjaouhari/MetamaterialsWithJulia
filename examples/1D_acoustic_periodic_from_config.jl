using MetamaterialsWithJulia
using Plots

# On utilise le module `Utils.ConfigUtils` pour charger la configuration.
using MetamaterialsWithJulia.Utils.ConfigUtils
# On utilise le module `Physics.Acoustics` pour la simulation.
using MetamaterialsWithJulia.Physics.Acoustics

println("Lancement de l'exemple : Simulation 1D depuis un fichier de configuration.")

# --- 1. Charger la configuration ---
# On construit le chemin vers le fichier de configuration.
config_path = joinpath(@__DIR__, "configs", "acoustic_periodic_1d.toml")
config = load_config(config_path)
println("Configuration chargée : \"$(config["title"])\"")

# --- 2. Extraire les paramètres de la simulation ---
# On récupère les paramètres depuis le dictionnaire `config`.
layers_data = config["layers"]
ρ = [l["density"] for l in layers_data]
c = [l["celerity"] for l in layers_data]
d = [l["thickness"] for l in layers_data]

n_periods = config["n_periods"]
f_min, f_max = config["frequency_range"]
n_points = config["n_points"]

# --- 3. Préparer et lancer la simulation ---
# On crée la structure de paramètres pour la simulation.
params = Acoustic1DParams(ρ, c, d)

# On crée la plage de fréquences angulaires à scanner.
ωs = range(2π * f_min, 2π * f_max; length=n_points)
T_values = similar(ωs) # On pré-alloue le vecteur pour les résultats.

# Boucle principale de la simulation.
# Pourrait être parallélisée avec `Threads.@threads` si Julia est lancé avec plusieurs threads.
for (i, ω) in enumerate(ωs)
    T, _ = transfer_matrix(params, ω; nperiods=n_periods)
    T_values[i] = T
end

println("Simulation terminée.")

# --- 4. Visualiser les résultats ---
# On utilise le backend de Plots.jl pour créer le graphique.
plot(ωs ./ (2π), T_values,
     xlabel="Fréquence (Hz)",
     ylabel="Transmission",
     title=config["title"],
     legend=false,
     linewidth=2)

# On sauvegarde la figure dans le répertoire principal du projet.
output_path = "transmission_from_config.png"
savefig(output_path)

println("Figure sauvegardée dans : $output_path")
