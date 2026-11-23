using CroustyClickCollect.Models;

namespace CroustyClickCollect.Tests;

public class RestaurantCarteTests
{
    [Theory]
    [InlineData(48.863, 2.37)]
    [InlineData(-90, -180)]
    [InlineData(90, 180)]
    [InlineData(0, 12)]
    [InlineData(-90, 0)]
    [InlineData(0, -180)]
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
    [InlineData(90.000001, 2)]
    [InlineData(-90.000001, 2)]
    [InlineData(48, 180.000001)]
    [InlineData(48, -180.000001)]
    public void CoordonneesValides_PositionInvalideOuAbsente_RetourneFaux(double latitude, double longitude)
    {
        var restaurant = new Restaurant { Latitude = latitude, Longitude = longitude };

        Assert.False(restaurant.CoordonneesValides);
    }

    [Theory]
    [InlineData(double.NaN, 2.37)]
    [InlineData(48.863, double.NaN)]
    [InlineData(double.PositiveInfinity, 2.37)]
    [InlineData(double.NegativeInfinity, 2.37)]
    [InlineData(48.863, double.PositiveInfinity)]
    [InlineData(48.863, double.NegativeInfinity)]
    public void CoordonneesValides_ValeurNonFinie_RetourneFaux(double latitude, double longitude)
    {
        var restaurant = new Restaurant { Latitude = latitude, Longitude = longitude };

        Assert.False(restaurant.CoordonneesValides);
    }

    [Fact]
    public void CoordonneesValides_UnSeulZero_RetourneVrai()
    {
        var restaurant = new Restaurant { Latitude = 0, Longitude = 2.37 };

        Assert.True(restaurant.CoordonneesValides);
    }
}
