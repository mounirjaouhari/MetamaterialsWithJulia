module GeometryGA

using BlackBoxOptim

export optimize_geometry_bbo

"""
    optimize_geometry_bbo(sim_fun; search_range, max_iters=2000, method=:adaptive_de_rand_1_bin_radiuslimited)

Optimise un vecteur de paramètres géométriques en utilisant une méthode d'optimisation
"boîte noire" (sans gradient) fournie par `BlackBoxOptim.jl`.

Cette approche est idéale pour les problèmes où la fonction objectif est bruitée,
non différentiable, ou lorsque le calcul du gradient est trop complexe.

# Arguments
- `sim_fun::Function`: La fonction de simulation `sim_fun(θ)` qui prend un vecteur de
  paramètres `θ` et retourne un score (une valeur `Float64`) à maximiser.
- `search_range`: Une plage de recherche pour les paramètres, fournie sous la forme
  d'un tableau de tuples. Ex: `[(0.1, 1.0), (0.2, 0.8)]` pour deux paramètres.
- `max_iters::Int`: Le nombre maximum d'évaluations de la fonction de simulation.
- `method`: L'algorithme spécifique à utiliser de `BlackBoxOptim.jl`.

# Retour
- `Tuple`: Un tuple contenant `(best_params, best_score, result_object)`.
"""
function optimize_geometry_bbo(sim_fun::Function;
                               search_range,
                               max_iters::Int=2000,
                               method=:adaptive_de_rand_1_bin_radiuslimited)
    
    # BlackBoxOptim minimise par défaut, donc on inverse le score de notre fonction.
    objective_function(θ) = -sim_fun(θ)
    
    # Lancement de l'optimisation
    res = bboptimize(objective_function;
                     SearchRange=search_range,
                     NumDimensions=length(search_range),
                     MaxFuncEvals=max_iters,
                     Method=method,
                     TraceMode=:silent) # :silent pour ne pas afficher les logs
                     
    best_params = best_candidate(res)
    best_score = -best_fitness(res) # On ré-inverse pour obtenir le score max
    
    return best_params, best_score, res
end

end
