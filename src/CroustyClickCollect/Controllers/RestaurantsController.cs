using CroustyClickCollect.Data;
using CroustyClickCollect.Models;
using CroustyClickCollect.Services;
using Microsoft.AspNetCore.Mvc;

namespace CroustyClickCollect.Controllers;

/// <summary>
/// La page « Nos restaurants » (V3).
/// </summary>
public class RestaurantsController : Controller
{
    private readonly RestaurantRepository _restaurants;

    public RestaurantsController(RestaurantRepository restaurants)
    {
        _restaurants = restaurants;
    }

    // Adresse : /Restaurants
    public IActionResult Index()
    {
        List<Restaurant> restaurants = _restaurants.GetTous();

        var heureActuelle = DateTime.Now.TimeOfDay;

        foreach (var r in restaurants)
        {
            r.EstOuvertMaintenant = HorairesService.EstOuvert(
                r.HeureOuverture,
                r.HeureFermeture,
                heureActuelle);
        }

        return View(restaurants);
    }
}
