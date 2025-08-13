module Topology

using Optim, LinearAlgebra

export optimize_topology

"""
    optimize_topology(J, ∇J, ρ₀; method=BFGS(), options=Optim.Options())

Optimise une topologie en utilisant un algorithme basé sur le gradient.

Cette fonction est conçue pour être flexible et performante. Elle sépare
clairement la fonction objectif de son gradient, permettant l'utilisation
de méthodes de calcul de gradient avancées.

# Arguments
- `J::Function`: La fonction objectif `J(ρ)` qui retourne un scalaire `Float64`.
                 C'est la valeur que l'on cherche à minimiser (ex: la compliance).
- `∇J::Function`: La fonction qui calcule le gradient, `∇J(ρ)`, et retourne un `Vector{Float64}`.
                  **Note de performance :** Pour des problèmes à grande échelle,
                  cette fonction DOIT être implémentée via une méthode adjointe
                  pour être efficace. Le coût de calcul du gradient complet
                  devrait être de l'ordre d'une seule évaluation de la fonction objectif.
- `ρ₀::AbstractVector`: Le vecteur de densité initial (valeurs typiquement entre 0 et 1).
- `method`: L'algorithme d'optimisation à utiliser, fourni par `Optim.jl` (ex: `BFGS()`, `ConjugateGradient()`).
- `options`: Options supplémentaires pour le solveur `Optim.jl` (ex: `Optim.Options(iterations=100)`).

# Retour
- `Tuple{AbstractVector, Optim.MultivariateOptimizationResults}`: Un tuple contenant le vecteur
  de densité optimisé et l'objet de résultats complet d'Optim.jl.
"""
function optimize_topology(J::Function, ∇J::Function, ρ₀::AbstractVector;
                           method=BFGS(), options=Optim.Options())

    # Fonction objectif telle que vue par Optim.jl.
    # On pourrait ajouter ici des filtres ou des pénalisations si nécessaire.
    function f(ρ)
        return J(ρ)
    end

    # Fonction de gradient "in-place" requise par Optim.jl.
    # Elle modifie le vecteur G directement.
    function g!(G, ρ)
        # L'efficacité de toute l'optimisation dépend de la performance de l'appel suivant.
        G[:] = ∇J(ρ)
    end

    # On définit des contraintes de boîte pour maintenir les densités entre 0 et 1.
    lower = zeros(size(ρ₀))
    upper = ones(size(ρ₀))

    # Appel au solveur d'Optim.jl avec contraintes de boîte.
    res = optimize(f, g!, lower, upper, ρ₀, Fminbox(method), options)
    
    return Optim.minimizer(res), res
end

end
