using System.Collections.Generic;
using System.Text.Json;
using Microsoft.EntityFrameworkCore;
using StandardRail.RailCarLounge.Models.Entities;

namespace StandardRail.RailCarLounge.Data.SqlServer.SeedData
{
    public static class CountryData
    {
        public static void CountrySeedData(ModelBuilder modelBuilder)
        {
            var jsonCountryList = Resource.Country;
            var countries = JsonSerializer.Deserialize<List<Country>>(jsonCountryList);
            modelBuilder.Entity<Country>().HasData(countries);
        }
    }
}
