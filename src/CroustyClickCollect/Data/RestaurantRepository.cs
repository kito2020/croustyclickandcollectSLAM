using CroustyClickCollect.Models;
using Dapper;

namespace CroustyClickCollect.Data;

/// <summary>
/// Toutes les requêtes SQL qui concernent les restaurants.
/// </summary>
public class RestaurantRepository
{
    private readonly BaseDeDonnees _bdd;

    public RestaurantRepository(BaseDeDonnees bdd)
    {
        _bdd = bdd;
    }

    public List<Restaurant> GetTous()
    {
        // TODO S2-01 (sprint 2) : lire tous les restaurants, triés par nom.
        //   Consigne : renvoyer la liste des restaurants avec toutes leurs informations.
        //   Indice   : même principe que ProduitRepository.GetSauces().
        using var connexion = _bdd.CreerConnexion();
        string sql = "SELECT * FROM restaurant ORDER BY nom";
        return connexion.Query<Restaurant>(sql).ToList();
    }

    // EXEMPLE COMPLET : lire UN restaurant à partir de son identifiant.
    public Restaurant GetParId(int id)
    {
        using var connexion = _bdd.CreerConnexion();

        // BONNE PRATIQUE (bloc 3, SEC1) : requête PARAMÉTRÉE.
        // On écrit @id dans le SQL, et on donne la valeur à part : new { id = id }.
        // MySQL ne mélange jamais la valeur avec la requête : impossible pour un
        // pirate d'y glisser du SQL (attaque par « injection SQL »).
        string sql = "SELECT * FROM restaurant WHERE id = @id";

        // QuerySingleOrDefault : renvoie l'objet trouvé, ou null s'il n'y en a pas.
        return connexion.QuerySingleOrDefault<Restaurant>(sql, new { id = id });
    }
}
