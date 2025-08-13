module Abstractions

export AbstractProblem, AbstractSolver, AbstractResult, solve

"""
    AbstractProblem

Type abstrait pour la définition d'un problème physique (géométrie, matériaux, conditions limites).
"""
abstract type AbstractProblem end

"""
    AbstractSolver

Type abstrait pour un solveur numérique (ex: FEM, FDTD).
"""
abstract type AbstractSolver end

"""
    AbstractResult

Type abstrait pour contenir les résultats d'une simulation.
"""
abstract type AbstractResult end

"""
    solve(problem::AbstractProblem, solver::AbstractSolver)

Fonction générique pour lancer une simulation.
Chaque couple (Problem, Solver) doit avoir sa propre méthode pour surcharger cette fonction.
"""
function solve(problem::AbstractProblem, solver::AbstractSolver)
    error("La méthode `solve` n'est pas implémentée pour le couple ($(typeof(problem)), $(typeof(solver))).")
end

end
