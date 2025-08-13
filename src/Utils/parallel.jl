module Parallel

using Distributed

export with_threads, map_pmap, to_cuda_if_available

"""
    with_threads(f, collection)

Exécute une boucle `for` en parallèle en utilisant le multi-threading.

C'est un simple wrapper autour de la macro `Threads.@threads`. Il est utile
pour paralléliser des boucles "embarrassingly parallel" où chaque itération
est indépendante des autres.

# Important
Pour que cela fonctionne, Julia doit être lancé avec plusieurs threads.
Ex: `julia --threads=4`

# Arguments
- `f::Function`: La fonction à appliquer à chaque élément.
- `collection`: La collection sur laquelle itérer.
"""
function with_threads(f, collection)
    Threads.@threads for item in collection
        f(item)
    end
end

"""
    map_pmap(f, collection)

Applique une fonction `f` à chaque élément d'une collection en utilisant
le calcul distribué (`pmap`).

Cette fonction ajoute automatiquement des processus de travail (workers) s'il
n'y en a pas assez, jusqu'au nombre de cœurs de CPU disponibles.

# Important
Utile pour les tâches où chaque appel à `f` est coûteux en calcul.

# Arguments
- `f::Function`: La fonction à appliquer.
- `collection`: La collection de données à traiter.
"""
function map_pmap(f, collection)
    # Ajoute des workers si nécessaire, jusqu'au nombre de threads CPU.
    num_workers_to_add = Sys.CPU_THREADS - nprocs()
    if num_workers_to_add > 0
        addprocs(num_workers_to_add)
    end
    
    # pmap (parallel map) distribue les appels à f sur tous les workers disponibles.
    return pmap(f, collection)
end

"""
    to_cuda_if_available(A)

Déplace un tableau (Array) vers le GPU s'il est disponible.

Tente d'utiliser le package `CUDA.jl`. Si CUDA n'est pas fonctionnel,
le tableau est retourné sans modification.

# Arguments
- `A`: Un tableau (par exemple, `Array{Float32}`).

# Retour
- Un `CuArray` si un GPU est disponible, sinon le tableau d'origine.
"""
function to_cuda_if_available(A)
    # On utilise `Requires.jl` ou une vérification de module pour éviter
    # une dépendance forte à CUDA.jl. Ici, une approche simple :
    if @isdefined(CUDA) && CUDA.functional()
        return cu(A)
    else
        return A
    end
end

end
