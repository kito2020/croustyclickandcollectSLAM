namespace CroustyClickCollect.Services;

/// <summary>
/// Règles liées aux horaires des restaurants.
/// Un « service » contient les RÈGLES MÉTIER : pas de SQL, pas de HTML.
/// C'est ce qui permet de les tester facilement (voir le dossier tests/).
/// </summary>
public static class HorairesService
{
    /// <summary>
    /// Indique si un restaurant est ouvert à une heure donnée.
    /// Exemple : ouvert de 11:30 à 23:00 → ouvert à 11:30 et à 22:59,
    /// fermé à 11:29 et à 23:00.
    /// </summary>
    public static bool EstOuvert(TimeSpan ouverture, TimeSpan fermeture, TimeSpan heure)
    {
        return heure >= ouverture && heure < fermeture;
    }
}
