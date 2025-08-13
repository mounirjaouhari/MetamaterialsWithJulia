using MetamaterialsWithJulia
using Plots

# On importe les modules spécifiques nécessaires pour cet exemple.
using MetamaterialsWithJulia.Physics.Maxwell
using MetamaterialsWithJulia.Utils.MeshUtils
using MetamaterialsWithJulia.Viz.PlotsWrapper

println("Lancement de l'exemple : Simulation Helmholtz 2D depuis un fichier .msh.")

# --- Ce script nécessite un fichier `model.msh` dans ce répertoire ---
# Vous pouvez en créer un simple avec Gmsh, par exemple un carré [0,1]x[0,1]
# avec un trou circulaire au centre. Assurez-vous de nommer les frontières
# physiques (par exemple, "boundary") pour les conditions aux limites.
# --------------------------------------------------------------------

msh_file = joinpath(@__DIR__, "model.msh")
if !isfile(msh_file)
    error("""
    Le fichier 'model.msh' est introuvable dans le répertoire 'examples/'.
    Veuillez en créer un avec Gmsh pour exécuter cet exemple.
    """)
end

# --- 1. Charger le maillage ---
# On utilise notre utilitaire pour charger le modèle.
mesh = MeshUtils.load_msh_model(msh_file)

# --- 2. Définir le problème physique ---
k0 = 20.0 # Nombre d'onde

# Définition des propriétés des matériaux en fonction de la position.
# Ici, une inclusion circulaire avec une permittivité plus élevée.
εr(x) = 1.0 + 3.0 * ( (x[1]-0.5)^2 + (x[2]-0.5)^2 < 0.2^2 )
μr(x) = 1.0

# Définition d'une source ponctuelle (approximée par une Gaussienne).
source(x) = exp(-100 * ((x[1]-0.2)^2 + (x[2]-0.5)^2))

# On crée l'objet `HelmholtzProblem`.
# Note: "boundary" doit correspondre au nom de la frontière physique dans le fichier .msh.
problem = HelmholtzProblem(mesh, εr, μr, k0, source, ["boundary"])

# --- 3. Définir le solveur ---
# On choisit un solveur FEM avec des éléments d'ordre 2.
solver = GridapFEMSolver(2)

# --- 4. Résoudre le problème ---
println("Résolution du problème d'Helmholtz sur le maillage importé...")
# L'appel à `solve` est générique grâce à notre abstraction.
result = solve(problem, solver)
println("Résolution terminée.")

# --- 5. Visualiser le résultat ---
# On utilise notre fonction de traçage qui opère sur l'objet `HelmholtzResult`.
p = plot_field(result)

output_path = "helmholtz_from_msh.png"
savefig(output_path)
println("Figure sauvegardée dans : $output_path")
