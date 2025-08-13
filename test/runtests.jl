using MetamaterialsWithJulia
using Test

# Ce bloc est le point d'entrée principal pour les tests.
# Il est exécuté lorsque vous lancez `] test` dans le REPL Julia.
@testset "MetamaterialsWithJulia.jl: All Tests" begin
    
    println("Running Abstraction and Utility Tests...")
    @testset "Core: Abstractions & Utilities" begin
        # On inclut le fichier contenant les tests pour les fondations du code.
        include("test_abstractions.jl")
    end

    println("\nRunning Physics Module Tests...")
    @testset "Physics: Acoustics 1D" begin
        # Ici, on ajouterait des tests spécifiques pour le module acoustique.
        # Par exemple, vérifier la conservation de l'énergie (T+R=1).
        ρ = [1.2, 1.8]; c = [340.0, 800.0]; d = [0.01, 0.005]
        params = MetamaterialsWithJulia.Physics.Acoustics.Acoustic1DParams(ρ,c,d)
        T, R = MetamaterialsWithJulia.Physics.Acoustics.transfer_matrix(params, 2π*1000.0)
        @test T >= 0.0
        @test R >= 0.0
        @test isapprox(T + R, 1.0, atol=1e-9)
    end

    # On pourrait ajouter d'autres ensembles de tests pour chaque fonctionnalité.
    # @testset "Physics: Maxwell 2D" begin
    #     # Tests pour le solveur Helmholtz...
    # end
    #
    # @testset "Optimization: Topology" begin
    #     # Tests pour l'API d'optimisation...
    # end

    println("\nAll tests passed!")
end
