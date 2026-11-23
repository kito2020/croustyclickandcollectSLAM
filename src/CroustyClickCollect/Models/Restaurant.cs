namespace CroustyClickCollect.Models;

/// <summary>
/// Un restaurant du réseau (table « restaurant »).
/// </summary>
public class Restaurant
{
    public int Id { get; set; }
    public string Nom { get; set; }
    public string Adresse { get; set; }
    public string CodePostal { get; set; }
    public string Ville { get; set; }
    public string Telephone { get; set; }
    public TimeSpan HeureOuverture { get; set; }   // TimeSpan = une heure de la journée, ex. 11:30
    public TimeSpan HeureFermeture { get; set; }
    public bool CommandesActives { get; set; }
    public double Latitude { get; set; }
    public double Longitude { get; set; }

    /// <summary>
    /// Indique si les coordonnées peuvent être affichées sur la carte.
    /// Le couple (0, 0) sert de valeur par défaut pour les restaurants sans position.
    /// </summary>
    public bool CoordonneesValides =>
        double.IsFinite(Latitude)
        && double.IsFinite(Longitude)
        && (Latitude != 0 || Longitude != 0)
        && Math.Abs(Latitude) <= 90
        && Math.Abs(Longitude) <= 180;

    // Cette propriété n'est PAS une colonne de la table : elle est calculée
    // par le controller au moment d'afficher la page (voir TODO S2-04).
    public bool EstOuvertMaintenant { get; set; }
}
