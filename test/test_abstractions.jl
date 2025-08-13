using MetamaterialsWithJulia
using Test

# On importe les modules que l'on souhaite tester.
using MetamaterialsWithJulia.Abstractions
using MetamaterialsWithJulia.Utils.ConfigUtils

@testset "Core Abstractions and Utilities" begin

    # --- Test 1: Vérifier l'existence des types abstraits ---
    # Ce test simple s'assure que nos types de base sont bien définis et abstraits.
    @testset "Abstract Types" begin
        @test isabstract(AbstractProblem)
        @test isabstract(AbstractSolver)
        @test isabstract(AbstractResult)
    end

    # --- Test 2: Vérifier le chargement de la configuration ---
    # Ce test vérifie que notre utilitaire de configuration fonctionne comme prévu.
    @testset "Config Loading Utility" begin
        # On construit le chemin vers un fichier de configuration d'exemple.
        # Il est important que ce fichier existe pour que le test passe.
        config_path = joinpath(@__DIR__, "..", "examples", "configs", "acoustic_periodic_1d.toml")
        
        # On vérifie que le fichier de configuration existe bien.
        @test isfile(config_path)
        
        # On charge le fichier et on vérifie que les valeurs sont correctes.
        config = load_config(config_path)
        @test config isa Dict
        @test config["n_periods"] == 8
        @test length(config["layers"]) == 2
        @test config["layers"][1]["density"] == 1.2
    end
    
    # --- Test 3: Vérifier le comportement d'erreur de `solve` ---
    # On teste que la fonction `solve` générique lance bien une erreur
    # si aucune méthode spécifique n'a été définie.
    @testset "Generic Solve Error" begin
        # On définit des types concrets vides juste pour le test.
        struct DummyProblem <: AbstractProblem end
        struct DummySolver <: AbstractSolver end
        
        # On vérifie que l'appel à solve avec ces types lève une exception.
        @test_throws ErrorException solve(DummyProblem(), DummySolver())
    end

end
