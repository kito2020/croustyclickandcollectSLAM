using CroustyClickCollect.Models;

namespace CroustyClickCollect.Tests;

public class RestaurantCarteTests
{
    [Theory]
    [InlineData(48.863, 2.37)]
    [InlineData(-90, -180)]
    [InlineData(90, 180)]
    [InlineData(0, 12)]
    public void CoordonneesValides_PositionDansLesLimites_RetourneVrai(double latitude, double longitude)
    {
        var restaurant = new Restaurant { Latitude = latitude, Longitude = longitude };

        Assert.True(restaurant.CoordonneesValides);
    }

    [Theory]
    [InlineData(0, 0)]
    [InlineData(91, 2)]
    [InlineData(-91, 2)]
    [InlineData(48, 181)]
    [InlineData(48, -181)]
    public void CoordonneesValides_PositionInvalideOuAbsente_RetourneFaux(double latitude, double longitude)
    {
        var restaurant = new Restaurant { Latitude = latitude, Longitude = longitude };

        Assert.False(restaurant.CoordonneesValides);
    }

    [Fact]
    public void CoordonneesValides_ValeurNonFinie_RetourneFaux()
    {
        var restaurant = new Restaurant { Latitude = double.NaN, Longitude = 2.37 };

        Assert.False(restaurant.CoordonneesValides);
    }
}
