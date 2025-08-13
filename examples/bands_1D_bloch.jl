using MetamaterialsWithJulia
using Plots

# On importe les modules spécifiques nécessaires.
using MetamaterialsWithJulia.Physics.Acoustics
using MetamaterialsWithJulia.Viz.Dispersion
using MetamaterialsWithJulia.Viz.PlotsWrapper

println("Lancement de l'exemple : Calcul du diagramme de bandes 1D.")

# --- 1. Définir les paramètres physiques de la cellule unitaire ---
# On définit un contraste élevé entre les deux matériaux pour bien voir les bandes interdites.
ρ = [1.2, 1800.0]    # Densités (Air, Epoxy)
c = [340.0, 2600.0]  # Célérités (Air, Epoxy)
d = [0.01, 0.005]    # Épaisseurs
params = Acoustic1DParams(ρ, c, d)

# --- 2. Calculer la relation de dispersion ---
# La fonction retourne directement un objet `DispersionResult`.
# Cet objet contient toutes les données nécessaires pour le post-traitement.
disp_result = dispersion_1d_bloch(params, ω_max = 2π * 15000)
println("Calcul de la dispersion terminé.")

# --- 3. Visualiser le résultat ---
# La fonction de traçage opère directement sur l'objet `DispersionResult`.
# Elle est complètement découplée de la manière dont les données ont été calculées.
p = plot_dispersion(disp_result, title="Diagramme de Bandes (1D Acoustique)")

output_path = "bands_1d.png"
savefig(output_path)
println("Figure sauvegardée dans : $output_path")
