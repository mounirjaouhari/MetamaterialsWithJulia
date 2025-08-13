module Maxwell

using Gridap
using ..Abstractions

export HelmholtzProblem, GridapFEMSolver, HelmholtzResult

"""
    HelmholtzProblem <: AbstractProblem

Définit un problème de Helmholtz 2D scalaire.

Cette structure contient toutes les informations physiques nécessaires pour décrire
le problème, indépendamment de la méthode de résolution.

# Champs
- `mesh::Gridap.DiscreteModel`: Le maillage du domaine (peut être importé via Gmsh).
- `εr::Function`: La permittivité relative en fonction de la position `εr(x)`.
- `μr::Function`: La perméabilité relative en fonction de la position `μr(x)`.
- `k0::Float64`: Le nombre d'onde dans le vide, `ω/c0`.
- `source::Function`: Le terme source du problème, `f(x)`.
- `boundary_tags::Vector{String}`: Les noms des frontières où appliquer les conditions de Dirichlet.
"""
struct HelmholtzProblem <: AbstractProblem
    mesh::Gridap.DiscreteModel
    εr::Function
    μr::Function
    k0::Float64
    source::Function
    boundary_tags::Vector{String}
end

"""
    GridapFEMSolver <: AbstractSolver

Un solveur pour les problèmes de type Helmholtz basé sur la méthode des éléments finis (FEM)
en utilisant la bibliothèque Gridap.jl.

# Champs
- `degree::Int`: L'ordre (degré polynomial) des éléments finis à utiliser.
"""
struct GridapFEMSolver <: AbstractSolver
    degree::Int
end

"""
    HelmholtzResult <: AbstractResult

Structure pour stocker les résultats d'une simulation de Helmholtz.

# Champs
- `uh::Gridap.FESolution`: La solution du champ calculée.
- `model::Gridap.DiscreteModel`: Le modèle de maillage utilisé pour la simulation.
- `problem::HelmholtzProblem`: Une référence au problème qui a été résolu.
"""
struct HelmholtzResult <: AbstractResult
    uh::Gridap.FESolution
    model::Gridap.DiscreteModel
    problem::HelmholtzProblem
end

"""
    solve(problem::HelmholtzProblem, solver::GridapFEMSolver)

Implémentation de la méthode `solve` pour le couple (`HelmholtzProblem`, `GridapFEMSolver`).
"""
function Abstractions.solve(problem::HelmholtzProblem, solver::GridapFEMSolver)
    # Définition de l'espace d'éléments finis
    reffe = ReferenceFE(lagrangian, Float64, solver.degree)
    # Espace test avec conditions de Dirichlet homogènes sur les frontières spécifiées
    V0 = TestFESpace(problem.mesh, reffe; conformity=:H1, dirichlet_tags=problem.boundary_tags)
    U = TrialFESpace(V0, 0.0) # Espace d'essai

    # Définition des mesures d'intégration
    Ω = Triangulation(problem.mesh)
    dΩ = Measure(Ω, 2 * solver.degree) # Quadrature d'ordre suffisant

    # Raccourcis pour les paramètres du problème
    k0 = problem.k0
    εr_func = problem.εr
    μr_func = problem.μr
    source_func = problem.source

    # Formulation faible (variationnelle) de l'équation de Helmholtz
    # ∫( (1/μr)∇v⋅∇u - k₀²εr*v*u )dΩ = ∫( v*f )dΩ
    a(u, v) = ∫( (1/μr_func(get_physical_coordinate(Ω))) * (∇(v) ⋅ ∇(u)) - k0^2 * εr_func(get_physical_coordinate(Ω)) * v * u )dΩ
    l(v) = ∫( v * source_func(get_physical_coordinate(Ω)) )dΩ

    # Assemblage et résolution du système linéaire
    op = AffineFEOperator(a, l, U, V0)
    uh = Gridap.solve(op)

    return HelmholtzResult(uh, problem.mesh, problem)
end

end
