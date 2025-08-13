using MetamaterialsWithJulia

# On importe les modules nécessaires
using MetamaterialsWithJulia.Physics.Acoustics
using MetamaterialsWithJulia.Optimization.GeometryGA

println("Lancement de l'exemple : Optimisation de géométrie par Algorithme Génétique.")

# --- 1. Définir la fonction de simulation (la "boîte noire") ---
# Cette fonction prend un vecteur de paramètres géométriques `θ` et retourne
# un score à maximiser. Ici, on veut maximiser la transmission à une fréquence cible.

function transmission_at_2khz(θ)
    # θ[1] et θ[2] sont les paramètres que l'on optimise (ici, des épaisseurs).
    # On les mappe à des valeurs physiques.
    d = [0.005 + 0.01*θ[1], 0.005 + 0.01*θ[2]]
    
    # Paramètres physiques fixes
    ρ = [1.2, 1800.0]
    c = [340.0, 2600.0]
    
    # Création des paramètres et simulation
    params = Acoustic1DParams(ρ, c, d)
    target_frequency = 2000.0 # Hz
    T, _ = transfer_matrix(params, 2π * target_frequency; nperiods=10)
    
    # On retourne le score à maximiser
    return T
end

# --- 2. Définir l'espace de recherche ---
# On définit les bornes pour chaque paramètre dans θ.
# Ici, θ[1] et θ[2] peuvent varier entre 0.1 et 0.9.
search_range = [(0.1, 0.9), (0.1, 0.9)]

println("Lancement de l'optimisation... (cela peut prendre un moment)")

# --- 3. Lancer l'optimisation ---
# On appelle notre fonction d'optimisation "boîte noire".
best_params, best_score, result = optimize_geometry_bbo(
    transmission_at_2khz;
    search_range=search_range,
    max_iters=2500 # Un nombre plus élevé d'itérations donne de meilleurs résultats
)

println("\nOptimisation terminée !")
println("--------------------------")
println("Meilleurs paramètres trouvés (θ) : ", round.(best_params, digits=3))
println("Score de transmission maximal à 2kHz : ", round(best_score, digits=4))
