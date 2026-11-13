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
    private readonly HorairesService _horairesService;

    public RestaurantsController(RestaurantRepository restaurants, HorairesService horairesService)
    {
        _restaurants = restaurants;
        _horairesService = horairesService;
    }

    // Adresse : /Restaurants
    public IActionResult Index()
    {
        List<Restaurant> restaurants = _restaurants.GetTous();

        var heureActuelle = DateTime.Now.TimeOfDay;

        foreach (var r in restaurants)
        {
            r.EstOuvertMaintenant = _horairesService.EstOuvert(r, heureActuelle);
        }

        return View(restaurants);
    }
}